AR = ar -ru
RM = rm -f

CFLAGS = -O3
CPPFLAGS = -DNDEBUG -DOPENSSL=1
INC =

TARGETDIR = linux64

# The names of the four different libraries to be built
MQTTLIB_C = paho-mqtt3c
MQTTLIB_CS = paho-mqtt3cs
MQTTLIB_A = paho-mqtt3a
MQTTLIB_AS = paho-mqtt3as

MQTT3AS_OBJS = \
	Base64.o \
	Clients.o \
	Heap.o \
	LinkedList.o \
	Log.o \
	Messages.o \
	MQTTPacket.o \
	MQTTPacketOut.o \
	MQTTPersistence.o \
	MQTTPersistenceDefault.o \
	MQTTProperties.o \
	MQTTProtocolClient.o \
	MQTTProtocolOut.o \
	MQTTReasonCodes.o \
	MQTTTime.o \
	SHA1.o \
	Socket.o \
	SocketBuffer.o \
	SSLSocket.o \
	StackTrace.o \
	Thread.o \
	Tree.o \
	utf-8.o \
	WebSocket.o \
	MQTTAsync.o

MQTT3CS_OBJS = \
	Base64.o \
	Clients.o \
	Heap.o \
	LinkedList.o \
	Log.o \
	Messages.o \
	MQTTPacket.o \
	MQTTPacketOut.o \
	MQTTPersistence.o \
	MQTTPersistenceDefault.o \
	MQTTProperties.o \
	MQTTProtocolClient.o \
	MQTTProtocolOut.o \
	MQTTReasonCodes.o \
	MQTTTime.o \
	SHA1.o \
	Socket.o \
	SocketBuffer.o \
	SSLSocket.o \
	StackTrace.o \
	Thread.o \
	Tree.o \
	utf-8.o \
	WebSocket.o \
	MQTTClient.o

ALL_OBJS = $(MQTT3AS_OBJS) $(MQTT3CS_OBJS)

TS := $(shell /bin/date -u)

all: clean versioninfo lib$(MQTTLIB_AS).a lib$(MQTTLIB_CS).a

versioninfo:
	@echo "#ifndef VERSIONINFO_H" > src/VersionInfo.h
	@echo "#define VERSIONINFO_H" >> src/VersionInfo.h
	@echo "#define BUILD_TIMESTAMP \""$(TS)"\"" >> src/VersionInfo.h
	@echo "#define CLIENT_VERSION \"1.3.8\""  >> src/VersionInfo.h
	@echo "#endif /* VERSIONINFO_H */" >> src/VersionInfo.h

lib$(MQTTLIB_AS).a: $(MQTT3AS_OBJS)
	$(AR) $@ $(MQTT3AS_OBJS)
	cp $@ Library/$(TARGETDIR)/$@

lib$(MQTTLIB_CS).a: $(MQTT3CS_OBJS)
	$(AR) $@ $(MQTT3CS_OBJS)
	cp $@ Library/$(TARGETDIR)/$@

%.o: src/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	$(RM) $(ALL_OBJS)
	$(RM) *.a
