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
    attr_accessor :book

    def initialize(id, author, year, status, name)
        @book = {
            id: id,
            author: author,
            year: year,
            status: status,
            name: name
        }
    end

    def book_info
        puts "id: #{@book[:id]}, author: #{@book[:author]}, year: #{@book[:year]}, status: #{@book[:status]}, name: \"#{@book[:name]}\". "
    end

    def with_attr?(req_key, req_value)
        @book[req_key] == req_value ? true : false
    end

end


class Library
    attr_accessor :status
    attr_reader :id, :author, :year, :name

    def initialize
        @arr_books = []
    end

    def acquire_book(book)
        @arr_books << book
    end

    def find_book(req_key, req_value)
       @arr_books.select { |book|  book.with_attr?(req_key, req_value) }
    end

    def get_book(req_key, req_value)
        find_book(req_key, req_value).each { |book| book.book_info }
    end

    def change_status(id_value, new_status)
        @arr_books.each { |elem|  elem.book[:status] = new_status if elem.book[:id] == id_value }
    end 
    
    def library_info
        @arr_books.each { |book| book.book_info }
    end
end

library1 = Library.new
book1 = Book.new(1, 'J.K. Rowling', 2000, 'available', 'Harry Potter and the Goblet of Fire')
book2 = Book.new(2, 'Leo Tolstoy', 1867, 'available', 'War and Peace')
book3 = Book.new(3, 'Lewis Carroll', 1865, 'available', 'Alice in Wonderland')
book4 = Book.new(4, 'J.K. Rowling', 1987, 'available', 'Harry Potter and the Philosopher Stone')

[book1, book2, book3, book4].each { |book| library1.acquire_book(book) }

library1.library_info
library1.get_book(:id, 3)
library1.change_status(4, 'not available')
library1.get_book(:author, 'J.K. Rowling')
