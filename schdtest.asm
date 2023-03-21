
_schdtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	printf(1, "\n");
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 10             	sub    $0x10,%esp
    enable_sched_trace(1);
  11:	6a 01                	push   $0x1
  13:	e8 73 04 00 00       	call   48b <enable_sched_trace>

    /* ---------------- start: add your test code ------------------- */
    set_sched(1);
  18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1f:	e8 77 04 00 00       	call   49b <set_sched>
    example_test_code();
  24:	e8 a7 00 00 00       	call   d0 <example_test_code>

    /* ---------------- end: add your test code ------------------- */

    enable_sched_trace(0);
  29:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  30:	e8 56 04 00 00       	call   48b <enable_sched_trace>
    
    exit();
  35:	e8 a9 03 00 00       	call   3e3 <exit>
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

00000040 <do_parent>:
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 10             	sub    $0x10,%esp
    volatile int cnt = 0;
  46:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    volatile int tmp = 0;
  4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while(cnt < P_LOOP_CNT)
  54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  57:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  5c:	7f 20                	jg     7e <do_parent+0x3e>
  5e:	66 90                	xchg   %ax,%ax
        tmp += cnt;
  60:	8b 55 f8             	mov    -0x8(%ebp),%edx
  63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  66:	01 d0                	add    %edx,%eax
  68:	89 45 fc             	mov    %eax,-0x4(%ebp)
        cnt ++;
  6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  6e:	83 c0 01             	add    $0x1,%eax
  71:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while(cnt < P_LOOP_CNT)
  74:	8b 45 f8             	mov    -0x8(%ebp),%eax
  77:	3d ff ff ff 00       	cmp    $0xffffff,%eax
  7c:	7e e2                	jle    60 <do_parent+0x20>
}
  7e:	c9                   	leave  
  7f:	c3                   	ret    

00000080 <do_child>:
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	83 ec 18             	sub    $0x18,%esp
    volatile int cnt = 0;
  86:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    volatile int tmp = 0;
  8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(cnt < C_LOOP_CNT)
  94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  97:	3d ff ff ff 02       	cmp    $0x2ffffff,%eax
  9c:	7f 20                	jg     be <do_child+0x3e>
  9e:	66 90                	xchg   %ax,%ax
        tmp += cnt;
  a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  a6:	01 d0                	add    %edx,%eax
  a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        cnt ++;
  ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ae:	83 c0 01             	add    $0x1,%eax
  b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while(cnt < C_LOOP_CNT)
  b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  b7:	3d ff ff ff 02       	cmp    $0x2ffffff,%eax
  bc:	7e e2                	jle    a0 <do_child+0x20>
    exit();
  be:	e8 20 03 00 00       	call   3e3 <exit>
  c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000d0 <example_test_code>:
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	83 ec 18             	sub    $0x18,%esp
    pid = fork();
  d6:	e8 00 03 00 00       	call   3db <fork>
    if (pid < 0)
  db:	85 c0                	test   %eax,%eax
  dd:	0f 88 95 00 00 00    	js     178 <example_test_code+0xa8>
    else if (pid == 0) // child
  e3:	74 7f                	je     164 <example_test_code+0x94>
        int parent_pid=getpid();
  e5:	e8 79 03 00 00       	call   463 <getpid>
        set_priority(parent_pid,2);
  ea:	83 ec 08             	sub    $0x8,%esp
  ed:	6a 02                	push   $0x2
  ef:	50                   	push   %eax
  f0:	e8 ae 03 00 00       	call   4a3 <set_priority>
    volatile int cnt = 0;
  f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while(cnt < P_LOOP_CNT)
  fc:	83 c4 10             	add    $0x10,%esp
    volatile int tmp = 0;
  ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(cnt < P_LOOP_CNT)
 106:	8b 45 f0             	mov    -0x10(%ebp),%eax
 109:	3d ff ff ff 00       	cmp    $0xffffff,%eax
 10e:	7f 1e                	jg     12e <example_test_code+0x5e>
        tmp += cnt;
 110:	8b 45 f0             	mov    -0x10(%ebp),%eax
 113:	8b 55 f4             	mov    -0xc(%ebp),%edx
 116:	01 d0                	add    %edx,%eax
 118:	89 45 f4             	mov    %eax,-0xc(%ebp)
        cnt ++;
 11b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 11e:	83 c0 01             	add    $0x1,%eax
 121:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while(cnt < P_LOOP_CNT)
 124:	8b 45 f0             	mov    -0x10(%ebp),%eax
 127:	3d ff ff ff 00       	cmp    $0xffffff,%eax
 12c:	7e e2                	jle    110 <example_test_code+0x40>
        if (wait() < 0)
 12e:	e8 b8 02 00 00       	call   3eb <wait>
 133:	85 c0                	test   %eax,%eax
 135:	78 19                	js     150 <example_test_code+0x80>
	printf(1, "\n");
 137:	83 ec 08             	sub    $0x8,%esp
 13a:	68 d6 08 00 00       	push   $0x8d6
 13f:	6a 01                	push   $0x1
 141:	e8 1a 04 00 00       	call   560 <printf>
}
 146:	83 c4 10             	add    $0x10,%esp
 149:	c9                   	leave  
 14a:	c3                   	ret    
 14b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop
            printf(1, "wait() failed!\n");
 150:	83 ec 08             	sub    $0x8,%esp
 153:	68 d8 08 00 00       	push   $0x8d8
 158:	6a 01                	push   $0x1
 15a:	e8 01 04 00 00       	call   560 <printf>
 15f:	83 c4 10             	add    $0x10,%esp
 162:	eb d3                	jmp    137 <example_test_code+0x67>
        int child_pid=getpid();
 164:	e8 fa 02 00 00       	call   463 <getpid>
        set_priority(child_pid,2);
 169:	52                   	push   %edx
 16a:	52                   	push   %edx
 16b:	6a 02                	push   $0x2
 16d:	50                   	push   %eax
 16e:	e8 30 03 00 00       	call   4a3 <set_priority>
        do_child();
 173:	e8 08 ff ff ff       	call   80 <do_child>
        printf(1, "fork() failed!\n");
 178:	51                   	push   %ecx
 179:	51                   	push   %ecx
 17a:	68 c8 08 00 00       	push   $0x8c8
 17f:	6a 01                	push   $0x1
 181:	e8 da 03 00 00       	call   560 <printf>
        exit();
 186:	e8 58 02 00 00       	call   3e3 <exit>
 18b:	66 90                	xchg   %ax,%ax
 18d:	66 90                	xchg   %ax,%ax
 18f:	90                   	nop

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 190:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 191:	31 c0                	xor    %eax,%eax
{
 193:	89 e5                	mov    %esp,%ebp
 195:	53                   	push   %ebx
 196:	8b 4d 08             	mov    0x8(%ebp),%ecx
 199:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1a7:	83 c0 01             	add    $0x1,%eax
 1aa:	84 d2                	test   %dl,%dl
 1ac:	75 f2                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1b1:	89 c8                	mov    %ecx,%eax
 1b3:	c9                   	leave  
 1b4:	c3                   	ret    
 1b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1ca:	0f b6 01             	movzbl (%ecx),%eax
 1cd:	0f b6 1a             	movzbl (%edx),%ebx
 1d0:	84 c0                	test   %al,%al
 1d2:	75 1d                	jne    1f1 <strcmp+0x31>
 1d4:	eb 2a                	jmp    200 <strcmp+0x40>
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1e4:	83 c1 01             	add    $0x1,%ecx
 1e7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
 1ea:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
 1ed:	84 c0                	test   %al,%al
 1ef:	74 0f                	je     200 <strcmp+0x40>
 1f1:	38 d8                	cmp    %bl,%al
 1f3:	74 eb                	je     1e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1f5:	29 d8                	sub    %ebx,%eax
}
 1f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fa:	c9                   	leave  
 1fb:	c3                   	ret    
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 202:	29 d8                	sub    %ebx,%eax
}
 204:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 207:	c9                   	leave  
 208:	c3                   	ret    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:

uint
strlen(char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c0 01             	add    $0x1,%eax
 223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 227:	89 c1                	mov    %eax,%ecx
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	89 c8                	mov    %ecx,%eax
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret    
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	8b 7d fc             	mov    -0x4(%ebp),%edi
 255:	89 d0                	mov    %edx,%eax
 257:	c9                   	leave  
 258:	c3                   	ret    
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 12                	jne    283 <strchr+0x23>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 277:	90                   	nop
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	84 d2                	test   %dl,%dl
 281:	74 0d                	je     290 <strchr+0x30>
    if(*s == c)
 283:	38 d1                	cmp    %dl,%cl
 285:	75 f1                	jne    278 <strchr+0x18>
      return (char*)s;
  return 0;
}
 287:	5d                   	pop    %ebp
 288:	c3                   	ret    
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 290:	31 c0                	xor    %eax,%eax
}
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 29f:	90                   	nop

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	31 f6                	xor    %esi,%esi
{
 2a7:	53                   	push   %ebx
 2a8:	89 f3                	mov    %esi,%ebx
 2aa:	83 ec 1c             	sub    $0x1c,%esp
 2ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2b0:	eb 2f                	jmp    2e1 <gets+0x41>
 2b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2b8:	83 ec 04             	sub    $0x4,%esp
 2bb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2be:	6a 01                	push   $0x1
 2c0:	50                   	push   %eax
 2c1:	6a 00                	push   $0x0
 2c3:	e8 33 01 00 00       	call   3fb <read>
    if(cc < 1)
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	85 c0                	test   %eax,%eax
 2cd:	7e 1c                	jle    2eb <gets+0x4b>
      break;
    buf[i++] = c;
 2cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 2d3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
 2d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2d9:	3c 0a                	cmp    $0xa,%al
 2db:	74 23                	je     300 <gets+0x60>
 2dd:	3c 0d                	cmp    $0xd,%al
 2df:	74 1f                	je     300 <gets+0x60>
  for(i=0; i+1 < max; ){
 2e1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
 2e4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
 2e6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e9:	7c cd                	jl     2b8 <gets+0x18>
 2eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2f0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f6:	5b                   	pop    %ebx
 2f7:	5e                   	pop    %esi
 2f8:	5f                   	pop    %edi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    
 2fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop
  buf[i] = '\0';
 300:	8b 75 08             	mov    0x8(%ebp),%esi
}
 303:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 306:	01 de                	add    %ebx,%esi
 308:	89 f3                	mov    %esi,%ebx
 30a:	c6 03 00             	movb   $0x0,(%ebx)
}
 30d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 310:	5b                   	pop    %ebx
 311:	5e                   	pop    %esi
 312:	5f                   	pop    %edi
 313:	5d                   	pop    %ebp
 314:	c3                   	ret    
 315:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <stat>:

int
stat(char *n, struct stat *st)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 325:	83 ec 08             	sub    $0x8,%esp
 328:	6a 00                	push   $0x0
 32a:	ff 75 08             	pushl  0x8(%ebp)
 32d:	e8 f1 00 00 00       	call   423 <open>
  if(fd < 0)
 332:	83 c4 10             	add    $0x10,%esp
 335:	85 c0                	test   %eax,%eax
 337:	78 27                	js     360 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	ff 75 0c             	pushl  0xc(%ebp)
 33f:	89 c3                	mov    %eax,%ebx
 341:	50                   	push   %eax
 342:	e8 f4 00 00 00       	call   43b <fstat>
  close(fd);
 347:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 34a:	89 c6                	mov    %eax,%esi
  close(fd);
 34c:	e8 ba 00 00 00       	call   40b <close>
  return r;
 351:	83 c4 10             	add    $0x10,%esp
}
 354:	8d 65 f8             	lea    -0x8(%ebp),%esp
 357:	89 f0                	mov    %esi,%eax
 359:	5b                   	pop    %ebx
 35a:	5e                   	pop    %esi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 360:	be ff ff ff ff       	mov    $0xffffffff,%esi
 365:	eb ed                	jmp    354 <stat+0x34>
 367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36e:	66 90                	xchg   %ax,%ax

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 377:	0f be 02             	movsbl (%edx),%eax
 37a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 37d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 380:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 385:	77 1e                	ja     3a5 <atoi+0x35>
 387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 390:	83 c2 01             	add    $0x1,%edx
 393:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 396:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 39a:	0f be 02             	movsbl (%edx),%eax
 39d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3a8:	89 c8                	mov    %ecx,%eax
 3aa:	c9                   	leave  
 3ab:	c3                   	ret    
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	8b 45 10             	mov    0x10(%ebp),%eax
 3b7:	8b 55 08             	mov    0x8(%ebp),%edx
 3ba:	56                   	push   %esi
 3bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3be:	85 c0                	test   %eax,%eax
 3c0:	7e 13                	jle    3d5 <memmove+0x25>
 3c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3c4:	89 d7                	mov    %edx,%edi
 3c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3db:	b8 01 00 00 00       	mov    $0x1,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <exit>:
SYSCALL(exit)
 3e3:	b8 02 00 00 00       	mov    $0x2,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <wait>:
SYSCALL(wait)
 3eb:	b8 03 00 00 00       	mov    $0x3,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <pipe>:
SYSCALL(pipe)
 3f3:	b8 04 00 00 00       	mov    $0x4,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <read>:
SYSCALL(read)
 3fb:	b8 05 00 00 00       	mov    $0x5,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <write>:
SYSCALL(write)
 403:	b8 10 00 00 00       	mov    $0x10,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <close>:
SYSCALL(close)
 40b:	b8 15 00 00 00       	mov    $0x15,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <kill>:
SYSCALL(kill)
 413:	b8 06 00 00 00       	mov    $0x6,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exec>:
SYSCALL(exec)
 41b:	b8 07 00 00 00       	mov    $0x7,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <open>:
SYSCALL(open)
 423:	b8 0f 00 00 00       	mov    $0xf,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <mknod>:
SYSCALL(mknod)
 42b:	b8 11 00 00 00       	mov    $0x11,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <unlink>:
SYSCALL(unlink)
 433:	b8 12 00 00 00       	mov    $0x12,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <fstat>:
SYSCALL(fstat)
 43b:	b8 08 00 00 00       	mov    $0x8,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <link>:
SYSCALL(link)
 443:	b8 13 00 00 00       	mov    $0x13,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mkdir>:
SYSCALL(mkdir)
 44b:	b8 14 00 00 00       	mov    $0x14,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <chdir>:
SYSCALL(chdir)
 453:	b8 09 00 00 00       	mov    $0x9,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <dup>:
SYSCALL(dup)
 45b:	b8 0a 00 00 00       	mov    $0xa,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getpid>:
SYSCALL(getpid)
 463:	b8 0b 00 00 00       	mov    $0xb,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <sbrk>:
SYSCALL(sbrk)
 46b:	b8 0c 00 00 00       	mov    $0xc,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sleep>:
SYSCALL(sleep)
 473:	b8 0d 00 00 00       	mov    $0xd,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <uptime>:
SYSCALL(uptime)
 47b:	b8 0e 00 00 00       	mov    $0xe,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <shutdown>:
SYSCALL(shutdown)
 483:	b8 16 00 00 00       	mov    $0x16,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <enable_sched_trace>:
SYSCALL(enable_sched_trace)
 48b:	b8 17 00 00 00       	mov    $0x17,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <fork_winner>:
SYSCALL(fork_winner)
 493:	b8 18 00 00 00       	mov    $0x18,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <set_sched>:
SYSCALL(set_sched)
 49b:	b8 19 00 00 00       	mov    $0x19,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <set_priority>:
 4a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	90                   	nop

000004b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 3c             	sub    $0x3c,%esp
 4b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4bc:	89 d1                	mov    %edx,%ecx
{
 4be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4c1:	85 d2                	test   %edx,%edx
 4c3:	0f 89 7f 00 00 00    	jns    548 <printint+0x98>
 4c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4cd:	74 79                	je     548 <printint+0x98>
    neg = 1;
 4cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4d8:	31 db                	xor    %ebx,%ebx
 4da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 cf                	mov    %ecx,%edi
 4e6:	f7 75 c4             	divl   -0x3c(%ebp)
 4e9:	0f b6 92 f0 08 00 00 	movzbl 0x8f0(%edx),%edx
 4f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4f3:	89 d8                	mov    %ebx,%eax
 4f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 501:	76 dd                	jbe    4e0 <printint+0x30>
  if(neg)
 503:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 506:	85 c9                	test   %ecx,%ecx
 508:	74 0c                	je     516 <printint+0x66>
    buf[i++] = '-';
 50a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 50f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 511:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 516:	8b 7d b8             	mov    -0x48(%ebp),%edi
 519:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 51d:	eb 07                	jmp    526 <printint+0x76>
 51f:	90                   	nop
    putc(fd, buf[i]);
 520:	0f b6 13             	movzbl (%ebx),%edx
 523:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 526:	83 ec 04             	sub    $0x4,%esp
 529:	88 55 d7             	mov    %dl,-0x29(%ebp)
 52c:	6a 01                	push   $0x1
 52e:	56                   	push   %esi
 52f:	57                   	push   %edi
 530:	e8 ce fe ff ff       	call   403 <write>
  while(--i >= 0)
 535:	83 c4 10             	add    $0x10,%esp
 538:	39 de                	cmp    %ebx,%esi
 53a:	75 e4                	jne    520 <printint+0x70>
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 548:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 54f:	eb 87                	jmp    4d8 <printint+0x28>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 75 0c             	mov    0xc(%ebp),%esi
 56c:	0f b6 1e             	movzbl (%esi),%ebx
 56f:	84 db                	test   %bl,%bl
 571:	0f 84 b8 00 00 00    	je     62f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 45 10             	lea    0x10(%ebp),%eax
 57a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 57d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 580:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 582:	89 45 d0             	mov    %eax,-0x30(%ebp)
 585:	eb 37                	jmp    5be <printf+0x5e>
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
 590:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 593:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 598:	83 f8 25             	cmp    $0x25,%eax
 59b:	74 17                	je     5b4 <printf+0x54>
  write(fd, &c, 1);
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5a3:	6a 01                	push   $0x1
 5a5:	57                   	push   %edi
 5a6:	ff 75 08             	pushl  0x8(%ebp)
 5a9:	e8 55 fe ff ff       	call   403 <write>
 5ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5b4:	0f b6 1e             	movzbl (%esi),%ebx
 5b7:	83 c6 01             	add    $0x1,%esi
 5ba:	84 db                	test   %bl,%bl
 5bc:	74 71                	je     62f <printf+0xcf>
    c = fmt[i] & 0xff;
 5be:	0f be cb             	movsbl %bl,%ecx
 5c1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c4:	85 d2                	test   %edx,%edx
 5c6:	74 c8                	je     590 <printf+0x30>
      }
    } else if(state == '%'){
 5c8:	83 fa 25             	cmp    $0x25,%edx
 5cb:	75 e7                	jne    5b4 <printf+0x54>
      if(c == 'd'){
 5cd:	83 f8 64             	cmp    $0x64,%eax
 5d0:	0f 84 9a 00 00 00    	je     670 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5dc:	83 f9 70             	cmp    $0x70,%ecx
 5df:	74 5f                	je     640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e1:	83 f8 73             	cmp    $0x73,%eax
 5e4:	0f 84 d6 00 00 00    	je     6c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ea:	83 f8 63             	cmp    $0x63,%eax
 5ed:	0f 84 8d 00 00 00    	je     680 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f3:	83 f8 25             	cmp    $0x25,%eax
 5f6:	0f 84 b4 00 00 00    	je     6b0 <printf+0x150>
  write(fd, &c, 1);
 5fc:	83 ec 04             	sub    $0x4,%esp
 5ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	57                   	push   %edi
 606:	ff 75 08             	pushl  0x8(%ebp)
 609:	e8 f5 fd ff ff       	call   403 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 60e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 611:	83 c4 0c             	add    $0xc,%esp
 614:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 616:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 619:	57                   	push   %edi
 61a:	ff 75 08             	pushl  0x8(%ebp)
 61d:	e8 e1 fd ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 622:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 626:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 629:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 62b:	84 db                	test   %bl,%bl
 62d:	75 8f                	jne    5be <printf+0x5e>
    }
  }
}
 62f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 632:	5b                   	pop    %ebx
 633:	5e                   	pop    %esi
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 10 00 00 00       	mov    $0x10,%ecx
 648:	6a 00                	push   $0x0
 64a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	8b 13                	mov    (%ebx),%edx
 652:	e8 59 fe ff ff       	call   4b0 <printint>
        ap++;
 657:	89 d8                	mov    %ebx,%eax
 659:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65c:	31 d2                	xor    %edx,%edx
        ap++;
 65e:	83 c0 04             	add    $0x4,%eax
 661:	89 45 d0             	mov    %eax,-0x30(%ebp)
 664:	e9 4b ff ff ff       	jmp    5b4 <printf+0x54>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 670:	83 ec 0c             	sub    $0xc,%esp
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	6a 01                	push   $0x1
 67a:	eb ce                	jmp    64a <printf+0xea>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 686:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 688:	6a 01                	push   $0x1
        ap++;
 68a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 68d:	57                   	push   %edi
 68e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 691:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 694:	e8 6a fd ff ff       	call   403 <write>
        ap++;
 699:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 69f:	31 d2                	xor    %edx,%edx
 6a1:	e9 0e ff ff ff       	jmp    5b4 <printf+0x54>
 6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6b3:	83 ec 04             	sub    $0x4,%esp
 6b6:	e9 59 ff ff ff       	jmp    614 <printf+0xb4>
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
        s = (char*)*ap;
 6c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6cb:	85 db                	test   %ebx,%ebx
 6cd:	74 17                	je     6e6 <printf+0x186>
        while(*s != 0){
 6cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6d4:	84 c0                	test   %al,%al
 6d6:	0f 84 d8 fe ff ff    	je     5b4 <printf+0x54>
 6dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6df:	89 de                	mov    %ebx,%esi
 6e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e4:	eb 1a                	jmp    700 <printf+0x1a0>
          s = "(null)";
 6e6:	bb e8 08 00 00       	mov    $0x8e8,%ebx
        while(*s != 0){
 6eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ee:	b8 28 00 00 00       	mov    $0x28,%eax
 6f3:	89 de                	mov    %ebx,%esi
 6f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
  write(fd, &c, 1);
 700:	83 ec 04             	sub    $0x4,%esp
          s++;
 703:	83 c6 01             	add    $0x1,%esi
 706:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 709:	6a 01                	push   $0x1
 70b:	57                   	push   %edi
 70c:	53                   	push   %ebx
 70d:	e8 f1 fc ff ff       	call   403 <write>
        while(*s != 0){
 712:	0f b6 06             	movzbl (%esi),%eax
 715:	83 c4 10             	add    $0x10,%esp
 718:	84 c0                	test   %al,%al
 71a:	75 e4                	jne    700 <printf+0x1a0>
      state = 0;
 71c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 71f:	31 d2                	xor    %edx,%edx
 721:	e9 8e fe ff ff       	jmp    5b4 <printf+0x54>
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 f4 0b 00 00       	mov    0xbf4,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 748:	89 c2                	mov    %eax,%edx
 74a:	8b 00                	mov    (%eax),%eax
 74c:	39 ca                	cmp    %ecx,%edx
 74e:	73 30                	jae    780 <free+0x50>
 750:	39 c1                	cmp    %eax,%ecx
 752:	72 04                	jb     758 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	39 c2                	cmp    %eax,%edx
 756:	72 f0                	jb     748 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 f8                	cmp    %edi,%eax
 760:	74 30                	je     792 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 762:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 765:	8b 42 04             	mov    0x4(%edx),%eax
 768:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 76b:	39 f1                	cmp    %esi,%ecx
 76d:	74 3a                	je     7a9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 76f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 771:	5b                   	pop    %ebx
  freep = p;
 772:	89 15 f4 0b 00 00    	mov    %edx,0xbf4
}
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 c2                	cmp    %eax,%edx
 782:	72 c4                	jb     748 <free+0x18>
 784:	39 c1                	cmp    %eax,%ecx
 786:	73 c0                	jae    748 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 788:	8b 73 fc             	mov    -0x4(%ebx),%esi
 78b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78e:	39 f8                	cmp    %edi,%eax
 790:	75 d0                	jne    762 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 792:	03 70 04             	add    0x4(%eax),%esi
 795:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 798:	8b 02                	mov    (%edx),%eax
 79a:	8b 00                	mov    (%eax),%eax
 79c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 79f:	8b 42 04             	mov    0x4(%edx),%eax
 7a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	75 c6                	jne    76f <free+0x3f>
    p->s.size += bp->s.size;
 7a9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7ac:	89 15 f4 0b 00 00    	mov    %edx,0xbf4
    p->s.size += bp->s.size;
 7b2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7b5:	8b 43 f8             	mov    -0x8(%ebx),%eax
 7b8:	89 02                	mov    %eax,(%edx)
}
 7ba:	5b                   	pop    %ebx
 7bb:	5e                   	pop    %esi
 7bc:	5f                   	pop    %edi
 7bd:	5d                   	pop    %ebp
 7be:	c3                   	ret    
 7bf:	90                   	nop

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 3d f4 0b 00 00    	mov    0xbf4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 70 07             	lea    0x7(%eax),%esi
 7d5:	c1 ee 03             	shr    $0x3,%esi
 7d8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7db:	85 ff                	test   %edi,%edi
 7dd:	0f 84 ad 00 00 00    	je     890 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
 7e8:	39 f1                	cmp    %esi,%ecx
 7ea:	73 71                	jae    85d <malloc+0x9d>
 7ec:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7fa:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 801:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 804:	eb 1b                	jmp    821 <malloc+0x61>
 806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 812:	8b 4a 04             	mov    0x4(%edx),%ecx
 815:	39 f1                	cmp    %esi,%ecx
 817:	73 4f                	jae    868 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 819:	8b 3d f4 0b 00 00    	mov    0xbf4,%edi
 81f:	89 d0                	mov    %edx,%eax
 821:	39 c7                	cmp    %eax,%edi
 823:	75 eb                	jne    810 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 825:	83 ec 0c             	sub    $0xc,%esp
 828:	ff 75 e4             	pushl  -0x1c(%ebp)
 82b:	e8 3b fc ff ff       	call   46b <sbrk>
  if(p == (char*)-1)
 830:	83 c4 10             	add    $0x10,%esp
 833:	83 f8 ff             	cmp    $0xffffffff,%eax
 836:	74 1b                	je     853 <malloc+0x93>
  hp->s.size = nu;
 838:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 83b:	83 ec 0c             	sub    $0xc,%esp
 83e:	83 c0 08             	add    $0x8,%eax
 841:	50                   	push   %eax
 842:	e8 e9 fe ff ff       	call   730 <free>
  return freep;
 847:	a1 f4 0b 00 00       	mov    0xbf4,%eax
      if((p = morecore(nunits)) == 0)
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	85 c0                	test   %eax,%eax
 851:	75 bd                	jne    810 <malloc+0x50>
        return 0;
  }
}
 853:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 856:	31 c0                	xor    %eax,%eax
}
 858:	5b                   	pop    %ebx
 859:	5e                   	pop    %esi
 85a:	5f                   	pop    %edi
 85b:	5d                   	pop    %ebp
 85c:	c3                   	ret    
    if(p->s.size >= nunits){
 85d:	89 c2                	mov    %eax,%edx
 85f:	89 f8                	mov    %edi,%eax
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 868:	39 ce                	cmp    %ecx,%esi
 86a:	74 54                	je     8c0 <malloc+0x100>
        p->s.size -= nunits;
 86c:	29 f1                	sub    %esi,%ecx
 86e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 871:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 874:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 877:	a3 f4 0b 00 00       	mov    %eax,0xbf4
}
 87c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 87f:	8d 42 08             	lea    0x8(%edx),%eax
}
 882:	5b                   	pop    %ebx
 883:	5e                   	pop    %esi
 884:	5f                   	pop    %edi
 885:	5d                   	pop    %ebp
 886:	c3                   	ret    
 887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 f4 0b 00 00 f8 	movl   $0xbf8,0xbf4
 897:	0b 00 00 
    base.s.size = 0;
 89a:	bf f8 0b 00 00       	mov    $0xbf8,%edi
    base.s.ptr = freep = prevp = &base;
 89f:	c7 05 f8 0b 00 00 f8 	movl   $0xbf8,0xbf8
 8a6:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8ab:	c7 05 fc 0b 00 00 00 	movl   $0x0,0xbfc
 8b2:	00 00 00 
    if(p->s.size >= nunits){
 8b5:	e9 32 ff ff ff       	jmp    7ec <malloc+0x2c>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 0a                	mov    (%edx),%ecx
 8c2:	89 08                	mov    %ecx,(%eax)
 8c4:	eb b1                	jmp    877 <malloc+0xb7>
