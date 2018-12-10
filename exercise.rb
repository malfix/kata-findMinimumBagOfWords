require 'set'

class Exercise
  LOWER_IDX = -1

  def initialize(*dictionary)
    @dict = Set.new()
    @max_dictionary_length = 0
    dictionary.each do |word|
      @dict.add(word)
      @max_dictionary_length = [@max_dictionary_length, word.length-1].max
    end
  end

  def find(text)
    @solutions = [text]
    last_token_lenght = @max_dictionary_length
    while (last_solution_token_is_not_a_word)
      return nil if there_are_no_solutions
      decrement_index_from(last_token_lenght).downto(LOWER_IDX) do |idx|
        if there_are_no_more_words(idx)
          last_token_lenght = join_last_2_elements
          break
        end
        if exist_word_to(idx)
          last_token_lenght = split_last_solution_on(idx)
          break
        end
      end
    end
    @solutions
  end

  def last_solution_token_is_not_a_word
    !@dict.include?(@solutions.last)
  end

  def there_are_no_solutions
    !@solutions.last
  end

  def decrement_index_from(prev_token_lenght)
    [prev_token_lenght, last_token_length].min
  end

  def join_last_2_elements
    last_length = @solutions[second_to_last_idx].length - 2
    @solutions[second_to_last_idx] = "#{@solutions[second_to_last_idx]}#{@solutions[last_element_idx]}"
    @solutions.delete_at(last_element_idx)
    last_length
  end

  def second_to_last_idx
    @solutions.size - 2
  end

  def last_element_idx
    @solutions.size - 1
  end

  def last_token_length
    @solutions.last.length - 1
  end

  def split_last_solution_on(idx)
    existing_word = @solutions.last[0..idx]
    remaining_string = @solutions.last[idx+1..-1]
    @solutions[last_element_idx] = existing_word
    @solutions << remaining_string
    @max_dictionary_length
  end

  def exist_word_to(idx)
    @dict.include?(@solutions.last[0..idx])
  end

  def there_are_no_more_words(idx)
    idx == LOWER_IDX
  end
end
