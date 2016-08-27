# A company has six hiring positions with more people wanting jobs than the
# number of available positions.  The company managers decide in order to give
# more people an opportunity to make money; they will allow people to work in
# three-month intervals. The first six people on the waiting list will be hired
# in the order that they are on the waiting list.  The first six people will
# keep these positions for three months.  At the end of three months, the
# manager will roll a dice to determine the number of people who will lose their
# jobs. The company will use the policy of last-hired-first-fired.  For example,
# if the dice roll is 3, the last 3 people hired will lose their jobs to the
# first 3 people on the waiting list. People losing their jobs will be placed on
# the back of the waiting list in the order that they are fired. This process
# will continue for every three-month interval.

require_relative 'Stack'
require_relative 'Queue'

class Company
  attr_accessor :working, :waiting_list, :store

  def initialize # initialize with an array of waitlist
    list = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven"]
    @waiting_list = Queue.new
    @working = Stack.new

    # populate waiting list
    list.each do |i|
      @waiting_list.enqueue(i)
    end

    # populate current workers and remove from waiting list
    6.times do |worker|
      @working.push(list[worker])
      @waiting_list.dequeue
    end
  end

  # fire and hire
  def three_months
    @dice_roll = rand(1..6)
    puts "This month we will be losing and gaining #{ @dice_roll } employee(s). Better luck next time!"
    fire(@dice_roll)
    hire(@dice_roll)
  end

  # move from current workers to wait list
  def fire(num)
    num.times do
      @waiting_list.enqueue(@working.top)
      @working.pop
    end
  end

  # move from wait list to current workers list
  def hire(num)
    num.times do
      @working.push(@waiting_list.front)
      @waiting_list.dequeue
    end
  end

end
