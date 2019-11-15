import time;
import random;

#start = '2000-01-01 12:00:00';
#end = '2019-11-07 12:00:00';
format_str = '%Y-%m-%d %H:%M:%S';


def generate_time(start,end):
	start_time = time.mktime(time.strptime(start, format_str));
	end_time = time.mktime(time.strptime(end,format_str));

	rand_num = random.random();

	randTime = start_time + rand_num*(end_time-start_time);

	randTime_formatted = time.strftime(format_str, time.localtime(randTime));

	return randTime_formatted


