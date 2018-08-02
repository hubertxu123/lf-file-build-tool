#!/usr/bin/env bash
#编译+部署order站点

#需要配置如下参数
#########################################################
#项目路径，在Execute shell中配置项目路径，pwd就可以获得该项目路径--项目路径指的是有pom的项目并非其父级项目
#   ·PROJ_PATH=/jenkins_work/workspace/DeployJenkins/jenkins_work/jenkins-test-build
#   ·配置的路径为：linux上的git初始化路径
#   ·export PROJ_PATH=这个jenkins任务在部署机器上的路径
#输入你的环境上的tomcat的全路径
#   export TOMCAT_APP_PATH=tomcat再部署机器上的全路径
#   export TOMCAT_APP_PATH=/tomcat/apache-tomcat-9.0.10
#部署应用的jar包名称
#   export APP_JAR=jar包名称
#   APP_JAR=jenkins-test-build-1.0-SNAPSHOT.jar
#########################################################
#base函数

killTomcat()
{
    pid=`ps -ef |grep tomcat|grep java|awk '{print $2}'`
    echo "tomcat Id list:$pid"
    if ["$pid" = ""] ;
    then
        echo "no tomcat pid alive"
    else
        kill -9 $pid
    fi
}

cd $PROJ_PATH
mvn clean install

#停止tomcat
killTomcat

#删除原来工程
rm -rf $TOMCAT_APP_PATH/webapps/ROOT
rm -f $TOMCAT_APP_PATH/webapps/ROOT.war
rm -f $TOMCAT_APP_PATH/webapps/$APP_JAR

#复制新工程
cp $PROJ_PATH/target/$APP_JAR  $TOMCAT_APP_PATH/webapps/

cd $TOMCAT_APP_PATH/webapps/
mv $APP_JAR ROOT.war


#启动tomcat
cd $TOMCAT_APP_PATH
sh bin/startup.sh