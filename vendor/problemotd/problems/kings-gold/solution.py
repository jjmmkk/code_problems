#!/usr/bin/python

#
#   From each village in villages (n) request (index) amount of gold bars.
#   =>
#     village 1: [?]
#   + village 2: [?, ?]
#   + village 3: [?, ?, ?]
#
#   Index of culprit is
#   (expected total gold bar weight - actual total gold bar weight)
#   =>
#     village 1: [1000]
#   + village 2: [999, 999]
#   + village 3: [1000, 1000, 1000]
#   =>
#   6000 - 5998 = 2
#   => village 2 is the culprit
#


import sys
from random import randint


input_count = raw_input("How many villages, my liege?\n> ")

try:
    village_count = int(input_count)
except ValueError:
    village_count = 0

if village_count < 2:
    print "We're an anarcho-syndicalist commune!"
    sys.exit()


secret_culprit = randint(1, village_count)
print "The mayor of village %s appears clammy." % secret_culprit


legal_weight = 1000
illegal_weight = 999

#   Sum of integer sequence 1,2,3...n is (n * (n + 1)) / 2
gold_bars_count = (village_count * (village_count + 1)) / 2

expected_total_weight = legal_weight * gold_bars_count
actual_total_weight = sum([x * (illegal_weight if x == secret_culprit else legal_weight) for x in range(1, village_count+1)])

revealed_culprit = expected_total_weight - actual_total_weight
print "Village %s has been relocated to nearby Dule Trees." % revealed_culprit
