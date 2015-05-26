package com.baoming

class WorkPlan {

    String name //包干人
    String area //包干区
    Integer num //  已签约数
    Date startDate //本工作周期s
    Date endDate //本工作周期
    String middleSchools //联系了哪些中学
    String tel//联系人姓名、职务、联系方式：
    String result//取得了哪些成果
    String opinion//对方提出哪些意见和建议：

    String materialObject//材料发放的对象
    Integer materialNum //对象总人数
    String materialTel//散发人的姓名、联系电话
    String questions//发材料过程中发现的问题
    Short hasOpinion=0//有无意见 0=无，1=有
    String pic//发放过程证明照片

    BigDecimal carFare = 0//车费（车费、油费、过路费）
    BigDecimal cityCarFare = 0// 市内交通费
    BigDecimal accommodation = 0//住宿费
    BigDecimal entertainment = 0//招待费
    BigDecimal amount = 0//   人均金额

    Short attendSeminar=0 //0=无，1=有 有无参加咨询会
    String workPlan//下个周期工作计划

    Integer year//年份
    Long teacherId //填写老师
    Date dateCreated//


    static constraints = {
        name()
        area()
        num()
        startDate()
        endDate()
        middleSchools(nullable: true)
        tel(nullable: true)
        result(nullable: true,maxSize: 1024)
        opinion(nullable: true,maxSize: 1024)
        materialObject(nullable: true)
        materialTel(nullable: true)
        questions(nullable: true,maxSize: 1024)
        hasOpinion(nullable: true)
        pic(nullable: true)
        carFare(nullable: true)
        cityCarFare(nullable: true)
        accommodation(nullable: true)
        entertainment(nullable: true)
        amount(nullable: true)
        attendSeminar(nullable: true)
        workPlan(nullable: true,maxSize: 1024)
    }

    static mapping = {
        year(index: 'year_idx')
        teacherId(index: 'teacherId_idx')
    }
}
