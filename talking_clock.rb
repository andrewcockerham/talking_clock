def talking_clock(digital_time)
# TOTO: add chinese
# TODO: don't assume input is string
# TODO: add edge cases (midnight, noon, half past, etc)
# TODO: push to github

# split into hours/minuts
split_time = digital_time.split(':')
hours = split_time[0]
minutes = split_time[1]

# check if time is valid
check_valid_time(hours.to_i, minutes.to_i)

# check if am/pm
hours.to_i >= 12 ? am_pm = "pm" : am_pm = "am"

# convert hours to words
hours_words = convert_hours_to_words(hours.to_i % 12)

# convert minutes to words
minutes_words = convert_minutes_to_words(minutes)

p "(" + digital_time + ")"
p final_string_template = "It's #{hours_words} #{minutes_words} #{am_pm}"
`say "#{final_string_template}"`
end

# TODO: change to guard clause
def check_valid_time(hours, minutes)
  if hours > 24 || hours < 0
    raise ArgumentError.new('ERROR: invalid hours')
  elsif minutes > 59 || minutes < 0
    raise ArgumentError.new('ERROR: invalid minutes')
  end
end

def convert_hours_to_words(hours)
  @hours_map[hours]
end

def convert_minutes_to_words(minutes)
  if minutes[0].to_i == 0 && minutes[1].to_i == 0
    return "o'clock"
  elsif minutes.to_i.between?(10, 20)
    return @teens_map[minutes.to_i]
  else
    return convert_minutes_tens(minutes[0].to_i) + convert_minutes_ones(minutes[1].to_i)
  end
end

def convert_minutes_tens(minutes_tens)
  @minutes_tens_map[minutes_tens]
end

def convert_minutes_ones(minutes_ones)
  @minutes_ones_map[minutes_ones]
end

@hours_map = {
  0 => "twelve",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
  10 => "ten",
  11 => "eleven",
  12 => "twelve"
}

@minutes_tens_map = {
  0 => "oh ",
  1 => "one",
  2 => "twenty ",
  3 => "thirty ",
  4 => "forty ",
  5 => "fifty "
}

@minutes_ones_map = {
  0 => "",
  1 => "one",
  2 => "two",
  3 => "three",
  4 => "four",
  5 => "five",
  6 => "six",
  7 => "seven",
  8 => "eight",
  9 => "nine",
}

@teens_map = {
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fifteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen'
}

# tests

talking_clock("00:00")
talking_clock("01:30")
talking_clock("12:05")
talking_clock("14:01")
talking_clock("20:29")
talking_clock("21:00")
talking_clock("20:12")
talking_clock("7:59")

## below tests should raise an error
# talking_clock("15:89")
# talking_clock("26:00")
