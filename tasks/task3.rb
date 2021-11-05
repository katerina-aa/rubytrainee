=begin

Create class Library
Library has list of books(hash)
Each book is stored by its id with following keys if present - id, author, year, status(available or not), name
Class should be able to:
- find book by name, author or id
- change status of book
- acquire new book 

=end

class Book
    attr_accessor :id, :author, :year, :status, :name

    def initialize(author, year, status, name)
        @author = author
        @year = year
        @status = status
        @name = name
        @id = 0
    end

    def book_info
        "ID: #{id}, author: #{@author}, year: #{@year}, status: #{@status}, name: \"#{@name}\"."
    end

    def define_id(num)
        @id = num
    end
end


class Library
    attr_accessor :arr_books,  :counter

    def initialize
        @arr_books = []
        @counter = 0 
    end

    def add(book)
        @counter += 1
        book.define_id(@counter)
        @arr_books << book
    end

    def find_book(opts)
        result = []
        book_array = @arr_books
        opts.each do |key, value| 
            result = find_book_by(book_array, key, value) 
            book_array = result
        end
        return result
    end
    
    def find_book_by(array,  key, value) 
        array.select { |book| book.send(key) == value }
    end

    def print_book(opts)
        find_book(opts).each { |book| puts book.book_info }
    end

    def change_status(id_value, new_status)
        @arr_books.each { |elem|  elem.status = new_status if elem.id == id_value }
    end 
    
    def library_info
        puts "Library info:"
        @arr_books.each { |book| puts book.book_info }
    end
end

library1 = Library.new
book1 = Book.new('J.K. Rowling', 2000, 'available', 'Harry Potter and the Goblet of Fire')
book2 = Book.new('Leo Tolstoy', 1867, 'available', 'War and Peace')
book3 = Book.new('Lewis Carroll', 1865, 'available', 'Alice in Wonderland')
book4 = Book.new('J.K. Rowling', 1987, 'available', 'Harry Potter and the Philosopher Stone')

[book1, book2, book3, book4].each { |book| library1.add(book) }

library1.library_info
library1.print_book({ id: 3 } )
library1.change_status(4, 'not available')
library1.print_book({ id: 4, author: 'J.K. Rowling' })
library1.print_book({  author: 'J.K. Rowling' })
