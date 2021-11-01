=begin

Create class Library
Library has list of books(hash)
Each book is stored by its id with following keys if present - id, author, year, status(available or not), name
Class should be able to:
- find book by name, author or id
- change status of book
- acquire new book 

=end

class Library
    attr_accessor :status
    attr_reader :id, :author, :year, :name

    def initialize()
        @arr_books = []
    end

    def acquire_book(id, author, year, status, name)
        @book = {
            id: id,
            author: author,
            year: year,
            status: status, 
            name: name
        }
        @arr_books << @book
    end

    def find_book(req_key, req_value)
        @arr_books.each do |book| 
            book.each_pair do |key, value|
                return book if key == req_key and value == req_value
            end
        end
    end

    def find_book_author(author_value)
        arr_books = []
        @arr_books.each do |book| 
            book.each_pair do |key, value|
                arr_books << book if key == :author and value == author_value
            end
        end
        return arr_books
    end

    def change_status(id_value, new_status)
        @arr_books.each do |book| 
            book.each_pair do |key, value|
                book[:status] = new_status if key == :id and value == id_value
            end
        end
    end 
    
    def get
        puts @arr_books
    end

    def get_book(req_key, req_value)
        if req_key == :author
            puts find_book_author(req_value)
        else 
            puts find_book(req_key, req_value)
        end
    end

end

library1 = Library.new
library1.acquire_book(1, 'J.K. Rowling', 2000, 'available', 'Harry Potter and the Goblet of Fire')
library1.acquire_book(2, 'Leo Tolstoy', 1867, 'available', 'War and Peace')
library1.acquire_book(3, 'Lewis Carroll', 1865, 'available', 'Alice in Wonderland')
library1.acquire_book(4, 'J.K. Rowling', 1987, 'available', 'Harry Potter and the Philosopher Stone')

library1.get()
library1.get_book(:id, 3)
library1.change_status(4, 'not available')
library1.get_book(:author, 'J.K. Rowling')
