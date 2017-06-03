defmodule ExOneroster.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: ExOneroster.Repo

  # data = base_setup
  def base_setup do
    org = insert(:org)
    child_org = insert(:org, parent_id: org.id)
    grandchild_org_one = insert(:org, parent_id: child_org.id)
    grandchild_org_two = insert(:org, parent_id: child_org.id)

    top_parent_academic_session = insert(:academic_session)
    child_with_children_academic_session = insert(:academic_session, parent_id: top_parent_academic_session.id)
    # 2 children academic sessions
    sub_sub_child_academic_session_one = insert(:academic_session, parent_id: child_with_children_academic_session.id)
    sub_sub_child_academic_session_two = insert(:academic_session, parent_id: child_with_children_academic_session.id)

    course = insert(:course, org_id: org.id, academic_session_id: top_parent_academic_session.id)
    class = insert(:class, org_id: org.id, org: org, course_id: course.id, course: course)
    term_one = insert(:term, class_id: class.id, academic_session_id: child_with_children_academic_session.id)
    term_two = insert(:term, class_id: class.id, academic_session_id: sub_sub_child_academic_session_one.id)

    agent = insert(:user)
    user = insert(:user, identifiers: [build(:identifier), build(:identifier)])
    insert(:agent, agent_id: agent.id, user_id: user.id)
    insert(:affiliation, org_id: org.id, user_id: user.id)
    resource = insert(:resource, class_id: class.id, course_id: course.id)
    %{
      org: org,
      child_org: child_org,
      grandchild_org_one: grandchild_org_one,
      grandchild_org_two: grandchild_org_two,
      parent_academic_session: top_parent_academic_session,
      sub_child_academic_session: child_with_children_academic_session,
      sub_sub_child_academic_session_one: sub_sub_child_academic_session_one,
      sub_sub_child_academic_session_two: sub_sub_child_academic_session_two,
      course: course,
      class: class,
      term_one: term_one,
      term_two: term_two,
      user: user,
      agent: agent,
      resource: resource
    }
  end

  def org_factory do
    %ExOneroster.Organizations.Org{
      dateLastModified: DateTime.utc_now,
      identifier: UUID.uuid1,
      metadata: %{"ncesId" => "8892928234", "classification" => "private", "boarding" => "true", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      name: UUID.uuid1,
      parent_id: nil,
      sourcedId: UUID.uuid1,
      status: "active",
      type: "national",
      children: [],
      parent: nil
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
      schoolYear: 2019,
      children: [],
      parent: nil
    }
  end

  def course_factory do
    %ExOneroster.Courses.Course{
      sourcedId: UUID.uuid1,
      status: "active",
      dateLastModified: DateTime.utc_now,
      metadata: %{"ncesId" => "COURSE123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      title: "2019 Chemistry",
      courseCode: "CHEM101",
      grades: ["PR", "09", "10"],
      subjects: "chemistry",
      org_id: nil,
      academic_session_id: nil
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
      subjectCodes: ["CHEM101", "CHE-A", "C-1"],
      periods: ["1", "3", "5"],
      class_terms: [],
      course_id: 1,
      course: nil,
      org_id: 1,
      org: nil,
      terms: []
    }
  end

  def term_factory do
    %ExOneroster.Classes.Term{
      class_id: 1,
      academic_session_id: 1
    }
  end

  def resource_factory do
    %ExOneroster.Resources.Resource{
      applicationId: UUID.uuid1,
      dateLastModified: DateTime.utc_now,
      importance: "secondary",
      metadata: %{"ncesId" => "RES123", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      roles: ["guardian", "parent", "teacher", "relative", "aide", "administrator"],
      sourcedId: UUID.uuid1,
      status: "active",
      title: "Organic Chemistry",
      vendorId: UUID.uuid1,
      vendorResourceId: UUID.uuid1
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
      dateLastModified: DateTime.utc_now,
      email: "007@jamesbond.org",
      enabledUser: true,
      familyName: "Bond",
      givenName: "James",
      grades: ["PR", "09", "10"],
      metadata: %{"ncesId" => "USR007", "http://www.imsglobal.org/memberLevel" => "http://www.imsglobal.org/memberLevel/associate"},
      middleName: "Herbert",
      password: "goldeneye",
      phone: "1-555-cal-bond",
      role: "guardian",
      sms: "1-555-cal-bond",
      sourcedId: UUID.uuid1,
      status: "active",
      username: "bondj"
    }
  end

  def identifier_factory do
    %ExOneroster.Users.Identifier{
      user_id: 1,
      type: "LDAP",
      identifier: UUID.uuid1
    }
  end

  def agent_factory do
    %ExOneroster.Users.Agent{
      user_id: 1,
      agent_id: 2,
    }
  end

  def affiliation_factory do
    %ExOneroster.Users.Affiliation{
      user_id: 1,
      org_id: 1,
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
