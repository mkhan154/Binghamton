
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 28 08 00 00       	push   $0x828
  19:	e8 65 03 00 00       	call   383 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 88 03 00 00       	call   3bb <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 7c 03 00 00       	call   3bb <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 30 08 00 00       	push   $0x830
  50:	6a 01                	push   $0x1
  52:	e8 69 04 00 00       	call   4c0 <printf>
    pid = fork();
  57:	e8 df 02 00 00       	call   33b <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  5f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  61:	85 c0                	test   %eax,%eax
  63:	78 2c                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 3d                	je     a4 <main+0xa4>
  67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  6e:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 d6 02 00 00       	call   34b <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 cf                	js     48 <main+0x48>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 cb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 6f 08 00 00       	push   $0x86f
  85:	6a 01                	push   $0x1
  87:	e8 34 04 00 00       	call   4c0 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 43 08 00 00       	push   $0x843
  98:	6a 01                	push   $0x1
  9a:	e8 21 04 00 00       	call   4c0 <printf>
      exit();
  9f:	e8 9f 02 00 00       	call   343 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 28 0b 00 00       	push   $0xb28
  ab:	68 56 08 00 00       	push   $0x856
  b0:	e8 c6 02 00 00       	call   37b <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 59 08 00 00       	push   $0x859
  bc:	6a 01                	push   $0x1
  be:	e8 fd 03 00 00       	call   4c0 <printf>
      exit();
  c3:	e8 7b 02 00 00       	call   343 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 28 08 00 00       	push   $0x828
  d2:	e8 b4 02 00 00       	call   38b <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 28 08 00 00       	push   $0x828
  e0:	e8 9e 02 00 00       	call   383 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	53                   	push   %ebx
  f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 107:	83 c0 01             	add    $0x1,%eax
 10a:	84 d2                	test   %dl,%dl
 10c:	75 f2                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 10e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 111:	89 c8                	mov    %ecx,%eax
 113:	c9                   	leave  
 114:	c3                   	ret    
 115:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 4d 08             	mov    0x8(%ebp),%ecx
 127:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 12a:	0f b6 01             	movzbl (%ecx),%eax
 12d:	0f b6 1a             	movzbl (%edx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1d                	jne    151 <strcmp+0x31>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 144:	83 c1 01             	add    $0x1,%ecx
 147:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
 14a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
 14d:	84 c0                	test   %al,%al
 14f:	74 0f                	je     160 <strcmp+0x40>
 151:	38 d8                	cmp    %bl,%al
 153:	74 eb                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 155:	29 d8                	sub    %ebx,%eax
}
 157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15a:	c9                   	leave  
 15b:	c3                   	ret    
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 167:	c9                   	leave  
 168:	c3                   	ret    
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 3a 00             	cmpb   $0x0,(%edx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 c0                	xor    %eax,%eax
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c0 01             	add    $0x1,%eax
 183:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 187:	89 c1                	mov    %eax,%ecx
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	89 c8                	mov    %ecx,%eax
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
 18f:	90                   	nop
  for(n = 0; s[n]; n++)
 190:	31 c9                	xor    %ecx,%ecx
}
 192:	5d                   	pop    %ebp
 193:	89 c8                	mov    %ecx,%eax
 195:	c3                   	ret    
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1b5:	89 d0                	mov    %edx,%eax
 1b7:	c9                   	leave  
 1b8:	c3                   	ret    
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 12                	jne    1e3 <strchr+0x23>
 1d1:	eb 1d                	jmp    1f0 <strchr+0x30>
 1d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d7:	90                   	nop
 1d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1dc:	83 c0 01             	add    $0x1,%eax
 1df:	84 d2                	test   %dl,%dl
 1e1:	74 0d                	je     1f0 <strchr+0x30>
    if(*s == c)
 1e3:	38 d1                	cmp    %dl,%cl
 1e5:	75 f1                	jne    1d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1f0:	31 c0                	xor    %eax,%eax
}
 1f2:	5d                   	pop    %ebp
 1f3:	c3                   	ret    
 1f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ff:	90                   	nop

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 205:	31 f6                	xor    %esi,%esi
{
 207:	53                   	push   %ebx
 208:	89 f3                	mov    %esi,%ebx
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 33 01 00 00       	call   35b <read>
    if(cc < 1)
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
      break;
    buf[i++] = c;
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 233:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
 236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 241:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
 244:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
 246:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 250:	c6 03 00             	movb   $0x0,(%ebx)
}
 253:	8d 65 f4             	lea    -0xc(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop
  buf[i] = '\0';
 260:	8b 75 08             	mov    0x8(%ebp),%esi
}
 263:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 266:	01 de                	add    %ebx,%esi
 268:	89 f3                	mov    %esi,%ebx
 26a:	c6 03 00             	movb   $0x0,(%ebx)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <stat>:

int
stat(char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 f1 00 00 00       	call   383 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 f4 00 00 00       	call   39b <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 ba 00 00 00       	call   36b <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 02             	movsbl (%edx),%eax
 2da:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2e5:	77 1e                	ja     305 <atoi+0x35>
 2e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2fa:	0f be 02             	movsbl (%edx),%eax
 2fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 308:	89 c8                	mov    %ecx,%eax
 30a:	c9                   	leave  
 30b:	c3                   	ret    
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 45 10             	mov    0x10(%ebp),%eax
 317:	8b 55 08             	mov    0x8(%ebp),%edx
 31a:	56                   	push   %esi
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 c0                	test   %eax,%eax
 320:	7e 13                	jle    335 <memmove+0x25>
 322:	01 d0                	add    %edx,%eax
  dst = vdst;
 324:	89 d7                	mov    %edx,%edi
 326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 330:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 331:	39 f8                	cmp    %edi,%eax
 333:	75 fb                	jne    330 <memmove+0x20>
  return vdst;
}
 335:	5e                   	pop    %esi
 336:	89 d0                	mov    %edx,%eax
 338:	5f                   	pop    %edi
 339:	5d                   	pop    %ebp
 33a:	c3                   	ret    

0000033b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33b:	b8 01 00 00 00       	mov    $0x1,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <exit>:
SYSCALL(exit)
 343:	b8 02 00 00 00       	mov    $0x2,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <wait>:
SYSCALL(wait)
 34b:	b8 03 00 00 00       	mov    $0x3,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <pipe>:
SYSCALL(pipe)
 353:	b8 04 00 00 00       	mov    $0x4,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <read>:
SYSCALL(read)
 35b:	b8 05 00 00 00       	mov    $0x5,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <write>:
SYSCALL(write)
 363:	b8 10 00 00 00       	mov    $0x10,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <close>:
SYSCALL(close)
 36b:	b8 15 00 00 00       	mov    $0x15,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <kill>:
SYSCALL(kill)
 373:	b8 06 00 00 00       	mov    $0x6,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <exec>:
SYSCALL(exec)
 37b:	b8 07 00 00 00       	mov    $0x7,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <open>:
SYSCALL(open)
 383:	b8 0f 00 00 00       	mov    $0xf,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <mknod>:
SYSCALL(mknod)
 38b:	b8 11 00 00 00       	mov    $0x11,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <unlink>:
SYSCALL(unlink)
 393:	b8 12 00 00 00       	mov    $0x12,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <fstat>:
SYSCALL(fstat)
 39b:	b8 08 00 00 00       	mov    $0x8,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <link>:
SYSCALL(link)
 3a3:	b8 13 00 00 00       	mov    $0x13,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <mkdir>:
SYSCALL(mkdir)
 3ab:	b8 14 00 00 00       	mov    $0x14,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <chdir>:
SYSCALL(chdir)
 3b3:	b8 09 00 00 00       	mov    $0x9,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <dup>:
SYSCALL(dup)
 3bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <getpid>:
SYSCALL(getpid)
 3c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <sbrk>:
SYSCALL(sbrk)
 3cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <sleep>:
SYSCALL(sleep)
 3d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <uptime>:
SYSCALL(uptime)
 3db:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <shutdown>:
SYSCALL(shutdown)
 3e3:	b8 16 00 00 00       	mov    $0x16,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <enable_sched_trace>:
SYSCALL(enable_sched_trace)
 3eb:	b8 17 00 00 00       	mov    $0x17,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <fork_winner>:
SYSCALL(fork_winner)
 3f3:	b8 18 00 00 00       	mov    $0x18,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <set_sched>:
SYSCALL(set_sched)
 3fb:	b8 19 00 00 00       	mov    $0x19,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <set_priority>:
 403:	b8 1a 00 00 00       	mov    $0x1a,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
 419:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 41c:	89 d1                	mov    %edx,%ecx
{
 41e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 421:	85 d2                	test   %edx,%edx
 423:	0f 89 7f 00 00 00    	jns    4a8 <printint+0x98>
 429:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 42d:	74 79                	je     4a8 <printint+0x98>
    neg = 1;
 42f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 436:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 438:	31 db                	xor    %ebx,%ebx
 43a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 cf                	mov    %ecx,%edi
 446:	f7 75 c4             	divl   -0x3c(%ebp)
 449:	0f b6 92 80 08 00 00 	movzbl 0x880(%edx),%edx
 450:	89 45 c0             	mov    %eax,-0x40(%ebp)
 453:	89 d8                	mov    %ebx,%eax
 455:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 458:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 45b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 45e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 461:	76 dd                	jbe    440 <printint+0x30>
  if(neg)
 463:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 466:	85 c9                	test   %ecx,%ecx
 468:	74 0c                	je     476 <printint+0x66>
    buf[i++] = '-';
 46a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 46f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 471:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 476:	8b 7d b8             	mov    -0x48(%ebp),%edi
 479:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 47d:	eb 07                	jmp    486 <printint+0x76>
 47f:	90                   	nop
    putc(fd, buf[i]);
 480:	0f b6 13             	movzbl (%ebx),%edx
 483:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 486:	83 ec 04             	sub    $0x4,%esp
 489:	88 55 d7             	mov    %dl,-0x29(%ebp)
 48c:	6a 01                	push   $0x1
 48e:	56                   	push   %esi
 48f:	57                   	push   %edi
 490:	e8 ce fe ff ff       	call   363 <write>
  while(--i >= 0)
 495:	83 c4 10             	add    $0x10,%esp
 498:	39 de                	cmp    %ebx,%esi
 49a:	75 e4                	jne    480 <printint+0x70>
}
 49c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4af:	eb 87                	jmp    438 <printint+0x28>
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4cc:	0f b6 1e             	movzbl (%esi),%ebx
 4cf:	84 db                	test   %bl,%bl
 4d1:	0f 84 b8 00 00 00    	je     58f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 4d7:	8d 45 10             	lea    0x10(%ebp),%eax
 4da:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4dd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4e0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4e5:	eb 37                	jmp    51e <printf+0x5e>
 4e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ee:	66 90                	xchg   %ax,%ax
 4f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	74 17                	je     514 <printf+0x54>
  write(fd, &c, 1);
 4fd:	83 ec 04             	sub    $0x4,%esp
 500:	88 5d e7             	mov    %bl,-0x19(%ebp)
 503:	6a 01                	push   $0x1
 505:	57                   	push   %edi
 506:	ff 75 08             	pushl  0x8(%ebp)
 509:	e8 55 fe ff ff       	call   363 <write>
 50e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 511:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 514:	0f b6 1e             	movzbl (%esi),%ebx
 517:	83 c6 01             	add    $0x1,%esi
 51a:	84 db                	test   %bl,%bl
 51c:	74 71                	je     58f <printf+0xcf>
    c = fmt[i] & 0xff;
 51e:	0f be cb             	movsbl %bl,%ecx
 521:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 524:	85 d2                	test   %edx,%edx
 526:	74 c8                	je     4f0 <printf+0x30>
      }
    } else if(state == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	75 e7                	jne    514 <printf+0x54>
      if(c == 'd'){
 52d:	83 f8 64             	cmp    $0x64,%eax
 530:	0f 84 9a 00 00 00    	je     5d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 536:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 53c:	83 f9 70             	cmp    $0x70,%ecx
 53f:	74 5f                	je     5a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 541:	83 f8 73             	cmp    $0x73,%eax
 544:	0f 84 d6 00 00 00    	je     620 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54a:	83 f8 63             	cmp    $0x63,%eax
 54d:	0f 84 8d 00 00 00    	je     5e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 553:	83 f8 25             	cmp    $0x25,%eax
 556:	0f 84 b4 00 00 00    	je     610 <printf+0x150>
  write(fd, &c, 1);
 55c:	83 ec 04             	sub    $0x4,%esp
 55f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 563:	6a 01                	push   $0x1
 565:	57                   	push   %edi
 566:	ff 75 08             	pushl  0x8(%ebp)
 569:	e8 f5 fd ff ff       	call   363 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 56e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 571:	83 c4 0c             	add    $0xc,%esp
 574:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 576:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 579:	57                   	push   %edi
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 e1 fd ff ff       	call   363 <write>
  for(i = 0; fmt[i]; i++){
 582:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 586:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 589:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 58b:	84 db                	test   %bl,%bl
 58d:	75 8f                	jne    51e <printf+0x5e>
    }
  }
}
 58f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 592:	5b                   	pop    %ebx
 593:	5e                   	pop    %esi
 594:	5f                   	pop    %edi
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a8:	6a 00                	push   $0x0
 5aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5ad:	8b 45 08             	mov    0x8(%ebp),%eax
 5b0:	8b 13                	mov    (%ebx),%edx
 5b2:	e8 59 fe ff ff       	call   410 <printint>
        ap++;
 5b7:	89 d8                	mov    %ebx,%eax
 5b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bc:	31 d2                	xor    %edx,%edx
        ap++;
 5be:	83 c0 04             	add    $0x4,%eax
 5c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c4:	e9 4b ff ff ff       	jmp    514 <printf+0x54>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	eb ce                	jmp    5aa <printf+0xea>
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
        ap++;
 5ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5ed:	57                   	push   %edi
 5ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f4:	e8 6a fd ff ff       	call   363 <write>
        ap++;
 5f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 0e ff ff ff       	jmp    514 <printf+0x54>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 610:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
 616:	e9 59 ff ff ff       	jmp    574 <printf+0xb4>
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 18                	mov    (%eax),%ebx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 db                	test   %ebx,%ebx
 62d:	74 17                	je     646 <printf+0x186>
        while(*s != 0){
 62f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 632:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 634:	84 c0                	test   %al,%al
 636:	0f 84 d8 fe ff ff    	je     514 <printf+0x54>
 63c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63f:	89 de                	mov    %ebx,%esi
 641:	8b 5d 08             	mov    0x8(%ebp),%ebx
 644:	eb 1a                	jmp    660 <printf+0x1a0>
          s = "(null)";
 646:	bb 78 08 00 00       	mov    $0x878,%ebx
        while(*s != 0){
 64b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 64e:	b8 28 00 00 00       	mov    $0x28,%eax
 653:	89 de                	mov    %ebx,%esi
 655:	8b 5d 08             	mov    0x8(%ebp),%ebx
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
          s++;
 663:	83 c6 01             	add    $0x1,%esi
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	57                   	push   %edi
 66c:	53                   	push   %ebx
 66d:	e8 f1 fc ff ff       	call   363 <write>
        while(*s != 0){
 672:	0f b6 06             	movzbl (%esi),%eax
 675:	83 c4 10             	add    $0x10,%esp
 678:	84 c0                	test   %al,%al
 67a:	75 e4                	jne    660 <printf+0x1a0>
      state = 0;
 67c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 8e fe ff ff       	jmp    514 <printf+0x54>
 686:	66 90                	xchg   %ax,%ax
 688:	66 90                	xchg   %ax,%ax
 68a:	66 90                	xchg   %ax,%ax
 68c:	66 90                	xchg   %ax,%ax
 68e:	66 90                	xchg   %ax,%ax

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 30 0b 00 00       	mov    0xb30,%eax
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a8:	89 c2                	mov    %eax,%edx
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	39 ca                	cmp    %ecx,%edx
 6ae:	73 30                	jae    6e0 <free+0x50>
 6b0:	39 c1                	cmp    %eax,%ecx
 6b2:	72 04                	jb     6b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	39 c2                	cmp    %eax,%edx
 6b6:	72 f0                	jb     6a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6be:	39 f8                	cmp    %edi,%eax
 6c0:	74 30                	je     6f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c5:	8b 42 04             	mov    0x4(%edx),%eax
 6c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6cb:	39 f1                	cmp    %esi,%ecx
 6cd:	74 3a                	je     709 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6cf:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 6d1:	5b                   	pop    %ebx
  freep = p;
 6d2:	89 15 30 0b 00 00    	mov    %edx,0xb30
}
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	39 c2                	cmp    %eax,%edx
 6e2:	72 c4                	jb     6a8 <free+0x18>
 6e4:	39 c1                	cmp    %eax,%ecx
 6e6:	73 c0                	jae    6a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 6e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ee:	39 f8                	cmp    %edi,%eax
 6f0:	75 d0                	jne    6c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 6f2:	03 70 04             	add    0x4(%eax),%esi
 6f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f8:	8b 02                	mov    (%edx),%eax
 6fa:	8b 00                	mov    (%eax),%eax
 6fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ff:	8b 42 04             	mov    0x4(%edx),%eax
 702:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 705:	39 f1                	cmp    %esi,%ecx
 707:	75 c6                	jne    6cf <free+0x3f>
    p->s.size += bp->s.size;
 709:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 70c:	89 15 30 0b 00 00    	mov    %edx,0xb30
    p->s.size += bp->s.size;
 712:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 715:	8b 43 f8             	mov    -0x8(%ebx),%eax
 718:	89 02                	mov    %eax,(%edx)
}
 71a:	5b                   	pop    %ebx
 71b:	5e                   	pop    %esi
 71c:	5f                   	pop    %edi
 71d:	5d                   	pop    %ebp
 71e:	c3                   	ret    
 71f:	90                   	nop

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 3d 30 0b 00 00    	mov    0xb30,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 70 07             	lea    0x7(%eax),%esi
 735:	c1 ee 03             	shr    $0x3,%esi
 738:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 73b:	85 ff                	test   %edi,%edi
 73d:	0f 84 ad 00 00 00    	je     7f0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 745:	8b 48 04             	mov    0x4(%eax),%ecx
 748:	39 f1                	cmp    %esi,%ecx
 74a:	73 71                	jae    7bd <malloc+0x9d>
 74c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 752:	bb 00 10 00 00       	mov    $0x1000,%ebx
 757:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 75a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 761:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 764:	eb 1b                	jmp    781 <malloc+0x61>
 766:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 772:	8b 4a 04             	mov    0x4(%edx),%ecx
 775:	39 f1                	cmp    %esi,%ecx
 777:	73 4f                	jae    7c8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 779:	8b 3d 30 0b 00 00    	mov    0xb30,%edi
 77f:	89 d0                	mov    %edx,%eax
 781:	39 c7                	cmp    %eax,%edi
 783:	75 eb                	jne    770 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 785:	83 ec 0c             	sub    $0xc,%esp
 788:	ff 75 e4             	pushl  -0x1c(%ebp)
 78b:	e8 3b fc ff ff       	call   3cb <sbrk>
  if(p == (char*)-1)
 790:	83 c4 10             	add    $0x10,%esp
 793:	83 f8 ff             	cmp    $0xffffffff,%eax
 796:	74 1b                	je     7b3 <malloc+0x93>
  hp->s.size = nu;
 798:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 79b:	83 ec 0c             	sub    $0xc,%esp
 79e:	83 c0 08             	add    $0x8,%eax
 7a1:	50                   	push   %eax
 7a2:	e8 e9 fe ff ff       	call   690 <free>
  return freep;
 7a7:	a1 30 0b 00 00       	mov    0xb30,%eax
      if((p = morecore(nunits)) == 0)
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	85 c0                	test   %eax,%eax
 7b1:	75 bd                	jne    770 <malloc+0x50>
        return 0;
  }
}
 7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7b6:	31 c0                	xor    %eax,%eax
}
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret    
    if(p->s.size >= nunits){
 7bd:	89 c2                	mov    %eax,%edx
 7bf:	89 f8                	mov    %edi,%eax
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7c8:	39 ce                	cmp    %ecx,%esi
 7ca:	74 54                	je     820 <malloc+0x100>
        p->s.size -= nunits;
 7cc:	29 f1                	sub    %esi,%ecx
 7ce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7d1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7d4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7d7:	a3 30 0b 00 00       	mov    %eax,0xb30
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7df:	8d 42 08             	lea    0x8(%edx),%eax
}
 7e2:	5b                   	pop    %ebx
 7e3:	5e                   	pop    %esi
 7e4:	5f                   	pop    %edi
 7e5:	5d                   	pop    %ebp
 7e6:	c3                   	ret    
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7f0:	c7 05 30 0b 00 00 34 	movl   $0xb34,0xb30
 7f7:	0b 00 00 
    base.s.size = 0;
 7fa:	bf 34 0b 00 00       	mov    $0xb34,%edi
    base.s.ptr = freep = prevp = &base;
 7ff:	c7 05 34 0b 00 00 34 	movl   $0xb34,0xb34
 806:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 809:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 80b:	c7 05 38 0b 00 00 00 	movl   $0x0,0xb38
 812:	00 00 00 
    if(p->s.size >= nunits){
 815:	e9 32 ff ff ff       	jmp    74c <malloc+0x2c>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 820:	8b 0a                	mov    (%edx),%ecx
 822:	89 08                	mov    %ecx,(%eax)
 824:	eb b1                	jmp    7d7 <malloc+0xb7>
