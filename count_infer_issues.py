#!/usr/bin/env python

import argparse
import json

parser = argparse.ArgumentParser(description='Parse infer output.')
parser.add_argument('report_file', help='the json file with infer report')
parser.add_argument('--bug_type', action="store", type=str, default=None)
# parser.add_argument('--sum', dest='accumulate', action='store_const',
#                    const=sum, default=max,
#                    help='sum the integers (default: find the max)')

    
def get_issues_of_type(report, bug_type):
    return filter(lambda x: x.get('bug_type')==bug_type , report)
    

def get_issues_count(report, bug_type=None):
    if bug_type:
        return len(get_issues_of_type(report, bug_type))
    return len(report)

args = parser.parse_args()
with open(args.report_file) as report_json:    
    report = json.load(report_json)
    


print "%d"%get_issues_count(report, args.bug_type)