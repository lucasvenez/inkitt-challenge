import pandas as pd
#
# Importing data
#
visit = pd.read_csv('data/visits.csv')
read  = pd.read_csv('data/reading.csv')
story = pd.read_csv('data/stories.csv')

read['tracking_time'] = pd.to_datetime(read['tracking_time'])
read['created_at']    = pd.to_datetime(read['created_at'])

print("=================================================")
print("VISITS")
for _, column in visit.iteritems():
   print(column.name + ': ' + str(column.dtype))

print("=================================================")
print("READING")
for _, column in read.iteritems():
   print(column.name + ': ' + str(column.dtype))

print("=================================================")
print("STORIES")
for _, column in story.iteritems():
   print(column.name + ': ' + str(column.dtype))

# Write the same query in Python and possibly with Pandas or Numpy;
# or write it in R if you feel more comfortable.
#
# Write an SQL query that sums up reading for horror readers by day:
# Task 1.1 - How much did they read?
result = read.merge(story.rename(columns={'id':'story_id'}), on='story_id', how='inner')
horror_filter = (result['category_one'].str.lower() == 'horror') | (result['category_two'].str.lower() == 'horror')
result = result[horror_filter]
result = result.groupby([result['tracking_time'].dt.date])
print(result.count()['visitor_id'])

# Write the same query in Python and possibly with Pandas or Numpy;
# or write it in R if you feel more comfortable.
#
# Write an SQL query that sums up reading for horror readers by day:
# Task 1.2 - How many readers are there?
print(result.nunique()['visitor_id'])

# Write the same query in Python and possibly with Pandas or Numpy;
# or write it in R if you feel more comfortable.
#
# Write an SQL query that sums up reading for horror readers by day:
# Task 1.3 - What country are the readers from?
#
# WARNING! Maybe there is an inconsistence into Visit or Read tables. Data into
# Read.visitorId or Visit.visitorId columns do not match each other.
# Changing Read.visitorId by Read.visitId generated the expected output.
#
result = read.merge(story.rename(columns={'id':'story_id'}), on='story_id', how='inner')
result = result.merge(visit.rename(columns={'visitor_id': 'visit_id'}), on='visit_id', how='inner')
result = result[horror_filter]
result = result.groupby([result['tracking_time'].dt.date]).apply(lambda x : set(x.country))
print(result)
