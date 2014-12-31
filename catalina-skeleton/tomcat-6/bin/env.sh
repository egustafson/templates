## Catalina/Tomcat Environment

PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`

if [ -z "$CATALINA_BASE" ]; then
  CATALINA_BASE=`cd "$PRGDIR/.." ; pwd`
fi
export CATALINA_BASE

## --------------------------------------------------

#JAVA_HOME=
#export JAVA_HOME

if [ ! $CATALINA_HOME ]; then
  CATALINA_HOME=/opt/tomcat
fi
export CATALINA_HOME

#CATALINA_PID=
#export CATALINA_PID

CATALINA_OPTS=" \
 -Xmx512m -XX:MaxPermSize=256m \
 -Dcom.sun.management.jmxremote.port=8079 \
 -Dcom.sun.management.jmxremote.ssl=false \
 -Dcom.sun.management.jmxremote.authenticate=false \
"
#export CATALINA_OPTS
unset CATALINA_OPTS 
#
# uncomment the 'unset' if using CATALINA_OPTS
# 

# ########## Validate some of the variables ##########

if [ ! -d $CATALINA_HOME ]; then
  echo "CATALINA_HOME directory [$CATALINA_HOME] does not exist."
  exit 1
fi

if [ ! -d $CATALINA_BASE ]; then
  echo "CATALINA_BASE directory [$CATALINA_BASE] does not exist."
  exit 1
fi

if [ -n "$CATALINA_PID" ]; then
  CATALINA_PID_DIR=`dirname $CATALINA_PID`
  if [ ! -d $CATALINA_PID_DIR -o ! -w $CATALINA_PID_DIR ]; then
    echo "CATALINA_PID [$CATALINA_PID] - directory does not exist, or is not writeable."
    exit 1
  fi
fi 


# ########## Print settings ##########

echo "-+-+-+- Local Catalina Environment:"
echo "  CATALINA_HOME=$CATALINA_HOME"
echo "  CATALINA_BASE=$CATALINA_BASE"
if [ -n "$CATALINA_PID"  ]; then echo "  CATALINA_PID= $CATALINA_PID"; fi
if [ -n "$CATALINA_OPTS" ]; then echo "  CATALINA_OPTS=$CATALINA_OPTS"; fi
echo "-+-+-+- End of Local Catalina Environment -+-+-+-"

# ## Done ##
