FROM tomcat:9.0-jdk17-temurin

# 1. Xoa cac app mac dinh cua Tomcat de web chay o thu muc goc (ROOT)
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Tat cong shutdown 8005 de tranh xung dot tren cac nen tang Cloud (Render,...)
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

# 3. Copy toan bo giao dien va cau hinh web vao thu muc ROOT
COPY web /usr/local/tomcat/webapps/ROOT

# 4. Copy ma nguon Java va bien dich truc tiep
COPY src /app/src
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes && \
    javac --release 8 -encoding UTF-8 \
    -cp "/usr/local/tomcat/lib/servlet-api.jar" \
    -d "/usr/local/tomcat/webapps/ROOT/WEB-INF/classes" \
    /app/src/com/huuphong/*.java

# 5. Khoi dong Tomcat va gan cong PORT linh hoat (mac dinh 8080 hoac port do Cloud cap)
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"${PORT:-8080}\"'\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"]
