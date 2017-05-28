defmodule ExOneroster.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: ExOneroster.Repo

  # data = base_setup
  def base_setup do
    top_parent_academic_session = insert(:academic_session)
    child_with_children_academic_session = insert(:academic_session, parent_id: top_parent_academic_session.id)
    # 2 children academic sessions
    sub_sub_child_academic_session_one = insert(:academic_session, parent_id: child_with_children_academic_session.id)
    sub_sub_child_academic_session_two = insert(:academic_session, parent_id: child_with_children_academic_session.id)

    %{
      parent_academic_session: top_parent_academic_session,
      sub_child_academic_session: child_with_children_academic_session,
      sub_sub_child_academic_session_one: sub_sub_child_academic_session_one,
      sub_sub_child_academic_session_two: sub_sub_child_academic_session_two
    }
  end

  def org_factory do
    %ExOneroster.Organizations.Org{
      dateLastModified: DateTime.utc_now,
      identifier: "IMS-HIGH-341",
      metadata: %{"ncesId" => "8892928234", "classification" => "private", "boarding" => "true", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      name: "IMS High",
      parent_id: nil,
      sourcedId: "SCH-ABF-0001",
      status: "active",
      type: "national"
    }
  end

  def academic_session_factory do
    %ExOneroster.AcademicSessions.AcademicSession{
      sourcedId: UUID.uuid1,
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "45454353453", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "2019 School Year",
      startDate: "2019-06-14",
      endDate: "2018-08-10",
      type: "schoolYear",
      parent_id: nil,
      schoolYear: 2019,
      children: [],
      parent: nil
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

  def resource_factory do
    %ExOneroster.Resources.Resource{
      applicationId: "anapp9876",
      dateLastModified: DateTime.utc_now,
      importance: "secondary",
      metadata: %{"ncesId" => "RES123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      roles: ["guardian", "parent", "teacher", "relative", "aide", "administrator"],
      sourcedId: "RESOURCE123-ABF-0001",
      status: "active",
      title: "Organic Chemistry",
      vendorId: "012",
      vendorResourceId: "345-67-543"
    }
  end

  def lineitem_factory do
    %ExOneroster.Lineitems.Lineitem{
      assignDate: DateTime.utc_now,
      category: "CAT123",
      class: "CLASS123-ABF-0001",
      dateLastModified: DateTime.utc_now,
      description: "Simple addition test",
      dueDate: DateTime.utc_now,
      gradingPeriod: "ACASESS123-ABF-0001",
      metadata: %{"ncesId" => "LI123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      resultValueMax: "10.0",
      resultValueMin: "0.0",
      sourcedId: "LI123-ABF-0001",
      status: "active",
      title: "Math Test 1"
    }
  end

  def lineitemcategory_factory do
    %ExOneroster.Lineitemcategories.LineItemCategory{
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "LICAT123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      sourcedId: "LICAT123-ABF-0001",
      status: "active",
      title: "Homework"
    }
  end

  def result_factory do
    %ExOneroster.Results.Result{
      comment: "Excellent",
      dateLastModified: DateTime.utc_now,
      lineitem: "LI123-ABF-0001",
      metadata: %{"ncesId" => "RES123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      score: "67.0",
      scoreDate: "2017-05-26",
      scoreStatus: "fully graded",
      sourcedId: "RES123",
      status: "active",
      student: "STU123"
    }
  end

  def enrollment_factory do
    %ExOneroster.Enrollments.Enrollment{
      beginDate: "2017-05-26",
      class: "CLASS123-ABF-0001",
      dateLastModified: DateTime.utc_now,
      endDate: "2019-05-26",
      metadata: %{"ncesId" => "RES123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      primary: "US234",
      role: "student",
      school: "SCH-ABF-0001",
      sourcedId: "ENR123",
      status: "active",
      user: "U123"
    }
  end

  def user_factory do
    %ExOneroster.Users.User{
      agents: ["002", "008"],
      dateLastModified: DateTime.utc_now,
      email: "007@jamesbond.org",
      enabledUser: true,
      familyName: "Bond",
      givenName: "James",
      grades: ["PR", "09", "10"],
      identifier: "007",
      metadata: %{"ncesId" => "USR007", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      middleName: "Herbert",
      orgs: ["SCH-ABF-0001"],
      password: "goldeneye",
      phone: "1-555-cal-bond",
      role: "guardian",
      sms: "1-555-cal-bond",
      sourcedId: "USR007",
      status: "active",
      type: "LDAP",
      userIds: ["james", "bond", "007"],
      username: "bondj"
    }
  end

  def demographic_factory do
    %ExOneroster.Demographics.Demographic{
      americanIndianOrAlaskaNative: true,
      asian: true,
      birthdate: "1968-04-13",
      blackOrAfricanAmerican: true,
      cityOfBirth: "Glencoe",
      countryOfBirthCode: "GB", # Scotland :)
      dateLastModified: DateTime.utc_now,
      demographicRaceTwoOrMoreRaces: true,
      hispanicOrLatinoEthnicity: true,
      metadata: %{"ncesId" => "DEM007nces", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      nativeHawaiianOrOtherPacificIslander: true,
      publicSchoolResidenceStatus: "01652",
      sex: "male",
      sourcedId: "DEM007",
      stateOfBirthAbbreviation: nil,
      status: "active",
      white: true
    }
  end

end
