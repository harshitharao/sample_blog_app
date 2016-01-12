class Blog < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def fetch_title_word_frequencies
    title_words = Blog.all.pluck(:title).join(' ').split(' ')
    words_hash = Hash.new(0)
    title_words.each do |word|
      words_hash[word.downcase] += 1
    end
    words_hash
  end
end
