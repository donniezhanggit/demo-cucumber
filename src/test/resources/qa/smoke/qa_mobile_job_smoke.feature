@qa_mobile_job_smoke
Feature: 发布/修改职位/简历分享/详情

  Scenario: init
    When 保存一个变量key="{url}",value="http://api-qa.zhaopin.com"
    When 保存一个变量key="{phone_number}",value="qaautotest"
    When 保存一个变量key="{pwd}",value="zhaopin123"
#    When 保存一个变量key="{access_token}",value="39f63a75fe74414ba128bfc136dbe2f0"
#    When 保存一个变量key="{refresh_Token}",value="8b6f33f1f9c543b7a398d6f6509c7f8d"
    When 保存一个变量key="{jobtitle}",value="%E4%BA%BA%E5%B7%A5%E6%8C%96%E7%9F%B3%E6%B2%B9"
    # qa简历编号
    When 保存一个变量key="{resumenumber}",value="UdlE0XeKPbKLd6fGuJR6ezH2MqC0Ifbo"
    # 职位模板名称
    When 保存一个变量key="{jobmoduletitle}",value="jobmodule123"

  Scenario: 登录
#    When 等待1"分钟"
    When 保存一个变量key="{path}",value="/passport/login"
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 生产一个当前时间戳,以"{r}"命名保存
    When 生成一个md5key,以"{md5key}"命名保存
    When 调用POST_Json接口,testContent:"登录",url:"{url}{path}?r={r}&key={md5key}",param:"{'loginName':'{phone_number}','pwd':'{pwd}','checkId':'','checkCode':''}"
    Then json结果中包含"'code':200,'message':null,'success':true,'needCheckcode':false,'companyRegistered':true,'userStatus':20,'userType':153,'name':'{phone_number}'"
    When 把"data,accessToken"以"{access_token}"命名保存
    When 把"data,refreshToken"以"{refresh_Token}"命名保存

  Scenario: 发布职位
    When 设置cookie
    When 调用POST接口,url:"{url}/ihrapi/job2/jobadd?access_token={access_token}",param:"type=1&platsource=1&platpublishsource=1&enddate=30&quantity=12&monthsalary=0000001000&minyears=1099&mineducationlevel=1&jobtitle={jobtitle}&jobTypeMain=160400&subJobTypeMain=693&provinceid=560&cityid=10061&jobdescription=1%E3%80%81%20%E6%B2%B9%E6%B0%94%E8%97%8F%E5%8B%98%E6%8E%A2%E3%80%81%E8%AF%84%E4%BB%B7%E3%80%81%E5%82%A8%E9%87%8F%E3%80%81%E5%BC%80%E5%8F%91%E7%AD%89%E4%B8%9A%E5%8A%A1%E6%8A%80%E6%9C%AF%E5%88%86%E6%9E%90%EF%BC%9B%202%E3%80%81%E8%BE%85%E5%8A%A9%E9%A1%B9%E7%9B%AE%E5%AE%9E%E6%96%BD%EF%BC%9B%203%E3%80%81%E5%8D%8F%E5%8A%A9%E5%89%8D%E6%9C%9F%E6%8A%80%E6%9C%AF%E4%BA%A4%E6%B5%81%EF%BC%9B%204%E3%80%81%E5%AF%B9%E7%9B%B8%E5%85%B3%E5%9C%B0%E8%B4%A8%E6%96%B9%E5%90%91%E6%B6%89%E5%8F%8A%E5%9C%B0%E8%B4%A8%E9%97%AE%E9%A2%98%E8%BF%9B%E8%A1%8C%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81%E3%80%82%20%E4%BB%BB%E8%81%8C%E8%A6%81%E6%B1%82%EF%BC%9A%20%E6%9C%89%E5%9C%B0%E8%B4%A8%E6%89%80%E5%B7%A5%E4%BD%9C%E7%BB%8F%E9%AA%8C%EF%BC%8C%E6%88%96%E8%80%85%E5%9C%B0%E8%B4%A8%E7%B1%BB%E7%A0%94%E7%A9%B6%E9%A1%B9%E7%9B%AE%E7%BB%8F%E9%AA%8C%E3%80%82%E5%9C%B0%E8%B4%A8%E5%8F%8A%E7%9B%B8%E5%85%B3%E4%B8%93%E4%B8%9A%E4%BC%98%E5%85%88%E8%80%83%E8%99%91%EF%BC%81&benefit=10000,10001&workplace=哈尔滨&positionnature=1"
    Then 把"data,jobNumber"以"{jobNumber}"命名保存
    Then json结果中包含"'code':200,'data':{'haveBadWords':false,'jobNumber':'{jobNumber}','jobStyle':'CommonJob','jobTitle':'人工挖石油','jobmobileTopCount':0,'jobonsiteCount':0,'jobrefreshCount':0,'jobtimeCount':10,'jobtimetopCount':0,'jobtop':0,'packages':0,'result':'ok','userstatus':20},'message':'添加成功','success':true,'taskId':null"

  Scenario: 修改职位-增加智能刷新
    When 设置cookie
    When 调用POST接口,url:"{url}/ihrapi/job2/jobedit?access_token={access_token}",param:"type=2&jobpostionnumber={jobNumber}&dayRefreshDays=1&dayRefreshHour_hidden=10&dayRefreshTimes_hidden=1&dayRefreshSpan_hidden=60&dayRefreshMinu_hidden=01&isRefresh=1&isMobileTop=1&jobaddtop=1&platsource=1&platpublishsource=1&enddate=30&quantity=12&monthsalary=0000001000&minyears=1099&mineducationlevel=1&jobtitle=%E4%BA%BA%E5%B7%A5%E6%8C%96%E7%9F%B3%E6%B2%B9&jobTypeMain=160400&subJobTypeMain=693&provinceid=560&cityid=10061&jobdescription=1%E3%80%81%20%E6%B2%B9%E6%B0%94%E8%97%8F%E5%8B%98%E6%8E%A2%E3%80%81%E8%AF%84%E4%BB%B7%E3%80%81%E5%82%A8%E9%87%8F%E3%80%81%E5%BC%80%E5%8F%91%E7%AD%89%E4%B8%9A%E5%8A%A1%E6%8A%80%E6%9C%AF%E5%88%86%E6%9E%90%EF%BC%9B%202%E3%80%81%E8%BE%85%E5%8A%A9%E9%A1%B9%E7%9B%AE%E5%AE%9E%E6%96%BD%EF%BC%9B%203%E3%80%81%E5%8D%8F%E5%8A%A9%E5%89%8D%E6%9C%9F%E6%8A%80%E6%9C%AF%E4%BA%A4%E6%B5%81%EF%BC%9B%204%E3%80%81%E5%AF%B9%E7%9B%B8%E5%85%B3%E5%9C%B0%E8%B4%A8%E6%96%B9%E5%90%91%E6%B6%89%E5%8F%8A%E5%9C%B0%E8%B4%A8%E9%97%AE%E9%A2%98%E8%BF%9B%E8%A1%8C%E6%8A%80%E6%9C%AF%E6%94%AF%E6%8C%81%E3%80%82%20%E4%BB%BB%E8%81%8C%E8%A6%81%E6%B1%82%EF%BC%9A%20%E6%9C%89%E5%9C%B0%E8%B4%A8%E6%89%80%E5%B7%A5%E4%BD%9C%E7%BB%8F%E9%AA%8C%EF%BC%8C%E6%88%96%E8%80%85%E5%9C%B0%E8%B4%A8%E7%B1%BB%E7%A0%94%E7%A9%B6%E9%A1%B9%E7%9B%AE%E7%BB%8F%E9%AA%8C%E3%80%82%E5%9C%B0%E8%B4%A8%E5%8F%8A%E7%9B%B8%E5%85%B3%E4%B8%93%E4%B8%9A%E4%BC%98%E5%85%88%E8%80%83%E8%99%91%EF%BC%81&benefit=10000,10001&workplace=%E7%9F%B3%E6%B2%B3%E5%AD%90&positionnature=1"
    Then json结果中包含"'code':200,'data':{'haveBadWords':false,'jobNumber':'{jobNumber}','jobStyle':'CommonJob','jobTitle':'人工挖石油','jobmobileTopCount':0,'jobonsiteCount':0,'jobrefreshCount':0,'jobtimeCount':0,'jobtimetopCount':0,'jobtop':1,'packages':0,'result':null,'userMoney':0,'userstatus':20},'message':'操作成功','success':true,'taskId':null"

  Scenario: 创建简历分享
    When 设置cookie
    When 保存一个变量key="{path}",value="/appapi/user/createshareinfo"
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 生产一个当前时间戳,以"{r}"命名保存
    When 生成一个md5key,以"{md5key}"命名保存
    When 调用POST_Json接口,url:"{url}{path}?access_token={access_token}",param:"{'sharetype':1,'jobnumber':'{jobNumber}','jobtitle':'{jobtitle}','resumenumber':'{resumenumber}_1_1','resumesource':2}"
    Then json结果中包含"'code':200,'message':'','success':true"
    Then 把"data"以"{data}"命名保存

#    When 步骤:获取简历详情
#    When 设置cookie
#    When 调用GET接口,url:"{data}"
#    Then json结果中包含"'code':200,'data':{'detialJSonStr':'{\'ResumeId\':9,\'VersionNumber\':1,\'UserMasterId\':640832771,\'DisclosureLevel\':2,\'TemplateUrl\':\'\',\'ResumeName\':\'项目管理\\/项目协调11年甘肃\',\'ResumeSourceId\':0,\'WorkYearsRangeId\':200502,\'ResumeType\':1,\'TravelOption\':0,\'AvailableAfterDays\':0,\'DesiredSalaryScope\':100002000,\'DesiredEmploymentType\':\'2\',\'DesiredCity\':\'557\',\'DesiredIndustry\':\'140200\',\'DesiredCompanySize\':\'\',\'DesiredCompanyType\':\'\',\'CurrentCareerStatus\':1,\'IsPost\':\'n\',\'IsActive\':\'y\',\'IsEditable\':\'y\',\'ExposureCount\':0,\'HitCount\':0,\'DownloadCount\':0,\'PostCount\':0,\'Url\':\'\',\'CreatedBy\':640832771,\'ModifiedBy\':640832771,\'DateCreated\':\'\\/Date(1459475821533+0800)\\/\',\'DateModified\':\'\\/Date(1490612404293+0800)\\/\',\'DateLastViewed\':null,\'CurrentEducationLevel\':3,\'CurrentIndustry\':\'\',\'CurrentJobType\':\'\',\'EmployeesManaged\':0,\'CurrentSalary\':0,\'DateLastReleased\':\'\\/Date(1490612404293+0800)\\/\',\'IsRelease\':\'n\',\'ZpSourceId\':0,\'ResumeNumber\':\'JM408327710R90250000000\',\'DefaultResumeLanguage\':0,\'DefaultResumeDate\':null,\'LanguageId\':1,\'CompletionStatus\':11070,\'CommentTitle\':\'\',\'CommentContent\':\'\',\'GraduatedFrom\':\'四川大学\',\'CurrentMajorName\':\'社会体育\',\'CurrentCompanyName\':\'\',\'CurrentJobTitle\':\'\',\'Name\':\'resumeS.css\',\'Address1\':\'\',\'Address2\':\'\',\'AdditionalContactInfo\':\'\',\'UserMasterExtId\':\'JM408327710\',\'ShowPersonInfo\':\'y\',\'ShowResumeAttend\':\'y\',\'ExclusiveCompany\':\'\',\'OverdeaWorkExperience\':\'0\',\'PoliticsBackGround\':\'\',\'UploadPasteResumeType\':\'\',\'UploadPasteResumeSubType\':\'\',\'SelfEvaluate\':[],\'UserMasterName\':\'cd\',\'Gender\':\'2\',\'MaritalStatus\':\'\',\'CountryId\':\'\',\'ProvinceId\':\'540\',\'CityId\':\'540\',\'CityName\':\'\',\'NationalityId\':\'489\',\'HuKouProvinceId\':\'543\',\'HuKouCityId\':\'698\',\'HuKouCityName\':\'\',\'BirthYear\':\'1988\',\'PostalCode\':\'\',\'MaxEducationLevel\':\'3\',\'ComPletionDegree\':[{\'CompletionStatus\':\'1\',\'ItemsCompletion\':\'1|2|1|2|1|2|2|2|2|2|2|2|2|2|2\',\'ItemsScore\':\'20|0|14|14|0|0|0|0|0|0|0|0|0|22|0\',\'LanguageId\':\'1\',\'SubRowId\':\'1\',\'TotasScore\':\'70\'},{\'CompletionStatus\':\'0\',\'ItemsCompletion\':\'0\',\'ItemsScore\':\'\',\'LanguageId\':\'2\',\'SubRowId\':\'2\',\'TotasScore\':\'0\'}],\'DesiredPosition\':[{\'CurrentCareerStatus\':\'1\',\'DesiredCity\':\'557\',\'DesiredEmploymentType\':\'2\',\'DesiredIndustry\':\'140200\',\'DesiredJobType\':\'201300\',\'DesiredSalaryScope\':\'0100002000\',\'SubRowId\':\'1\'}],\'WorkExperience\':[],\'EducationExperience\':[{\'DateEnd\':\'2005-5-01\',\'DateStart\':\'2002-2-01\',\'EducationLevel\':\'3\',\'IsSeriesIncurs\':1,\'MajorBigType\':\'71\',\'MajorName\':\'社会体育\',\'MajorSmallType\':\'514\',\'SchoolName\':\'四川大学\',\'SubRowId\':\'1\'}],\'LanguageSkill\':[],\'Training\':[],\'AdvancedManagement\':[],\'ProjectExperience\':[],\'ProfessionnalSkill\':[],\'PracticeExperience\':[],\'PasteResumeText\':[],\'UploadResumeFile\':[],\'AchieveCertificate\':[],\'AssistantAccessory\':[],\'AchieveScholarship\':[],\'AchieveAward\':[],\'StudyInformation\':[],\'Other\':[],\'ReferalPersonId\':null,\'EliteStatus\':1}','hasread':null,'jobEndTime':0,'jobId':0,'jobName':null,'jobNo':null,'jobStatus':0,'mark':null,'resumeGrade':0,'resumeId':null,'resumeJobId':null,'resumeLanguage':null,'resumeNo':'','resumeSource':null,'resumeStatus':null,'resumeVersion':null,'resumerId':null,'resumerName':null,'testTag':null,'userDetials':{'birthDay':'','birthMonth':'3','birthStr':'1988年3月','birthYear':'29','cityDistrictId':'0','cityId':'540','countryId':null,'dateLastLogin':'/Date(1459475769483+0800)/','email':'','gender':'2','hOUKOUProvinceId':'543','hUKOUCityId':'698','maritalStatus':'5','mobilePhone':'','nationalityId':'489','photo':'','politicsBackground':'','provinceStateId':'540','status':'1','userMasterId':'640832771','userName':'cd','workYearsRangeId':'12年'}},'message':'简历信息查询成功','success':true"

  Scenario: 职位下线
    When 设置cookie
    When 调用POST接口,url:"{url}/ihrapi/job/jobdownline?access_token={access_token}",param:"jobNumber={jobNumber}"
    Then json结果中包含"'code':200,'message':'职位下线成功','success':true"

    When 步骤:职位删除
    When 设置cookie
    When 调用POST接口,url:"{url}/ihrapi/job/jobdelete?access_token={access_token}",param:"jobNumber={jobNumber}"
    Then json结果中包含"'code':200,'message':'职位删除成功','success':true"


  Scenario: 添加职位模板
    When 设置cookie
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 保存一个变量key="{path}",value="/appapi/jobtemplate/jobtemplateadd"

    When 调用POST_Json接口,testContent:"添加职位模板",url:"{url}{path}?access_token={access_token}",param:"{'jobtitle':'{jobmoduletitle}','jobTypeMain':'160400','subJobTypeMain':'693','monthsalary':'0000001000','positionnature':2,'workplace':'哈尔滨','provinceid':560,'cityid':10061,'cqid':'','quantity':2,'mineducationlevel':'1','minyears':'1099','jobdescription':'这是职位描述','benefit':'10000,10001','enddate':30}"
    Then json结果中包含"'code':200,'message':null,'success':true"
    Then 把"data"以"{data}"命名保存

    When 步骤: 获取职位模板详情
    When 设置cookie
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 保存一个变量key="{path}",value="/appapi/jobtemplate/jobtemplatedetail"
    When 调用GET接口,url:"{url}{path}?access_token={access_token}&id={data}"
    Then json结果中包含"'code':200,'message':'success','data':{'jobTitle':'{jobmoduletitle}','jobType':693,'jobAture':2,'maxSalary':1000,'minSalary':0,'salaryName':'0000001000','city':10061,'cqId':0,'jobAddress':'哈尔滨','quantity':2,'minEducation':1,'minYear':1099,'jobtime':30,'jobDescription':'这是职位描述','benefit':'10000,10001'},'success':true"

  Scenario: 获取热门职位模板
    When 设置cookie
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 保存一个变量key="{path}",value="/appapi/jobtemplate/hotjobtemplates"
    When 调用GET接口,url:"{url}{path}?access_token={access_token}"
    Then json结果中包含"'code':200,'message':null,'data':[{'id':30,'templateName':'java工程师0','templateTypeName':'type1'},{'id':31,'templateName':'java工程师1','templateTypeName':'type1'},{'id':32,'templateName':'java工程师2','templateTypeName':'type1'},{'id':33,'templateName':'java工程师3','templateTypeName':'type1'},{'id':34,'templateName':'java工程师4','templateTypeName':'type1'},{'id':35,'templateName':'java工程师5','templateTypeName':'type1'},{'id':59,'templateName':'证券/期货/外汇经纪人','templateTypeName':'证券/期货/外汇经纪人'},{'id':68,'templateName':'医药代表','templateTypeName':'医药代表'},{'id':65,'templateName':'销售经理','templateTypeName':'销售经理'},{'id':66,'templateName':'培训/招生/课程顾问','templateTypeName':'培训/招生/课程顾问'},{'id':67,'templateName':'Java开发工程师','templateTypeName':'Java开发工程师'},{'id':60,'templateName':'销售代表','templateTypeName':'销售代表'},{'id':61,'templateName':'软件工程师','templateTypeName':'软件工程师'},{'id':62,'templateName':'证券分析/金融研究','templateTypeName':'证券分析/金融研究'},{'id':63,'templateName':'股票/期货操盘手','templateTypeName':'股票/期货操盘手'},{'id':64,'templateName':'演员/模特','templateTypeName':'演员/模特'}],'success':true"

  Scenario: 搜索职位模板
    When 设置cookie
    When 设置fromsystem为"23"
    When 设置deviceid为"qwertyu"
    When 保存一个变量key="{path}",value="/appapi/jobtemplate/jobtemplates"
    When 调用GET接口,url:"{url}{path}?access_token={access_token}&keyword={jobmoduletitle}"
    Then json结果中包含"'code':200,'message':null,'data':[{'id':122,'templateName':'jobmodule123','templateTypeName':'仓库/物料管理员'},]"
