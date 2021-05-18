require "csv"
namespace :import_csv do
  desc "Tác vụ nhập dữ liệu CSV"
  task data: :environment do
    import_user
    import_course
    import_subject
  end
end

def import_user
  path = Rails.root.join("db", "csv", "csv_data.csv")
  list = []
  CSV.foreach(path, headers: true) do |row|
    list << {
      email: row["Email"],
      name: row["Name"],
      password: row["Password"],
      role: row["Role"],
      gender: row["Gender"],
      date_of_birth: row["Date of birth"],
      start_date: row["Start date"],
      end_time: row["End date"],
      deleted: row["Deleted"]
    }
  end
  puts "Bắt đầu quá trình nhập người dùng"
  begin
    User.create!(list)
    puts "Nhập xong!!"
  rescue ActiveModel::UnknownAttributeError
    puts "Nhập không thành công：UnknownAttributeError"
  end
end

def import_course
  path = Rails.root.join("db", "csv", "course_data.csv")
  list = []
  CSV.foreach(path, headers: true) do |row|
    list << {
      name: row["Name"],
      time: row["Time"],
      status: row["Status"],
      start_date: row["Start date"],
      end_date: row["End date"],
      image: row["Image"]
    }
  end
  puts "Bắt đầu quá trình nhập course"
  begin
    Course.create!(list)
    puts "Nhập xong!!"
  rescue ActiveModel::UnknownAttributeError
    puts "Nhập không thành công：UnknownAttributeError"
  end
end

def import_subject
  path = Rails.root.join("db", "csv", "subject_data.csv")
  list = []
  CSV.foreach(path, headers: true) do |row|
    list << {
      name: row["Name"],
      time: row["Time"],
      description: row["Description"],
      optional: row["Optional"],
      order: row["Order"],
      course_id: row["Course"]
    }
  end
  puts "Bắt đầu quá trình nhập subject"
  begin
    Subject.create!(list)
    puts "Nhập xong!!"
  rescue ActiveModel::UnknownAttributeError
    puts "Nhập không thành công：UnknownAttributeError"
  end
end
