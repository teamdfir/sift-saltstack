#!/usr/bin/python
import sys
import os
import getopt
import struct

"""
Author: Gleeda <jamie.levy@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version
2 of the License, or (at your option) any later version.

jobparser.py
    Parses job files created from `at` commands

     -f <job>
     -d <directory of job files>
"""


# http://msdn.microsoft.com/en-us/library/2d1fbbab-fe6c-4ae5-bdf5-41dc526b2439%28v=prot.13%29#id11
products = {
    0x400:"Windows NT 4.0",
    0x500:"Windows 2000",
    0x501:"Windows XP",
    0x600:"Windows Vista",
    0x601:"Windows 7",
}

# http://winforensicaanalysis.googlecode.com/files/jobparse.pl
task_status = {
    0x41300:"Task is ready to run",
    0x41301:"Task is running",
    0x41302:"Task is disabled",
    0x41303:"Task has not run",
    0x41304:"No more scheduled runs",
    0x41305:"Properties not set",
    0x41306:"Last run terminated by user",
    0x41307:"No triggers/triggers disabled",
    0x41308:"Triggers do not have set run times",
}

weekdays = {
    0x0:"Sunday",
    0x1:"Monday",
    0x2:"Tuesday",
    0x3:"Wednesday", 
    0x4:"Thursday",
    0x5:"Friday",
    0x6:"Saturday",
}

months = {
    0x1:"Jan",
    0x2:"Feb",
    0x3:"Mar",
    0x4:"Apr",
    0x5:"May",
    0x6:"Jun",
    0x7:"Jul",
    0x8:"Aug",
    0x9:"Sep",
    0xa:"Oct",
    0xb:"Nov",
    0xc:"Dec",
}

# http://msdn.microsoft.com/en-us/library/cc248283%28v=prot.10%29
flags = {
    0x80:"TASK_APPLICATION_NAME",
    0x40000:"TASK_FLAG_RUN_ONLY_IF_LOGGED_ON",
    0x80000:"TASK_FLAG_SYSTEM_REQUIRED",
    0x100000:"TASK_FLAG_RESTART_ON_IDLE_RESUME",
    0x200000:"TASK_FLAG_RUN_IF_CONNECTED_TO_INTERNET",
    0x400000:"TASK_FLAG_HIDDEN",
    0x800000:"TASK_FLAG_RUN_ONLY_IF_DOCKED",
    0x1000000:"TASK_FLAG_KILL_IF_GOING_ON_BATTERIES",
    0x2000000:"TASK_FLAG_DONT_START_IF_ON_BATTERIES",
    0x4000000:"TASK_FLAG_KILL_ON_IDLE_END",
    0x8000000:"TASK_FLAG_START_ONLY_IF_IDLE",
    0x20000000:"TASK_FLAG_DISABLED",
    0x40000000:"TASK_FLAG_DELETE_WHEN_DONE",
    0x80000000:"TASK_FLAG_INTERACTIVE",
}

# http://msdn.microsoft.com/en-us/library/cc248286%28v=prot.10%29.aspx
priorities = {
    0x800000:"NORMAL_PRIORITY_CLASS",
    0x1000000:"IDLE_PRIORITY_CLASS",
    0x2000000:"HIGH_PRIORITY_CLASS", 
    0x4000000:"REALTIME_PRIORITY_CLASS",
}

class JobDate:
    def __init__(self, data, scheduled = False):
        # scheduled is the time the job was scheduled to run
        self.scheduled = scheduled
        self.Year = struct.unpack("<H", data[:2])[0]
        self.Month = struct.unpack("<H", data[2:4])[0]
        if not self.scheduled:
            self.Weekday = struct.unpack("<H", data[4:6])[0]
            self.Day = struct.unpack("<H", data[6:8])[0]
            self.Hour = struct.unpack("<H", data[8:10])[0]
            self.Minute = struct.unpack("<H", data[10:12])[0]
            self.Second = struct.unpack("<H", data[12:14])[0]
            self.Milliseconds = struct.unpack("<H", data[14:16])[0]
        else:
            self.Weekday = None
            self.Day = struct.unpack("<H", data[4:6])[0]
            self.Hour = struct.unpack("<H", data[12:14])[0]
            self.Minute = struct.unpack("<H", data[14:16])[0]
            self.Second = struct.unpack("<H", data[16:18])[0]
            self.Milliseconds = struct.unpack("<H", data[18:20])[0]


    def __repr__(self):
        day = weekdays.get(self.Weekday, None)
        mon = months.get(self.Month, None)
        if day != None and mon != None and not self.scheduled:
            return "{0} {1} {2} {3:02}:{4:02}:{5:02}.{6} {7}".format(day, mon, self.Day, self.Hour, self.Minute, self.Second, self.Milliseconds, self.Year)
        elif self.scheduled:
            return "{0} {1} {2:02}:{3:02}:{4:02}.{5} {6}".format(mon, self.Day, self.Hour, self.Minute, self.Second, self.Milliseconds, self.Year)
        return "Task not yet run"

# http://msdn.microsoft.com/en-us/library/aa379358%28v=vs.85%29.aspx
# http://msdn.microsoft.com/en-us/library/cc248286%28v=prot.10%29.aspx
class UUID:
    def __init__(self, data):
        self.UUID0 = struct.unpack("<I", data[:4])[0]
        self.UUID1 = struct.unpack("<H", data[4:6])[0]
        self.UUID2 = struct.unpack("<H", data[6:8])[0]
        self.UUID3 = struct.unpack(">H", data[8:10])[0]
        self.UUID4 = struct.unpack(">H", data[10:12])[0]
        self.UUID5 = struct.unpack(">H", data[12:14])[0]
        self.UUID6 = struct.unpack(">H", data[14:16])[0]

    def __repr__(self):
        return "{" + "{0:08X}-{1:04X}-{2:04X}-{3:04X}-{4:02X}{5:02X}{6:02X}".format(self.UUID0, self.UUID1, self.UUID2, 
                self.UUID3, self.UUID4, self.UUID5, self.UUID6) + "}"
        
# http://msdn.microsoft.com/en-us/library/cc248285%28PROT.10%29.aspx
class Job:
    def __init__(self, data):
        '''
        Fixed length section
        http://msdn.microsoft.com/en-us/library/cc248286%28v=prot.13%29.aspx
        '''
        self.ProductInfo = struct.unpack("<H", data[:2])[0]
        self.FileVersion = struct.unpack("<H", data[2:4])[0]
        self.UUID = UUID(data[4:20])
        self.AppNameLenOffset = struct.unpack("<H", data[20:22])[0]
        self.TriggerOffset = struct.unpack("<H", data[22:24])[0]
        self.ErrorRetryCount = struct.unpack("<H", data[24:26])[0]
        self.ErrorRetryInterval = struct.unpack("<H", data[26:28])[0]
        self.IdleDeadline = struct.unpack("<H", data[28:30])[0]
        self.IdleWait = struct.unpack("<H", data[30:32])[0]
        self.Priority = struct.unpack(">I", data[32:36])[0]
        self.MaxRunTime = struct.unpack("<i", data[36:40])[0]
        self.ExitCode = struct.unpack("<i", data[40:44])[0]
        self.Status = struct.unpack("<i", data[44:48])[0]
        self.Flags = struct.unpack(">I", data[48:52])[0]
        self.RunDate = JobDate(data[52:68])
        '''
        Variable length section
        http://msdn.microsoft.com/en-us/library/cc248287%28v=prot.10%29.aspx
        '''
        self.RunningInstanceCount = struct.unpack("<H", data[68:70])[0]
        self.NameLength = struct.unpack("<H", data[70:72])[0]
        self.cursor = 72 + (self.NameLength * 2)
        if self.NameLength > 0:
            self.Name = data[72:self.cursor].replace('\x00', "")
        self.ParameterSize = struct.unpack("<H", data[self.cursor:self.cursor + 2])[0]
        self.cursor += 2
        self.Parameter = ""
        if self.ParameterSize > 0:
            self.Parameter = data[self.cursor:self.cursor + self.ParameterSize * 2].replace("\x00", "")
            self.cursor += (self.ParameterSize * 2)
        self.WorkingDirectorySize = struct.unpack("<H", data[self.cursor:self.cursor + 2])[0]
        self.cursor += 2
        self.WorkingDirectory = "Working Directory not set"
        if self.WorkingDirectorySize > 0:
            self.WorkingDirectory = data[self.cursor:self.cursor + (self.WorkingDirectorySize * 2)].replace('\x00', "")
            self.cursor += (self.WorkingDirectorySize * 2)
        self.UserSize = struct.unpack("<H", data[self.cursor:self.cursor + 2])[0]
        self.cursor += 2
        self.User = "User not set"
        if self.UserSize > 0:
            self.User = data[self.cursor:self.cursor + self.UserSize * 2].replace("\x00", "")
            self.cursor += (self.UserSize * 2)
        self.CommentSize = struct.unpack("<H", data[self.cursor:self.cursor + 2])[0]
        self.cursor += 2
        self.Comment = "Comment not set"
        if self.CommentSize > 0:
            self.Comment = data[self.cursor:self.cursor + self.CommentSize * 2].replace("\x00", "")
            self.cursor += self.CommentSize * 2
        # this is probably User Data + Reserved Data:
        self.UserData = data[self.cursor:self.cursor + 18]
        self.cursor += 18
        # This isn't really documented, but this is the time the job was scheduled to run:
        self.ScheduledDate = JobDate(data[self.cursor:self.cursor + 20], scheduled = True)

    def _get_job_info(self):
        lines = []
        lines.append("Product Info: {0}".format(products.get(self.ProductInfo, "None")))
        lines.append("File Version: {0}".format(self.FileVersion))
        lines.append("UUID: {0}".format(self.UUID))
        priority = ""
        for p in priorities:
            if self.Priority & p == p:
                priority += priorities[p] + ", "
        if priority != "": 
            lines.append("Priorities: {0}".format(priority.rstrip(", ")))
        hours, ms = divmod(self.MaxRunTime, 3600000)
        minutes, ms = divmod(ms, 60000)
        seconds = ms / 1000
        lines.append("Maximum Run Time: {0:02}:{1:02}:{2:02}.{3} (HH:MM:SS.MS)".format(hours, minutes, seconds, ms))
        lines.append("Exit Code: {0}".format(self.ExitCode))
        lines.append("Status: {0}".format(task_status.get(self.Status, "Unknown Status")))
        theflags = ""
        for flag in flags:
            if self.Flags & flag == flag:
                theflags += flags[flag] + ", "
        lines.append("Flags: {0}".format(theflags.rstrip(", ")))
        lines.append("Date Run: {0}".format(self.RunDate))
        lines.append("Running Instances: {0}".format(self.RunningInstanceCount))
        lines.append("Application: {0}".format(self.Name))
        if self.Parameter != "": 
            lines.append("Parameters: {0}".format(self.Parameter))
        lines.append("Working Directory: {0}".format(self.WorkingDirectory))
        lines.append("User: {0}".format(self.User))
        lines.append("Comment: {0}".format(self.Comment))
        lines.append("Scheduled Date: {0}".format(self.ScheduledDate))
        return lines

    def __repr__(self):
        lines = ""
        lines += "Product Info: {0}\n".format(products.get(self.ProductInfo, "None"))
        lines += "File Version: {0}\n".format(self.FileVersion)
        lines += "UUID: {0}\n".format(self.UUID)
        priority = ""
        for p in priorities:
            if self.Priority & p == p:
                priority += priorities[p] + ", "
        if priority != "":
            lines += "Priorities: {0}\n".format(priority.rstrip(", "))
        hours, ms = divmod(self.MaxRunTime, 3600000)
        minutes, ms = divmod(ms, 60000)
        seconds = ms / 1000
        lines += "Maximum Run Time: {0:02}:{1:02}:{2:02}.{3} (HH:MM:SS.MS)\n".format(hours, minutes, seconds, ms)
        lines += "Exit Code: {0}\n".format(self.ExitCode)
        lines += "Status: {0}\n".format(task_status.get(self.Status, "Unknown Status"))
        theflags = ""
        for flag in flags:
            if self.Flags & flag == flag:
                theflags += flags[flag] + ", "
        lines += "Flags: {0}\n".format(theflags.rstrip(", "))
        lines += "Date Run: {0}\n".format(self.RunDate)
        lines += "Running Instances: {0}\n".format(self.RunningInstanceCount)
        lines += "Application: {0}\n".format(self.Name)
        if self.Parameter != "":
            lines += "Parameters: {0}\n".format(self.Parameter)
        lines += "Working Directory: {0}\n".format(self.WorkingDirectory)
        lines += "User: {0}\n".format(self.User)
        lines += "Comment: {0}\n".format(self.Comment)
        lines += "Scheduled Date: {0}\n".format(self.ScheduledDate)
        return lines
        

def usage():
    print "jobparser.py:\n"
    print " -f <job>"
    print " -d <directory of job files>"

def main():
    file = None
    dir = None
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hf:d:", ["help", "file=", "dir="])
    except getopt.GetoptError, err:
        print str(err)
        sys.exit(2)
    for o, a in opts:
        if o in ("-h", "--help"):
            usage()
            sys.exit(2)
        elif o in ("-f", "--file"):
            if os.path.isfile(a):
                file = open(a, "rb")
            else:
                print a + " is not a file"
                usage()
                return
        elif o in ("-d", "--dir"):
            dir = a
        else:
            assert False, "unhandled option\n\n"
            sys.exit(2)

    if file == None and dir == None:
        usage()
        return
    
    if dir != None and os.path.isdir(dir):
        for fname in os.listdir(dir):
            if fname.endswith(".job") and os.path.isfile(os.path.join(dir, fname)):
                file = open(os.path.join(dir, fname), "rb")
                try:
                    job = Job(file.read(0x2000))
                    print "*" * 72
                    print "File: " + os.path.join(dir, fname)
                    print job
                    print "*" * 72
                except:
                    print "Unable to process file: " + os.path.join(dir, fname)

        file = None


    # I'm not sure what's the largest a job file can be, but I'm setting a limit 
    # just to avoid accidental imports of large files
    elif file != None:
        data = file.read(0x2000)
        job = Job(data)
        print job

if __name__ == "__main__":
    main()

