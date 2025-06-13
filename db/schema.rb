# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_12_100724) do
  create_table "admission_details", force: :cascade do |t|
    t.integer "student_id", null: false
    t.string "aadhaar_number"
    t.string "ssmid_number"
    t.string "scholar_no"
    t.string "family_id"
    t.string "place_of_birth"
    t.string "nationality"
    t.string "mother_tongue"
    t.string "other_languages"
    t.string "category"
    t.string "subcategory"
    t.string "religion"
    t.string "father_name"
    t.string "father_mobile"
    t.string "father_email"
    t.string "father_occupation"
    t.integer "father_income"
    t.string "mother_name"
    t.string "mother_mobile"
    t.string "mother_email"
    t.string "mother_occupation"
    t.integer "mother_income"
    t.integer "total_family_income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_admission_details_on_student_id"
  end

  create_table "attendance_records", force: :cascade do |t|
    t.date "date", null: false
    t.string "status", null: false
    t.text "remarks"
    t.integer "school_class_id", null: false
    t.integer "student_id", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id", "student_id", "date"], name: "index_attendance_records_on_class_student_date", unique: true
    t.index ["school_class_id"], name: "index_attendance_records_on_school_class_id"
    t.index ["school_id"], name: "index_attendance_records_on_school_id"
    t.index ["student_id"], name: "index_attendance_records_on_student_id"
  end

  create_table "exam_results", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "exam_id", null: false
    t.integer "subject_id", null: false
    t.decimal "marks_obtained", precision: 5, scale: 2, null: false
    t.decimal "total_marks", precision: 5, scale: 2, null: false
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_results_on_exam_id"
    t.index ["student_id", "exam_id", "subject_id"], name: "index_exam_results_on_student_id_and_exam_id_and_subject_id", unique: true
    t.index ["student_id"], name: "index_exam_results_on_student_id"
    t.index ["subject_id"], name: "index_exam_results_on_subject_id"
  end

  create_table "exams", force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "school_class_id", null: false
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id"], name: "index_exams_on_school_class_id"
    t.index ["school_id"], name: "index_exams_on_school_id"
  end

  create_table "fees", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "due_date", null: false
    t.string "status", null: false
    t.date "payment_date"
    t.string "payment_method"
    t.integer "student_id", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_fees_on_school_id"
    t.index ["student_id"], name: "index_fees_on_student_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.integer "quantity", default: 0, null: false
    t.string "unit", null: false
    t.integer "minimum_quantity", default: 0, null: false
    t.text "description"
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id", "name"], name: "index_inventory_items_on_school_id_and_name", unique: true
    t.index ["school_id"], name: "index_inventory_items_on_school_id"
  end

  create_table "inventory_transactions", force: :cascade do |t|
    t.string "transaction_type", null: false
    t.integer "quantity", null: false
    t.date "date", null: false
    t.string "reference_number", null: false
    t.text "remarks"
    t.integer "inventory_item_id", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_inventory_transactions_on_inventory_item_id"
    t.index ["school_id", "reference_number"], name: "index_inventory_transactions_on_school_id_and_reference_number", unique: true
    t.index ["school_id"], name: "index_inventory_transactions_on_school_id"
  end

  create_table "leave_applications", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "school_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "reason", null: false
    t.string "status", default: "pending"
    t.text "admin_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "approved_by"
    t.text "rejection_reason"
    t.string "leave_type"
    t.string "contact_number"
    t.index ["school_id"], name: "index_leave_applications_on_school_id"
    t.index ["teacher_id"], name: "index_leave_applications_on_teacher_id"
  end

  create_table "notice_school_classes", force: :cascade do |t|
    t.integer "notice_id", null: false
    t.integer "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notice_id", "school_class_id"], name: "index_notice_school_classes_on_notice_id_and_school_class_id", unique: true
    t.index ["notice_id"], name: "index_notice_school_classes_on_notice_id"
    t.index ["school_class_id"], name: "index_notice_school_classes_on_school_class_id"
  end

  create_table "notices", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "priority", default: "medium"
    t.integer "school_id", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.index ["school_id", "start_date", "end_date"], name: "index_notices_on_school_id_and_start_date_and_end_date"
    t.index ["school_id"], name: "index_notices_on_school_id"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "teacher_id", null: false
    t.integer "salary_structure_id", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.decimal "basic_salary", precision: 10, scale: 2, null: false
    t.decimal "house_rent_allowance", precision: 10, scale: 2
    t.decimal "dearness_allowance", precision: 10, scale: 2
    t.decimal "travel_allowance", precision: 10, scale: 2
    t.decimal "medical_allowance", precision: 10, scale: 2
    t.decimal "total_salary", precision: 10, scale: 2, null: false
    t.string "status", default: "pending", null: false
    t.date "paid_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salary_structure_id"], name: "index_payslips_on_salary_structure_id"
    t.index ["school_id", "teacher_id", "month", "year"], name: "index_payslips_on_school_teacher_month_year", unique: true
    t.index ["school_id"], name: "index_payslips_on_school_id"
    t.index ["teacher_id"], name: "index_payslips_on_teacher_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.json "features_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_structures", force: :cascade do |t|
    t.integer "school_id", null: false
    t.integer "teacher_id", null: false
    t.decimal "basic_salary", precision: 10, scale: 2, null: false
    t.decimal "house_rent_allowance", precision: 10, scale: 2
    t.decimal "dearness_allowance", precision: 10, scale: 2
    t.decimal "travel_allowance", precision: 10, scale: 2
    t.decimal "medical_allowance", precision: 10, scale: 2
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id", "teacher_id"], name: "index_salary_structures_on_school_id_and_teacher_id", unique: true
    t.index ["school_id"], name: "index_salary_structures_on_school_id"
    t.index ["teacher_id"], name: "index_salary_structures_on_teacher_id"
  end

  create_table "school_classes", force: :cascade do |t|
    t.string "name", null: false
    t.string "grade", null: false
    t.string "section", null: false
    t.string "room_number", null: false
    t.integer "capacity", null: false
    t.integer "school_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "school_id"], name: "index_school_classes_on_name_and_school_id", unique: true
    t.index ["school_id"], name: "index_school_classes_on_school_id"
    t.index ["teacher_id"], name: "index_school_classes_on_teacher_id"
  end

  create_table "school_owner_schools", force: :cascade do |t|
    t.integer "school_owner_id", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_owner_schools_on_school_id"
    t.index ["school_owner_id", "school_id"], name: "index_school_owner_schools_on_school_owner_id_and_school_id", unique: true
    t.index ["school_owner_id"], name: "index_school_owner_schools_on_school_owner_id"
  end

  create_table "school_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_school_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_school_owners_on_reset_password_token", unique: true
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.integer "plan_id", null: false
    t.datetime "subscription_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_color", default: "#4F46E5"
    t.string "secondary_color", default: "#818CF8"
    t.string "accent_color", default: "#C7D2FE"
    t.string "background_color", default: "#FFFFFF"
    t.string "text_color", default: "#1F2937"
    t.json "features_enabled", default: []
    t.index ["plan_id"], name: "index_schools_on_plan_id"
  end

  create_table "student_classes", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id"], name: "index_student_classes_on_school_class_id"
    t.index ["student_id"], name: "index_student_classes_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "admission_number"
    t.string "class_section"
    t.date "date_of_birth"
    t.integer "school_id", null: false
    t.string "phone_number"
    t.integer "user_id", null: false
    t.integer "school_class_id"
    t.string "roll_number"
    t.string "gender"
    t.string "address"
    t.string "parent_name"
    t.string "parent_phone"
    t.string "parent_email"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["roll_number", "school_class_id"], name: "index_students_on_roll_number_and_school_class_id", unique: true
    t.index ["school_class_id"], name: "index_students_on_school_class_id"
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description", null: false
    t.integer "credits", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "school_id"], name: "index_subjects_on_code_and_school_id", unique: true
    t.index ["school_id"], name: "index_subjects_on_school_id"
  end

  create_table "teacher_attendances", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "school_id", null: false
    t.date "date", null: false
    t.string "status", null: false
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teacher_attendances_on_school_id"
    t.index ["teacher_id", "date"], name: "index_teacher_attendances_on_teacher_id_and_date", unique: true
    t.index ["teacher_id"], name: "index_teacher_attendances_on_teacher_id"
  end

  create_table "teacher_classes", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id"], name: "index_teacher_classes_on_school_class_id"
    t.index ["teacher_id"], name: "index_teacher_classes_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "password_digest", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "employee_id"
    t.integer "user_id", null: false
    t.string "qualification"
    t.integer "experience"
    t.string "specialization"
    t.string "gender"
    t.text "address"
    t.index ["email", "school_id"], name: "index_teachers_on_email_and_school_id", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "teaching_materials", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "school_class_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id"], name: "index_teaching_materials_on_school_class_id"
    t.index ["teacher_id"], name: "index_teaching_materials_on_teacher_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.string "day_of_week", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.string "room_number", null: false
    t.integer "school_id", null: false
    t.integer "school_class_id", null: false
    t.integer "subject_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_class_id", "day_of_week", "start_time", "end_time"], name: "index_timetables_on_class_and_time", unique: true
    t.index ["school_class_id"], name: "index_timetables_on_school_class_id"
    t.index ["school_id"], name: "index_timetables_on_school_id"
    t.index ["subject_id"], name: "index_timetables_on_subject_id"
    t.index ["teacher_id"], name: "index_timetables_on_teacher_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0, null: false
    t.integer "school_id", null: false
    t.integer "school_class_id"
    t.string "admission_number"
    t.string "class_section"
    t.date "date_of_birth"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["school_class_id"], name: "index_users_on_school_class_id"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "admission_details", "students"
  add_foreign_key "attendance_records", "school_classes"
  add_foreign_key "attendance_records", "schools"
  add_foreign_key "attendance_records", "students"
  add_foreign_key "exam_results", "exams"
  add_foreign_key "exam_results", "students"
  add_foreign_key "exam_results", "subjects"
  add_foreign_key "exams", "school_classes"
  add_foreign_key "exams", "schools"
  add_foreign_key "fees", "schools"
  add_foreign_key "fees", "students"
  add_foreign_key "inventory_items", "schools"
  add_foreign_key "inventory_transactions", "inventory_items"
  add_foreign_key "inventory_transactions", "schools"
  add_foreign_key "leave_applications", "schools"
  add_foreign_key "leave_applications", "teachers"
  add_foreign_key "notice_school_classes", "notices"
  add_foreign_key "notice_school_classes", "school_classes"
  add_foreign_key "notices", "schools"
  add_foreign_key "notices", "users"
  add_foreign_key "payslips", "salary_structures"
  add_foreign_key "payslips", "schools"
  add_foreign_key "payslips", "teachers"
  add_foreign_key "salary_structures", "schools"
  add_foreign_key "salary_structures", "teachers"
  add_foreign_key "school_classes", "schools"
  add_foreign_key "school_classes", "teachers"
  add_foreign_key "school_owner_schools", "school_owners"
  add_foreign_key "school_owner_schools", "schools"
  add_foreign_key "schools", "plans"
  add_foreign_key "student_classes", "school_classes"
  add_foreign_key "student_classes", "students"
  add_foreign_key "students", "school_classes"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "users"
  add_foreign_key "subjects", "schools"
  add_foreign_key "teacher_attendances", "schools"
  add_foreign_key "teacher_attendances", "teachers"
  add_foreign_key "teacher_classes", "school_classes"
  add_foreign_key "teacher_classes", "teachers"
  add_foreign_key "teachers", "schools"
  add_foreign_key "teachers", "users"
  add_foreign_key "teaching_materials", "school_classes"
  add_foreign_key "teaching_materials", "teachers"
  add_foreign_key "timetables", "school_classes"
  add_foreign_key "timetables", "schools"
  add_foreign_key "timetables", "subjects"
  add_foreign_key "timetables", "teachers"
  add_foreign_key "users", "school_classes"
  add_foreign_key "users", "schools"
end
