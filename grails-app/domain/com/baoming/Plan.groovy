package com.baoming
/**
 * 专业计划库
 */
class Plan {

    String code // 代码
    String name //名称
    Date dateCreated
    String description //
    Status status
    Integer orderValue = 0
    /*
    Batch batch //批次代码
    BranchCode branchCode //科类代码
    PlanType planType //计划性质
    ArchivesUnit archivesUnit //投档单位
    String number //代号
    String type //专业类别
    String fixedYear//学制年限
    Integer peoples//计划人数
    Integer execution //计划执行数
    Boolean normal//是否师范
    String medicalMark //体检受限标志
    Integer priorityNumber //优先序号
    String operatorName //操作组员用户名
    String formwork //参数模板号*/

    static constraints = {
    }

    static mapping = {
        orderValue index: 'orderValue_idx'
        sort orderValue:'desc'
    }
    enum Status {
        WAITING(0,'未启用'),
        RUNNING(1,'进行中'),
        END(2,'结束')

        Integer id
        String label

        Status(Integer id,String label){
            this.id = id
            this.label = label
        }
    }
}
