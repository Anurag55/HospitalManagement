authorization do

  role :admin do

    has_permission_on :admins, :to=>[:index, :show_doctors, :show_patients, :show_appointments, :show_patientrecords, :assign_beds_form, :assign_beds]
    has_permission_on :admits, :to=>[:index, :new, :create, :discharge_patient_form, :list_beds]
    has_permission_on :rooms,   :to=>[:index, :new, :create, :show, :edit, :update, :destroy]
    has_permission_on :beds,   :to=>[:index, :new, :create, :show, :edit, :update, :destroy]
    has_permission_on :departments, :to=>[:index, :new, :create]
    has_permission_on :records, :to=> [:new, :create]
    has_permission_on :timeslots,   :to=>[:index, :new, :create, :show, :list_doctors]
    has_permission_on :users, :to=>[:new, :create]
  end

  role :patient do

    has_permission_on :patients, :to=> [:index, :new, :create, :edit, :update, :show, :destroy, :get_appointments, :show_slots, :create_appointment, :show_appointments, :show_profile]

  end

  role :doctor do

    has_permission_on :doctors, :to=>[:index, :new, :create, :edit, :update, :show_appointments, :show_patients, :show_timeslots, :show_slots, :show_profile]
    has_permission_on :medical_records, :to=>[:index, :new, :create, :edit, :update]


  end

  role :guest do

    has_permission_on :users, :to=>[:new, :create]


  end


end
