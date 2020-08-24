
## 所在位置

    Settings 
    Editor
    Live Templates
    other里面添加

## 1.添加 forith  
    
    fori thread
    for (int i = 0; i < $VAR$; i++) {
       new Thread(()->{
           $END$
       },String.valueOf(i)).start();
    }

## 2.添加err
    
    (err,data) => {}
    (err,data) => {
    
    }

## 3.@de
    
    @description
    
## 4.ser
    
    System.err::println

## 5.tc
    
    try-catch
    try{
    
    }catch(Exception e){
    
    }

## 6.tcy
    
    try-catch-finally
    try{
    
    }catch(Exception e){
    
    }finally{
    
    }
