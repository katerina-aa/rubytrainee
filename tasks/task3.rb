# frozen_string_literal: true

# Create class Library
# Library has list of books(hash)
# Each book is stored by its id with following keys if present - id, author, year, status(available or not), name
class Book
  attr_accessor :author, :year, :name

  def initialize(author, year, name)
    @author = author
    @year = year
    @name = name
  end

  def show_info
    "author: #{@author}, year: #{@year}, name: \"#{@name}\""
  end
end

# Class should be able to:
# - find book by name, author or id
# - change status of book
# - acquire new book
class Library
  attr_accessor :arr_books, :counter, :status

  def initialize
    @hash_library = {}
    @counter = 0
    @status = 'available'
  end

  def add(book)
    @counter += 1
    @hash_library[@counter] = { info: book, status: @status }
  end

  def find_book(opts)
    result = {}
    books = @hash_library
    opts.each do |key, value|
      return print_book(value, books[value]) if key == :id

      result = find_book_by(books, key, value)
      books = result
    end
    result.each_pair { |key, value| print_book(key, value) }
  end

  def find_book_by(hash, req_key, req_value)
    hash.select { |_, value| value[:info].send(req_key) == req_value }
  end

  def print_book(key, value)
    puts "ID: #{key}, #{value[:info].show_info}, status: #{value[:status]}"
  end

  def change_status(id_value, new_status)
    @hash_library[id_value][:status] = new_status
  end

  def library_info
    puts 'Library info:'
    @hash_library.each_pair { |key, value| print_book(key, value) }
  end
end

library1 = Library.new
book1 = Book.new('J.K. Rowling', 2000, 'Harry Potter and the Goblet of Fire')
book2 = Book.new('Leo Tolstoy', 1867, 'War and Peace')
book3 = Book.new('Lewis Carroll', 1865, 'Alice in Wonderland')
book4 = Book.new('J.K. Rowling', 1867, 'Harry Potter and the Philosopher Stone')

[book1, book2, book3, book4].each { |book| library1.add(book) }

library1.library_info
library1.find_book({ id: 3 })
library1.change_status(4, 'not available')
library1.find_book({ year: 1867, author: 'J.K. Rowling' })
