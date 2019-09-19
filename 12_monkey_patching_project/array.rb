# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    
    def span
        return nil if self.empty?

        self.max - self.min
    end


    def average
        return nil if self.empty?

        self.sum / (self.length * 1.0)
    end

    def median
        if self.length.odd?
            mid_index = self.length / 2
            return self.sort[mid_index]
        else
            sorted = self.sorted
            mid_index = self.length / 2
            first_ele = sorted[mid_index]
            second_ele = sorted[mid_index - 1]
            return (first_ele + second_ele) / 2.0
        end
    end

    def counts
        count = Hash.new(0)
        self.each {|ele| count[ele] += 1}
        count
    end

    def mu_count(target)
        count = 0
        self.each do |ele|
            if ele == target 
                count += 1
            end
        end
        count
    end

    def my_index(target)
        self.each_with_index do |ele, index|
            if ele == target
                return index
            end
        end
        nil
    end
    
    def my_uniq
        hash = {}
        self.each {|ele| hash[ele] = true}
        hash.keys
    end
    
    def my_transose
        my_arr = []

        (0...self.length).each do |row|
            new_row = []
            (0...self.length).each do |col|
                new_row << self[col][row]
            end
            my_arr << new_row
        end

        my_arr
    end
  
end
