# == Schema Information
#
# Table name: teachers
#
#  id          :integer      not null, primary key
#  dept_id     :integer
#  name        :string
#  phone       :integer
#  mobile      :string
#
# Table name: depts
#
#  id          :integer      not null, primary key
#  name        :string       not null

require_relative './sqlzoo.rb'

def null_dept
  # List the teachers who have NULL for their department.
  execute(<<-SQL)
  select name from teachers
  where dept_id is null
  SQL
end

def all_teachers_join
  # Use a type of JOIN that will list all teachers and their department,
  # even if the department in NULL/nil.
  execute(<<-SQL)
  select teachers.name, depts.name from teachers
  left join depts on teachers.dept_id = depts.id 
  SQL
end

def all_depts_join
  # Use a different JOIN so that all departments are listed.
  # NB: you can avoid RIGHT OUTER JOIN (and just use LEFT) by swapping
  # the FROM and JOIN tables.
  execute(<<-SQL)
  select teachers.name, depts.name from teachers
  right join depts on teachers.dept_id = depts.id 
  SQL
end

def teachers_and_mobiles
  # Use COALESCE to print the mobile number. Use the number '07986
  # 444 2266' if no number is given. Show teacher name and mobile
  # #number or '07986 444 2266'
  execute(<<-SQL)
  select name, coalesce(mobile, '07986 444 2266') from teachers
  SQL
end

def teachers_and_depts
  # Use the COALESCE function and a LEFT JOIN to print the teacher name and
  # department name. Use the string 'None' where there is no
  # department.
  execute(<<-SQL)
  select teachers.name, coalesce(depts.name, 'None') from teachers
  left join depts on teachers.dept_id = depts.id

  SQL
end

def num_teachers_and_mobiles
  # Use COUNT to show the number of teachers and the number of
  # mobile phones.
  # NB: COUNT only counts non-NULL values.
  execute(<<-SQL)
  select count(name), count(mobile) from teachers
  SQL
end

def dept_staff_counts
  # Use COUNT and GROUP BY dept.name to show each department and
  # the number of staff. Structure your JOIN to ensure that the
  # Engineering department is listed.
  execute(<<-SQL)
  select depts.name, count(teachers.name) from teachers
  right join depts on teachers.dept_id = depts.id
  group by depts.name
  SQL
end

def teachers_and_divisions
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2 and 'Art' otherwise.
  execute(<<-SQL)
  select teachers.name,
  case
    when depts.id = 1 then 'Sci'
    when depts.id = 2 then 'Sci'
  else 'Art'
  end
  from teachers
  left join depts on teachers.dept_id = depts.id
  SQL
end

def teachers_and_divisions_two
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the teacher is in dept 1 or 2, 'Art' if the dept is 3, and
  # 'None' otherwise.
  execute(<<-SQL)
  select teachers.name,
  case 
  when depts.id = 1 then 'Sci'
  when depts.id = 2 then 'Sci' 
  when depts.id = 3 then 'Art' 
  else 'None'
  end
  from teachers
  left join depts on teachers.dept_id = depts.id
  SQL
end
