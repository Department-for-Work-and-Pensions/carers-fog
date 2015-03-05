#!/usr/bin/python

import icalendar
from datetime import * 

try:
  g = open('/tmp/ics.txt','rb')
except:
  print "Cannot open ics file"
  exit(-4)

todayDate = str(date.today())[:10]
todayTime = str(datetime.now())[:16]

try:
  calendar = icalendar.Calendar.from_ical(g.read())
except:
  print "Error opening ics file"
  exit(-5)

for event in calendar.walk('VEVENT'):
  dLong = 0
 
  sTest = str(event['DTSTART'].dt)
  if (len(sTest) == 10):
    pass
  elif (len(sTest) == 25):
    sTest = sTest[:16]
    dLong = 1
  else:
    print 'Bad start: ', sTest
    exit(-1)
    
  eTest = str(event['DTEND'].dt)
  if (len(eTest) == 10):
    if (dLong == 1):
      print 'Timed start but all day end? Cannot be!'
      exit(-2)
  elif (len(eTest) == 25):
    eTest = eTest[:16]
  else:
    print 'Bad end: ', eTest
    exit(-3)

  if (dLong == 0):
    if (sTest <= todayDate < eTest):
      print 'Event is today'
      exit(1)
  else:
    if (sTest <= todayTime <= eTest):
      print 'Event is now'
      exit(1)


g.close()

print 'No event now'  
exit(0)
