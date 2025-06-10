module Teachers
  module LeaveApplicationsHelper
    def application_status_class(status)
      case status
      when 'approved'
        'bg-green-100 text-green-800'
      when 'rejected'
        'bg-red-100 text-red-800'
      else
        'bg-yellow-100 text-yellow-800'
      end
    end
  end
end 