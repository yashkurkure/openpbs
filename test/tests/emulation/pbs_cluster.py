from ptl.utils.pbs_logutils import PBSLogUtils
from tests.emulation import *
import pandas as pd
import time

swf_columns = [
    'id',             #1
    'submit',         #2
    'wait',           #3
    'run',            #4
    'used_proc',      #5
    'used_ave_cpu',   #6
    'used_mem',       #7
    'req_proc',       #8
    'req_time',       #9
    'req_mem',        #10 
    'status',         #11
    'user_id',        #12
    'group_id',       #13
    'num_exe',        #14
    'num_queue',      #15
    'num_part',       #16
    'num_pre',        #17
    'think_time',     #18
]

def read_jobs_swf(path):
    data = []
    with open(f'{path}', 'r') as file:
        for line in file:
        
            # TODO: For now ignoring the header of the swf file
            if line[0] == ';':
                continue

            # Split the line into elements, convert non-empty elements to integers
            row = [int(x) for x in line.split() if x]
            data.append(row)
    df = pd.DataFrame(data, columns=swf_columns)
    return df


"""
Run using:
pbs_benchpress -t TestCluster.test_fifo_32 -o test_fifo_32.txt
"""
class TestCluster(EmulationTest):
    """
    Creates a 

    Runs various tests on the cluster with different jobs.
    """

    @timeout(3600)
    def test_fifo_32(self):
        """
        Test FIFO scheduling with 32 nodes and 8 cpus per node.
        """

        # Initialize the cluster
        self.init_cluster(32, 8)

        # Configure sched for FIFO
        self.scheduler.set_sched_config({'strict_ordering': 'True',
                                         'by_queue': 'False'})
        
        self.server.manager(MGR_CMD_SET, SERVER, {'scheduling': 'False'})

        a = {'Resource_List.select': '16:ncpus=8', ATTR_queue: 'workq'}
        j = Job(TEST_USER, a)
        j.set_sleep_time(10)
        j1id = self.server.submit(j)
        j2id = self.server.submit(j)
        j3id = self.server.submit(j)

        # Turn scheduling on again
        self.server.manager(MGR_CMD_SET, SERVER, {'scheduling': 'True'})

        # j1 and j2 should be running
        self.server.expect(JOB, {ATTR_state: 'R'}, id=j1id, max_attempts=10)
        self.server.expect(JOB, {ATTR_state: 'R'}, id=j2id, max_attempts=10)
        self.server.expect(JOB, {ATTR_state: 'Q'}, id=j3id, max_attempts=10)

        # Wait for the jobs j1 and j2 to finish
        time.sleep(10)

        self.server.expect(JOB, {ATTR_state: 'R'}, id=j3id, max_attempts=10)


        # Read the swf file
        # jobs_df = read_jobs_swf('test/data/swf/32.swf')

    