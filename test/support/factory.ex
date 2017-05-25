defmodule ExOneroster.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: ExOneroster.Repo

  def org_factory do
    %ExOneroster.Organizations.Org{
      dateLastModified: DateTime.utc_now,
      identifier: "IMS-HIGH-341",
      metadata: %{"ncesId" => "8892928234", "classification" => "private", "boarding" => "true", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      name: "IMS High",
      parent_id: nil,
      sourcedId: "9877728989-ABF-0001",
      status: "active",
      type: "national"
    }
  end

  def academic_session_factory do
    %ExOneroster.AcademicSessions.AcademicSession{
      sourcedId: "45454353453-ABF-0001",
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "45454353453", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "2019 School Year",
      startDate: "2019-06-14",
      endDate: "2018-08-10",
      type: "schoolYear",
      parent_id: nil,
      schoolYear: 2019
    }
  end

  def course_factory do
    %ExOneroster.Courses.Course{
      sourcedId: "COURSE123-ABF-0001",
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "COURSE123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "2019 Chemistry",
      courseCode: "CHEM101",
      grades: ["PR", "09", "10"],
      subjects: "chemistry",
      organization_id: 1,
      academic_session_id: 1
    }
  end

  def class_factory do
    %ExOneroster.Classes.Class{
      sourcedId: "CLASS123-ABF-0001",
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "CLASS123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "Basic Chemistry",
      classCode: "Chem101-Mr Rogers",
      classType: "homeroom",
      location: "room 19",
      grades: ["PR", "09", "10"],
      subjects: ["chemistry", "basic-chemistry", "chemistry-level-one"],
      course_id: 1,
      school_id: 1,
      terms: ["45454353453-ABF-0001", "TERM123-ABF-0001"],
      subjectCodes: ["CHEM101", "CHE-A", "C-1"],
      periods: ["1", "3", "5"]
    }
  end
end
