# Volatility
#
# Authors:  Jared Atkinson 
# Contact:  <jared@invoke-ir.com> 
# Twitter:  @jaredcatkinson 
# Blog:     www.invoke-ir.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details. 
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 

import re
import volatility.plugins.common as common
import volatility.utils as utils
import volatility.win32.tasks as tasks
import volatility.conf as conf
config = conf.ConfObject()

class malsysproc(common.AbstractWindowsCommand):
    """Find malware hiding in plain sight as system processes"""
   
    # Add functionality to look for child processes that don't belong
    # Add functionality to deal with process injection
    # Test if network connections are occuring
    # Add functionality to deal with process owners
    # Look for cmd.exe running from weird processes
    # Tie winlogon/wininit with csrss

    def check_name(self, process, procname):
    # Check for lookalike processes
	return process.ImageFileName.lower() == procname	

    def check_path(self, process, path):
    # Ensure process is running from correct Path
	return str(process.Peb.ProcessParameters.ImagePathName).lower() == path
	    
    def check_ppid(self, process, parentpid):
    # Ensure process was created by correct parent
        if parentpid is None:
            return None
        else:
	    return process.InheritedFromUniqueProcessId == parentpid

    def check_time(self, process, name, ctime):
    # Ensure the process was created within 10 seconds of the parent process (have not performed complete testing for time)
	if name == "smss":
	    if ctime == None:    
		return True
	    else:
		return process.CreateTime <= ctime
	if name == "csrss" or name == "winlogon":
	    return None	
	return process.CreateTime < ctime + 60

    def check_priority(self, process, priority):
    # Ensure the process is running under the correct base priority
	return process.Pcb.BasePriority == priority

    def check_cmdline(self, process, cmdline):
    # Ensure the process is running with expected command line arguments
	if cmdline == "svchost":
	    # Create an array of expected command line arguments for svchost.exe
	    cmdline_array = ["-k secsvcs",
                             "-k networkservice",
                             "-k dcomlaunch",
                             "-k rpcss",
                             "-k netsvcs",
                             "-k localservice",
                             "-k imgsvc",
                             "-ktermsvcs",
                             "-k regsvc",
                             "-k winerr",
                             "-k tapisrv",
                             "-k httpfilter",
                             "-k secvcs",
                             "-k gpsvcgroup",
                             "-k iissvcs",
                             "-k apphost",
                             "-k localsystemnetworkrestricted",
                             "-k wersvcgroup"
                             ]
	    if str(process.Peb.ProcessParameters.ImagePathName).lower() == "c:\windows\system32\svchost.exe":
		cmdline = False		
		for arg in cmdline_array:
		    if arg in str(process.Peb.ProcessParameters.CommandLine).lower():
			cmdline = True
			break
	    else:
		cmdline = False
	    return cmdline
	elif "csrss" in cmdline:
            csrss_re = re.compile(cmdline)
            if csrss_re.search(str(process.Peb.ProcessParameters.CommandLine).lower()):
                return True
            else:
                return False
	else:
	    return str(process.Peb.ProcessParameters.CommandLine).lower() == cmdline

    def check_count(self, name, count):
	if name == "smss" or name == "lsass" or name == "services":
	    return count < 2
	else:
	    return True

    def build_lists(self):
	namelist = {}
	namelist['smss'] = "smss.exe"
	namelist['csrssXP'] = "csrss.exe"
	namelist['csrss7'] = "csrss.exe"
	namelist['winlogonXP'] = "winlogon.exe"
	namelist['winlogon7'] = "winlogon.exe"
	namelist['services'] = "services.exe"
	namelist['lsass'] = "lsass.exe"
	namelist['svchost'] = "svchost.exe"
	namelist['spoolsv'] = "spoolsv.exe"
	namelist['wininitXP'] = "wininit.exe"
	namelist['wininit7'] = "wininit.exe"

	pathlist = {}
	pathlist['smss'] = "\systemroot\system32\smss.exe"
	pathlist['csrssXP'] = "\??\c:\windows\system32\csrss.exe"
	pathlist['csrss7'] = "c:\windows\system32\csrss.exe"
	pathlist['winlogonXP'] = "\??\c:\windows\system32\winlogon.exe"
	pathlist['winlogon7'] = "c:\windows\system32\winlogon.exe"
	pathlist['services'] = "c:\windows\system32\services.exe"
	pathlist['lsass'] = "c:\windows\system32\lsass.exe"
	pathlist['svchost'] = "c:\windows\system32\svchost.exe"
	pathlist['spoolsv'] = "c:\windows\system32\spoolsv.exe"
	pathlist['wininitXP'] = "c:\windows\system32\wininit.exe"
	pathlist['wininit7'] = "c:\windows\system32\wininit.exe"

	prioritylist = {}
	prioritylist['smss'] = 11
	prioritylist['csrssXP'] = 13
	prioritylist['csrss7'] = 13
	prioritylist['winlogonXP'] = 13 
	prioritylist['winlogon7'] = 13 
	prioritylist['services'] = 9
	prioritylist['lsass'] = 9
	prioritylist['svchost'] = 8 
	prioritylist['spoolsv'] = 8
	prioritylist['wininitXP'] = 13
	prioritylist['wininit7'] = 13

	cmdlinelist = {}
	cmdlinelist['smss'] = "\systemroot\system32\smss.exe"
	cmdlinelist['csrssXP'] = r'^(c:\\windows|%systemroot%)\\system32\\csrss.exe objectdirectory=\\windows sharedsection=\d{2,4},\d{3,6},\d{2,4} windows=on subsystemtype=windows [(serverdll=basesrv,1 |serverdll=winsrv:userserverdllinitialization,3 |serverdll=winsrv:conserverdllinitialization,2 |serverdll=sxssrv=4 )]+profilecontrol=off maxrequestthreads=16'
	cmdlinelist['csrss7'] = r'^(c:\\windows|%systemroot%)\\system32\\csrss.exe objectdirectory=\\windows sharedsection=\d{2,4},\d{1,6},\d{2,4} windows=on subsystemtype=windows [(serverdll=basesrv,1 |serverdll=winsrv:userserverdllinitialization,3 |serverdll=winsrv:conserverdllinitialization,2 |serverdll=sxssrv=4 )]+profilecontrol=off maxrequestthreads=16'
	cmdlinelist['winlogonXP'] = "winlogon.exe"
	cmdlinelist['winlogon7'] = "winlogon.exe"
	cmdlinelist['services'] = "c:\windows\system32\services.exe"
	cmdlinelist['lsass'] = "c:\windows\system32\lsass.exe"
	cmdlinelist['svchost'] = "svchost"
	cmdlinelist['spoolsv'] = "c:\windows\system32\spoolsv.exe"
	cmdlinelist['wininitXP'] = "c:\windows\system32\wininit.exe"
	cmdlinelist['wininit7'] = "wininit.exe"

	return namelist, pathlist, prioritylist, cmdlinelist

    # Build the output object based on the process object, the process name, the parent process id, and the parent processes ctime
    def build_obj(self, process, name, parentpid, ctime, count, procname, path, priority, cmdline):	
	info = {}	        
	info['offset'] = process.obj_offset
	info['processname'] = str(process.ImageFileName)
	info['pid'] = process.UniqueProcessId
	info['name'] = self.check_name(process, procname)
	info['path'] = self.check_path(process, path)
	info['ppid'] = self.check_ppid(process, parentpid)
	info['time'] = self.check_time(process, name, ctime)
	info['priority'] = self.check_priority(process, priority)
	info['cmdline'] = self.check_cmdline(process, cmdline)
	info['count'] = self.check_count(name, count)
        info['time_val'] = ctime
        info['process_time_val'] = process.CreateTime
        info['cmdline_val'] = cmdline
        info['cmdline_svchost'] = str(process.Peb.ProcessParameters.CommandLine).lower()
	return info



    def calculate(self):
	kernel_space = utils.load_as(self._config)
	smsscounter = 0	
	lsasscounter = 0
	servicescounter = 0	
	winctime = None
	namelist, pathlist, prioritylist, cmdlinelist = self.build_lists()

        for process in tasks.pslist(kernel_space):

	    sysproc = False
	    # Capture 1970-01-01 00:00:00 in a variable for later comparison
	    if process.ImageFileName.lower() == "system":
		systemctime = process.CreateTime

	    # Look for non exited processes
	    if process.ExitTime <= systemctime:

	        # Look for a process that matches smss.exe with the possibility of the "ms" being switched around
	        # smss.exe is the session manager, and there should only be one copy of this at most times
	        # smss.exe is the child process of the System process who's PID is 4
	        if re.match(r's..s\.exe',str(process.ImageFileName).lower()) is not None:
		    sysproc = True
		    smsspid = process.UniqueProcessId
		    smssctime = process.CreateTime
		    smsscounter += 1
		    counter = smsscounter
		    name = 'smss'
		    parent = 4
		    ctime = winctime

	        # Look for a process that matches csrss.exe with the possiblity of the "srs" being switched around
	        # smss.exe is the parent of csrss.exe
	        elif re.match(r'c...s\.exe',str(process.ImageFileName).lower()) is not None:
		    sysproc = True
		    ctime = smssctime
		    counter = None
		    if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
		        parent = None
                        name = 'csrss7'
                    else:
		        parent = smsspid
                        name = 'csrssXP'

	        # Look for processes that look for winlogon.exe or winlogin.exe the second being an imposter
	        # smss.exe is the parent of winlogon.exe
	        # Should be one winlogon for each csrss.exe
	        elif re.match(r'winlog.n\.exe',str(process.ImageFileName).lower()) is not None:
                    sysproc = True
                    winlpid = process.UniqueProcessId
                    winctime = process.CreateTime
                    ctime = smssctime
                    counter = None		    
		    if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
                        parent = None
                        name = 'winlogon7'
                    else:
                        parent = smsspid
                        name = 'winlogonXP'

	        # In OS newer than XP lsass.exe and services.exe parent is wininit.exe
	        elif str(process.ImageFileName).lower() == "wininit.exe":
		    #if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
		    sysproc = True
	            winipid = process.UniqueProcessId
	            winctime = process.CreateTime
		    ctime = smssctime
		    counter = None
		    if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
                        parent = None
                        name = 'wininit7'
                    else:
	    	        parent = smsspid
                        name = 'wininitXP'
		    #else:
		        #print("WARNING: wininit.exe should not be running on this OS Version")

	        # In OS XP and prior lsass.exe's parent is winlogon.exe (XP) or wininit.exe (Vista)
	        elif str(process.ImageFileName).lower() == "services.exe":		
		    sysproc = True
		    servicespid = process.UniqueProcessId
		    servicesctime = process.CreateTime
		    servicescounter += 1
		    counter = servicescounter
		    name = 'services'
		    ctime = winctime
		    counter = None
		    if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
                        parent = winipid
                    else:
	    	        parent = winlpid

	        # Look for processes that look similar to lsass.exe, but may have the "sas" characters switched around
	        # In Windows XP and older winlogon.exe is the parent of lsass.exe
	        # In Windows Vista and newer wininit.exe is the parent of lsass.exe
 	        elif re.match(r'l...s\.exe',str(process.ImageFileName).lower()) is not None:
		    sysproc = True
		    lsasscounter += 1
		    counter = lsasscounter
		    name = 'lsass'
		    ctime = winctime
		    if "Win7" in config.PROFILE or "Vista" in config.PROFILE or "2008" in config.PROFILE:
                        parent = winipid
                    else:
	    	        parent = winlpid

	        # Look for processes that look similar to svchost.exe, but may have the "vc" characters switched around
	        # services.exe is the parent process for svchost.exe
	        elif re.match(r's..host\.exe',str(process.ImageFileName).lower()) is not None:
		    sysproc = True
		    name = 'svchost'
		    parent = servicespid
		    ctime = servicesctime
		    counter = None

	        # Look for processes that look similar to spoolsv.exe, but may have the "sv" characters switched around
	        # services.exe is the parent process for spoolsv.exe
	        elif re.match(r'spool..\.exe',str(process.ImageFileName).lower()) is not None:
		    sysproc = True
		    name = 'spoolsv'
		    parent = servicespid
		    ctime = servicesctime
		    counter = None

		if sysproc:
		    info = self.build_obj(process, name, parent, ctime, counter, namelist[name], pathlist[name], prioritylist[name], cmdlinelist[name])
		    yield info



    def render_text(self, outfd, data):
	print
	self.table_header(outfd, [("Offset", "[addrpad]"),
                                  ("ProcessName", "12"),
                                  ("PID", "5"),
                                  ("Name", "5"),
                                  ("Path", "5"),
                                  ("PPId", "5"),
                                  ("Time", "5"),
                                  ("Priority", "9"),
                                  ("Cmdline","7"),
				  ("Count","5")
                                  ])  
	for info in data:
	    self.table_row(outfd,
                           info['offset'],
			   info['processname'],
                           info['pid'],
			   str(info['name']),
			   str(info['path']),
		 	   str(info['ppid']),
			   str(info['time']),
			   str(info['priority']),
			   str(info['cmdline']),
			   str(info['count'])
                           )

            if self._config.VERBOSE and not (info['name'] and info['path'] and info['priority'] and info['time'] and info['cmdline'] and info['count']) or info['ppid'] == False:
                if info['processname'] == "svchost.exe":
                    outfd.write("{0:24s}: {1}\n".format("...Cmdline", info['cmdline_svchost']))
                else:
                    outfd.write("{0:24s}: {1}\n".format("...Cmdline", info['cmdline_val']))
                outfd.write("{0:24s}: {1}\n".format("...Expected Parent Time", info['time_val']))
                outfd.write("{0:24s}: {1}\n".format("...Create Time", info['process_time_val']))
	print
