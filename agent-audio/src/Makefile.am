#
# Makefile.am for y2a_audio/src
#

AM_CXXFLAGS = -DY2LOG=\"agent-audio\" -Wall #-I/usr/include/YaST2

plugin_LTLIBRARIES = libpy2ag_audio.la
noinst_LTLIBRARIES = liby2ag_audio.la

liby2ag_audio_la_SOURCES =		\
	YastChannelId.cc YastChannelId.h	\
	OSSAudio.cc	OSSAudio.h	\
	AudioAgent.cc	AudioAgent.h	\
	AlsaAudio.cc	AlsaAudio.h
liby2ag_audio_la_LDFLAGS = -version-info 2:0
liby2ag_audio_la_LIBADD = @AGENT_LIBADD@

libpy2ag_audio_la_SOURCES =				\
	$(liby2ag_audio_la_SOURCES)			\
	Y2CCAudio.cc
libpy2ag_audio_la_LDFLAGS = -version-info 2:0
libpy2ag_audio_la_LIBADD = @AGENT_LIBADD@

INCLUDES = -I$(includedir)
