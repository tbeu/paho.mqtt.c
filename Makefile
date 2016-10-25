AR = ar -ru
RM = rm -f

CFLAGS = -O3
CPPFLAGS = -DNDEBUG
INC =

TARGETDIR = linux64

# The names of the four different libraries to be built
MQTTLIB_C = paho-mqtt3c
MQTTLIB_CS = paho-mqtt3cs
MQTTLIB_A = paho-mqtt3a
MQTTLIB_AS = paho-mqtt3as

MQTT3A_OBJS = \
	MQTTProtocolClient.o \
	Clients.o \
	utf-8.o \
	StackTrace.o \
	MQTTPacket.o \
	MQTTPacketOut.o \
	Messages.o \
	Tree.o \
	Socket.o \
	Log.o \
	MQTTPersistence.o \
	Thread.o \
	MQTTProtocolOut.o \
	MQTTPersistenceDefault.o \
	SocketBuffer.o \
	Heap.o \
	LinkedList.o \
	MQTTAsync.o

MQTT3C_OBJS = \
	MQTTProtocolClient.o \
	Clients.o \
	utf-8.o \
	StackTrace.o \
	MQTTPacket.o \
	MQTTPacketOut.o \
	Messages.o \
	Tree.o \
	Socket.o \
	Log.o \
	MQTTPersistence.o \
	Thread.o \
	MQTTProtocolOut.o \
	MQTTPersistenceDefault.o \
	SocketBuffer.o \
	Heap.o \
	LinkedList.o \
	MQTTClient.o

ALL_OBJS = $(MQTT3A_OBJS) $(MQTT3C_OBJS)

TS := $(shell /bin/date -u)

all: clean versioninfo lib$(MQTTLIB_A).a lib$(MQTTLIB_C).a

versioninfo:
	@echo "#ifndef VERSIONINFO_H" > src/VersionInfo.h
	@echo "#define VERSIONINFO_H" >> src/VersionInfo.h
	@echo "#define BUILD_TIMESTAMP \""$(TS)"\"" >> src/VersionInfo.h
	@echo "#define CLIENT_VERSION \"1.2.1\""  >> src/VersionInfo.h
	@echo "#endif /* VERSIONINFO_H */" >> src/VersionInfo.h

lib$(MQTTLIB_A).a: $(MQTT3A_OBJS)
	$(AR) $@ $(MQTT3A_OBJS)
	cp $@ Library/$(TARGETDIR)/$@

lib$(MQTTLIB_C).a: $(MQTT3C_OBJS)
	$(AR) $@ $(MQTT3C_OBJS)
	cp $@ Library/$(TARGETDIR)/$@

%.o: src/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	$(RM) $(ALL_OBJS)
	$(RM) *.a
