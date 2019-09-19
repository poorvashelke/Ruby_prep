def reverse(str, &prc)
    prc.call(str.reverse)
end

def word_changer(sentence, &prc)
    words = sentence.split(" ")
    new_words = []

    words.each do |word|
        new_words << prc.call(word)
    end

    new_words.join(" ")
end


def greater_proc_value(num, prc_1, prc_2)
    result_1 = prc_1.call(num)
    result_2 = prc_2.call(num)

    if result_1 > result_2
        return result_1
    else
        return result_2
    end
end

def and_selector(arr, prc_1, prc_2)
    selected = []

    arr.each do |ele|
        if prc_1.call(ele) && prc_2.call(ele)
            selected << ele
        end
    end

    selected
end

def alternating_mapper(arr, prc_1, prc_2)
    mapped = []

    arr.each_with_index do |ele, index|
        if index.even?
            mapped << prc_1.call(ele)
        else
            mapped << prc_2.call(ele)
        end
    end
    mapped
end