dnl Copyright 2013-2017 Mo McRoberts.
dnl
dnl  Licensed under the Apache License, Version 2.0 (the "License");
dnl  you may not use this file except in compliance with the License.
dnl  You may obtain a copy of the License at
dnl
dnl      http://www.apache.org/licenses/LICENSE-2.0
dnl
dnl  Unless required by applicable law or agreed to in writing, software
dnl  distributed under the License is distributed on an "AS IS" BASIS,
dnl  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
dnl  See the License for the specific language governing permissions and
dnl  limitations under the License.
dnl
m4_pattern_forbid([^BT_])dnl
m4_pattern_forbid([^_BT_])dnl
dnl Internal: _BT_CHECK_LIBUUID([action-if-found],[action-if-not-found])
AC_DEFUN([_BT_CHECK_LIBUUID],[
	have_libuuid=no
	AC_CHECK_FUNC([uuid_compare],[have_libuuid=yes],[
		AC_CHECK_LIB([uuid],[uuid_compare],[have_libuuid=yes ; LIBUUID_LIBS="-luuid"])
	])
	if test x"$have_libuuid" = x"yes" ; then
		have_libuuid=no
		AC_CHECK_HEADER([uuid.h],[have_libuuid=yes],[
			AC_CHECK_HEADER([uuid/uuid.h],[have_libuuid=yes])
		])
		if test x"$have_libuuid" = x"no" ; then
			AC_MSG_WARN([a test program could be linked against -luuid, but no corresponding headers could be located])
		fi
	fi
	if test x"$have_libuuid" = x"yes" ; then
		true
		$1
	else
		true
		$2
	fi
])dnl
dnl
dnl - BT_CHECK_LIBUUID([action-if-found],[action-if-not-found])
AC_DEFUN([BT_CHECK_LIBUUID],[
_BT_CHECK_LIBUUID([$1],[$2])
])dnl
dnl
dnl - BT_REQUIRE_LIBUUID([action-if-found])
AC_DEFUN([BT_REQUIRE_LIBUUID],[
_BT_CHECK_LIBUUID([$1],[
	AC_MSG_ERROR([cannot find required library libuuid])
])
])dnl
