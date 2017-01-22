# pstotal
# Copyright (C) 2014 Sue Stirrup
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

'''
Rewrite of and enhancements to the SANS(tm) Institute's text based pstotal plugin
based on Jesse Kornblum's original for Volatility 2.0.

@author:        Sue Stirrup
@license:       GNU General Public License 2.0 or later
@contact:       info@sans.org
@organization:  The SANS(tm) Institute
Amendments + enhancements
   *  Default behaviour to display complete list of processes (process scan)
		- Interesting column added to show processes hidden from pslist.
   *  Command line option to display only processes hidden from process list (original behaviour)
   *  Graphical visualisation option using Graphviz and .dot format via the command line added:
		- Command line option to display process command (graphical representation only)
		- Command line option to display process path name (graphical representation only)
		- Processes from prior boot rendered in light blue (with exit time before current boot or not available
		- Processes from prior boot rendered in medium blue (with exit time after current boot
		- Processes from current boot but hidden from pslist rendered in red
        - Suspected pid reuse rendered in yellow
'''

import volatility.plugins.filescan as filescan
import volatility.plugins.common as common
import volatility.utils as utils
import volatility.obj as obj
import volatility.win32.tasks as tasks
import pdb
import re

class pstotal(common.AbstractWindowsCommand):
    ''' Combination of pslist,psscan & pstree --output=dot gives graphical representation '''
    
    def __init__(self, config,*args, **kwargs):
        common.AbstractWindowsCommand.__init__(self, config, *args, **kwargs)
        config.add_option('SHORT', short_option = 'S', default = False, help = 'Interesting processes only', action = 'store_true')
        config.add_option('CMD', short_option = 'C', default = False, help = 'Display process command line. All {} removed', action = 'store_true')
        config.add_option('PATH', short_option = 'P', default = False, help = 'Display process image path', action = 'store_true')
    
    def render_text(self, outfd, data):
        processes = data[0]
        interest = data[1]
        outfd.write("Offset (P)     Name          PID    PPID   PDB        Time created             Time exited             Interesting \n" + \
                    "---------- ---------------- ------ ------ ---------- ------------------------ ------------------------ ----------- \n")

        if interest[processes[eprocess].obj_offset] == 1:
            interesting = 'TRUE'
        else:
            interesting = ' '
        outfd.write("0x{0:08x} {1:16} {2:6} {3:6} 0x{4:08x} {5:24} {6:24} {7:7}\n".format(
                processes[eprocess].obj_offset,
                processes[eprocess].ImageFileName,
                processes[eprocess].UniqueProcessId,
                processes[eprocess].InheritedFromUniqueProcessId,
                processes[eprocess].Pcb.DirectoryTableBase,
                processes[eprocess].CreateTime or '',
                processes[eprocess].ExitTime or '', interesting))
            
    def render_dot(self, outfd, data):
        objects = set()
        links = set()
        proc_seen = set()
        procs_to_check = set()
        proc_times = {}
        processes = data[0]
        filling = data[1]
        cmdline = data[2]
        pathname = data[3]
        smssTime = ' '
        
		# Obtain boot time 
        for proc in processes:
            proc_name = processes[proc].ImageFileName
            ppid = processes[proc].InheritedFromUniqueProcessId
            processp = "%s" % (processes[proc].UniqueProcessId)
            proc_times[processp] = processes[proc].CreateTime
            if proc_name.find("System") == 0 and processes[proc].CreateTime:
                smssTime = processes[proc].CreateTime
            elif proc_name.find("smss.exe") == 0 and ppid == 4:
                smssTime = processes[proc].CreateTime
			
        for eprocess in processes:
            proc_offset = processes[eprocess].obj_offset
            parentp = "%s" % (processes.get(eprocess).InheritedFromUniqueProcessId)			
            label = "{0} | offset (P)\\n0x{1:08x} | {2} | ".format(processes[eprocess].UniqueProcessId,
					                     proc_offset,
                                         processes[eprocess].ImageFileName)
			# Display process command line option
            if self._config.CMD :
                try:
                    if not processes[eprocess].CreateTime < smssTime:
                        s = "%s" % (cmdline[proc_offset])
                        s = s.replace('"', '')
                        s = s.replace('\\', '\\\\')
                        pos = s.find("csrss.exe")
                        if pos > 0:
                            pos = pos + 9
                            s = s[:pos] + "\\n (Run pstree to get command parameters)"
                        pos = s.find("conhost.exe")
                        if pos > 0:
                            pos = pos + 11
                            s = s[:pos] + "\\n (Run pstree to get command parameters)"
                        label += "command:\\n{0} | ".format(s or 'not available')
                        label = label.replace('{', '')
                        label = label.replace('}', '')
                except KeyError:
                    pass
			# Display process path option
            if self._config.PATH :
                try:
                    if not processes[eprocess].CreateTime < smssTime:
                        s = "%s" % (pathname[proc_offset])
                        s = s.replace('"', '')
                        s = s.replace('\\', '\\\\')
                        pos = s.find("csrss.exe")
                        if pos > 0:
                            pos = pos + 9
                            s = s[:pos] + "\\n (Run pstree to get command parameters)"
                        pos = s.find("conhost.exe")
                        if pos > 0:
                            pos = pos + 11
                            s = s[:pos] + "\\n (Run pstree to get command parameters)"
                        label += "path:\\n{0} | ".format(s or 'not available')
                except KeyError:
                    pass
            label += "created:\\n{0} |".format(processes[eprocess].CreateTime or 'not available')
			# Identify processes that have exited
            if processes[eprocess].ExitTime:
                label += "exited:\\n{0}".format(processes[eprocess].ExitTime)
                options = ' style = "filled" fillcolor = "lightgray" '
            else:
                label += "running"
                options = ''
			# Identify processes that are 'hidden' and relate to the current boot
            if filling[proc_offset] == 1:
                options = ' style = "filled" fillcolor = "red" '
			# Identify processes that are 'hidden' and relate to the previous boot 
            if processes[eprocess].CreateTime < smssTime and processes[eprocess].UniqueProcessId != 4:
                options = ' style = "filled" fillcolor = "lightblue" '
                if not processes[eprocess].ExitTime:
                    label = label[:-7]
                    label += "not available\\nprior boot"
				# Exit time is after current boot time
                elif processes[eprocess].ExitTime > smssTime:
                    options = ' style = "filled" fillcolor = "darkblue" '
            label = "{" + label + "}"
			# Sometimes windows creates duplicate process blocks - one in the doubly linked list and one scraped. We need to see both
            pid = "%s" % (processes[eprocess].UniqueProcessId)
            
            if pid in proc_seen:
                objects.add('pid{0}a [label="{1}" shape="record" {2}];\n'.format(processes[eprocess].UniqueProcessId,
                                                                            label, options))
                links.add("pid{0} -> pid{1}a [];\n".format(processes[eprocess].InheritedFromUniqueProcessId,
                                                      processes[eprocess].UniqueProcessId))
            else:
                proc_seen.add(pid)
                if parentp in proc_times and (processes.get(eprocess).CreateTime < proc_times[parentp]):
                    links.add("pid{0}r -> pid{1} [];\n".format(processes[eprocess].InheritedFromUniqueProcessId, processes[eprocess].UniqueProcessId))
                    parent = "%sr" % processes[eprocess].InheritedFromUniqueProcessId
                    if not parent in proc_seen:
                        proc_seen.add(parent)
                        objects.add('pid{0} [label="pid{1}"  shape="oval"  style = "filled" fillcolor = "yellow" ];\n'.format(parent, parentp))
                else:						
                    links.add("pid{0} -> pid{1} [];\n".format(processes[eprocess].InheritedFromUniqueProcessId,
                                                      processes[eprocess].UniqueProcessId))
                objects.add('pid{0} [label="{1}" shape="record" {2}];\n'.format(processes[eprocess].UniqueProcessId,
                                                                            label, options))
									
        ## Now write the dot file
        outfd.write("digraph processtree { \ngraph [rankdir = \"TB\"];\n")
        for link in links:
            outfd.write(link)

        for item in objects:
            outfd.write(item)
        outfd.write("}")
    
    def calculate(self):
        eproc = {}
        found = {}
        cmdline = {}
        pathname = {}
              
        # Brute force search for eproc blocks in pool memory
        address_space = utils.load_as(self._config)
        for eprocess in filescan.PSScan(self._config).calculate():
            eproc[eprocess.obj_offset] = eprocess
            found[eprocess.obj_offset] = 1
        
        # Walking the active process list.
        # Remove any tasks we find here from the brute force search if the --short option is set.
        # Anything left is something which was hidden/terminated/of interest.
        address_space = utils.load_as(self._config)
        for task in tasks.pslist(address_space):
            phys = address_space.vtop(task.obj_offset)
            if phys in eproc:
                if self._config.SHORT :
                    del eproc[phys]
                    del found[phys] 
                else:
                    found[phys] = 0                
                    
        # Grab command line and parameters            
            peb = task.Peb
            if peb:
                cmdline[phys] = peb.ProcessParameters.CommandLine
                pathname[phys] = peb.ProcessParameters.ImagePathName
                    
        ret = [eproc, found, cmdline, pathname]

        return ret
