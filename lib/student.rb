class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = "SELECT * FROM students"
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = "SELECT * FROM students WHERE name = ?"
    student_row = DB[:conn].execute(sql, name)[0]
    self.new_from_db(student_row)
  end
  def self.count_all_students_in_grade_9
    # method should return an array of all the students in grade 9.
      sql = "SELECT * FROM students WHERE grade = 9"
      DB[:conn].execute(sql)
    end

    def self.students_below_12th_grade
      # method should return an array of all the students below 12th grade.
      sql = "SELECT * FROM students WHERE grade < 12"
      DB[:conn].execute(sql)
    end	  end

    def self.first_x_students_in_grade_10(x)
    # This method should return an array of exactly X number of students.
    sql = "SELECT * FROM students WHERE grade = 10 LIMIT ?"
    DB[:conn].execute(sql, x)
  end

  def self.first_student_in_grade_10
    # This should return the first student that is in grade 10.
    sql = "SELECT * FROM students WHERE grade = 10 LIMIT 1"
    first_student_row = DB[:conn].execute(sql)[0]
    self.new_from_db(first_student_row)

    def self.all_students_in_grade_X(x)
    # This method should return an array of all students for grade X  
      sql = "SELECT * FROM students WHERE grade = ?"
      DB[:conn].execute(sql, x)
    end
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
