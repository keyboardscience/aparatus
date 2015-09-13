# Quick test of ansible filter extension

from __future__ import absolute_import

import math
import collections
from ansible import errors

def dict_union(a, b):
    a.update(b)
    return a

class FilterModule(object):
    ''' Ansible Dictionary Manipulation jinja2 filters '''

    def filters(self):
        return {
            # dictionary manipulation filters
            'dict_union': dict_union,

        }

