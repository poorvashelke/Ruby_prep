def all_words_capitalized?(words)
    words.all? { |word| word.capitalize == word}
end

def aba_translate(words)
    valid_endings = ['.com', '.net', '.io', '.org']

    urls.none? do |url|
        valid_endings.any? { |ending| url.end_with?(ending)}
    end
end

def aba_translate(students)
    students.any? do |student|
        grades = student[:grades]
        avg = grades.sum / (grades.length * 1.0)
        avg >= 75
    end
end