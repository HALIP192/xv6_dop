
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <is_prime>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int is_prime(int num) // функция для проверки простого числа
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    if (num % 2 == 0)
   6:	00157793          	andi	a5,a0,1
   a:	cf9d                	beqz	a5,48 <is_prime+0x48>
   c:	86aa                	mv	a3,a0
   e:	0005071b          	sext.w	a4,a0
        return 0;
    for (int k = 3; k * 2 < num; k += 2) { // перебираем все числа до число / 2
  12:	4799                	li	a5,6
  14:	02a7de63          	bge	a5,a0,50 <is_prime+0x50>
                                           // потому что дальше перебирать нет смысла
                                           // так же проверяем каждое 2 число
                                           // потому что нет смысла проверять
                                           // числа делимые на 2, т.к 2 проверено
                                           // ранее и остальные делители тоже
        if (num % k == 0)
  18:	478d                	li	a5,3
  1a:	02f5653b          	remw	a0,a0,a5
  1e:	c515                	beqz	a0,4a <is_prime+0x4a>
  20:	ff97061b          	addiw	a2,a4,-7
  24:	0026561b          	srliw	a2,a2,0x2
  28:	0016161b          	slliw	a2,a2,0x1
  2c:	2615                	addiw	a2,a2,5
    for (int k = 3; k * 2 < num; k += 2) { // перебираем все числа до число / 2
  2e:	470d                	li	a4,3
  30:	0027079b          	addiw	a5,a4,2
  34:	0007871b          	sext.w	a4,a5
  38:	00c70663          	beq	a4,a2,44 <is_prime+0x44>
        if (num % k == 0)
  3c:	02f6e53b          	remw	a0,a3,a5
  40:	f965                	bnez	a0,30 <is_prime+0x30>
  42:	a021                	j	4a <is_prime+0x4a>
            return 0;
    }
    return 1;
  44:	4505                	li	a0,1
  46:	a011                	j	4a <is_prime+0x4a>
        return 0;
  48:	4501                	li	a0,0
}
  4a:	6422                	ld	s0,8(sp)
  4c:	0141                	addi	sp,sp,16
  4e:	8082                	ret
    return 1;
  50:	4505                	li	a0,1
  52:	bfe5                	j	4a <is_prime+0x4a>

0000000000000054 <next_prime>:

int next_prime(int num) // функция для нахождения следующего простого числа
{
  54:	1101                	addi	sp,sp,-32
  56:	ec06                	sd	ra,24(sp)
  58:	e822                	sd	s0,16(sp)
  5a:	e426                	sd	s1,8(sp)
  5c:	1000                	addi	s0,sp,32
    if (num == 2)
  5e:	4789                	li	a5,2
  60:	02f50263          	beq	a0,a5,84 <next_prime+0x30>
        return 3;
    int next = num + 2;
  64:	0025049b          	addiw	s1,a0,2
    while (!is_prime(next)) {
  68:	a011                	j	6c <next_prime+0x18>
        next += 2;
  6a:	2489                	addiw	s1,s1,2
    while (!is_prime(next)) {
  6c:	8526                	mv	a0,s1
  6e:	00000097          	auipc	ra,0x0
  72:	f92080e7          	jalr	-110(ra) # 0 <is_prime>
  76:	d975                	beqz	a0,6a <next_prime+0x16>
    }
    return next;
}
  78:	8526                	mv	a0,s1
  7a:	60e2                	ld	ra,24(sp)
  7c:	6442                	ld	s0,16(sp)
  7e:	64a2                	ld	s1,8(sp)
  80:	6105                	addi	sp,sp,32
  82:	8082                	ret
        return 3;
  84:	448d                	li	s1,3
  86:	bfcd                	j	78 <next_prime+0x24>

0000000000000088 <main>:

int main(void)
{
  88:	715d                	addi	sp,sp,-80
  8a:	e486                	sd	ra,72(sp)
  8c:	e0a2                	sd	s0,64(sp)
  8e:	fc26                	sd	s1,56(sp)
  90:	f84a                	sd	s2,48(sp)
  92:	f44e                	sd	s3,40(sp)
  94:	0880                	addi	s0,sp,80
    int start = 2;
  96:	4789                	li	a5,2
  98:	fcf42623          	sw	a5,-52(s0)
    int parent_pid = getpid();
  9c:	00000097          	auipc	ra,0x0
  a0:	3ec080e7          	jalr	1004(ra) # 488 <getpid>
  a4:	89aa                	mv	s3,a0
    int p[2];
    if (pipe(p) < 0) {
  a6:	fc040513          	addi	a0,s0,-64
  aa:	00000097          	auipc	ra,0x0
  ae:	36e080e7          	jalr	878(ra) # 418 <pipe>
  b2:	06054563          	bltz	a0,11c <main+0x94>
        printf("pipe failed...\n");
        exit(1);
    }
    while (start < 35) {
  b6:	fcc42703          	lw	a4,-52(s0)
  ba:	02200793          	li	a5,34
            }
            exit(0);
        } else {
            int num;
            read(p[0], &num, 4);
            printf("prime %d\n", num);
  be:	00001917          	auipc	s2,0x1
  c2:	87290913          	addi	s2,s2,-1934 # 930 <malloc+0xf6>
    while (start < 35) {
  c6:	02200493          	li	s1,34
  ca:	04e7c163          	blt	a5,a4,10c <main+0x84>
        int fd = fork();
  ce:	00000097          	auipc	ra,0x0
  d2:	332080e7          	jalr	818(ra) # 400 <fork>
        if (fd) {
  d6:	e125                	bnez	a0,136 <main+0xae>
            read(p[0], &num, 4);
  d8:	4611                	li	a2,4
  da:	fbc40593          	addi	a1,s0,-68
  de:	fc042503          	lw	a0,-64(s0)
  e2:	00000097          	auipc	ra,0x0
  e6:	33e080e7          	jalr	830(ra) # 420 <read>
            printf("prime %d\n", num);
  ea:	fbc42583          	lw	a1,-68(s0)
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	692080e7          	jalr	1682(ra) # 782 <printf>
            start = next_prime(num);
  f8:	fbc42503          	lw	a0,-68(s0)
  fc:	00000097          	auipc	ra,0x0
 100:	f58080e7          	jalr	-168(ra) # 54 <next_prime>
 104:	fca42623          	sw	a0,-52(s0)
    while (start < 35) {
 108:	fca4d3e3          	bge	s1,a0,ce <main+0x46>
        }
    }
    return 0;
}
 10c:	4501                	li	a0,0
 10e:	60a6                	ld	ra,72(sp)
 110:	6406                	ld	s0,64(sp)
 112:	74e2                	ld	s1,56(sp)
 114:	7942                	ld	s2,48(sp)
 116:	79a2                	ld	s3,40(sp)
 118:	6161                	addi	sp,sp,80
 11a:	8082                	ret
        printf("pipe failed...\n");
 11c:	00001517          	auipc	a0,0x1
 120:	80450513          	addi	a0,a0,-2044 # 920 <malloc+0xe6>
 124:	00000097          	auipc	ra,0x0
 128:	65e080e7          	jalr	1630(ra) # 782 <printf>
        exit(1);
 12c:	4505                	li	a0,1
 12e:	00000097          	auipc	ra,0x0
 132:	2da080e7          	jalr	730(ra) # 408 <exit>
            write(p[1], &start, 4);
 136:	4611                	li	a2,4
 138:	fcc40593          	addi	a1,s0,-52
 13c:	fc442503          	lw	a0,-60(s0)
 140:	00000097          	auipc	ra,0x0
 144:	2e8080e7          	jalr	744(ra) # 428 <write>
            wait((void *)0);
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	2c6080e7          	jalr	710(ra) # 410 <wait>
            if (getpid() == parent_pid) { // если прородитель( самый старший родитель
 152:	00000097          	auipc	ra,0x0
 156:	336080e7          	jalr	822(ra) # 488 <getpid>
 15a:	01350763          	beq	a0,s3,168 <main+0xe0>
            exit(0);
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	2a8080e7          	jalr	680(ra) # 408 <exit>
                close(p[0]);
 168:	fc042503          	lw	a0,-64(s0)
 16c:	00000097          	auipc	ra,0x0
 170:	2c4080e7          	jalr	708(ra) # 430 <close>
                close(p[1]);
 174:	fc442503          	lw	a0,-60(s0)
 178:	00000097          	auipc	ra,0x0
 17c:	2b8080e7          	jalr	696(ra) # 430 <close>
 180:	bff9                	j	15e <main+0xd6>

0000000000000182 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 182:	1141                	addi	sp,sp,-16
 184:	e406                	sd	ra,8(sp)
 186:	e022                	sd	s0,0(sp)
 188:	0800                	addi	s0,sp,16
  extern int main();
  main();
 18a:	00000097          	auipc	ra,0x0
 18e:	efe080e7          	jalr	-258(ra) # 88 <main>
  exit(0);
 192:	4501                	li	a0,0
 194:	00000097          	auipc	ra,0x0
 198:	274080e7          	jalr	628(ra) # 408 <exit>

000000000000019c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e422                	sd	s0,8(sp)
 1a0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a2:	87aa                	mv	a5,a0
 1a4:	0585                	addi	a1,a1,1
 1a6:	0785                	addi	a5,a5,1
 1a8:	fff5c703          	lbu	a4,-1(a1)
 1ac:	fee78fa3          	sb	a4,-1(a5)
 1b0:	fb75                	bnez	a4,1a4 <strcpy+0x8>
    ;
  return os;
}
 1b2:	6422                	ld	s0,8(sp)
 1b4:	0141                	addi	sp,sp,16
 1b6:	8082                	ret

00000000000001b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b8:	1141                	addi	sp,sp,-16
 1ba:	e422                	sd	s0,8(sp)
 1bc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	cb91                	beqz	a5,1d6 <strcmp+0x1e>
 1c4:	0005c703          	lbu	a4,0(a1)
 1c8:	00f71763          	bne	a4,a5,1d6 <strcmp+0x1e>
    p++, q++;
 1cc:	0505                	addi	a0,a0,1
 1ce:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	fbe5                	bnez	a5,1c4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d6:	0005c503          	lbu	a0,0(a1)
}
 1da:	40a7853b          	subw	a0,a5,a0
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret

00000000000001e4 <strlen>:

uint
strlen(const char *s)
{
 1e4:	1141                	addi	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ea:	00054783          	lbu	a5,0(a0)
 1ee:	cf91                	beqz	a5,20a <strlen+0x26>
 1f0:	0505                	addi	a0,a0,1
 1f2:	87aa                	mv	a5,a0
 1f4:	4685                	li	a3,1
 1f6:	9e89                	subw	a3,a3,a0
 1f8:	00f6853b          	addw	a0,a3,a5
 1fc:	0785                	addi	a5,a5,1
 1fe:	fff7c703          	lbu	a4,-1(a5)
 202:	fb7d                	bnez	a4,1f8 <strlen+0x14>
    ;
  return n;
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  for(n = 0; s[n]; n++)
 20a:	4501                	li	a0,0
 20c:	bfe5                	j	204 <strlen+0x20>

000000000000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 214:	ca19                	beqz	a2,22a <memset+0x1c>
 216:	87aa                	mv	a5,a0
 218:	1602                	slli	a2,a2,0x20
 21a:	9201                	srli	a2,a2,0x20
 21c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 220:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 224:	0785                	addi	a5,a5,1
 226:	fee79de3          	bne	a5,a4,220 <memset+0x12>
  }
  return dst;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  for(; *s; s++)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cb99                	beqz	a5,250 <strchr+0x20>
    if(*s == c)
 23c:	00f58763          	beq	a1,a5,24a <strchr+0x1a>
  for(; *s; s++)
 240:	0505                	addi	a0,a0,1
 242:	00054783          	lbu	a5,0(a0)
 246:	fbfd                	bnez	a5,23c <strchr+0xc>
      return (char*)s;
  return 0;
 248:	4501                	li	a0,0
}
 24a:	6422                	ld	s0,8(sp)
 24c:	0141                	addi	sp,sp,16
 24e:	8082                	ret
  return 0;
 250:	4501                	li	a0,0
 252:	bfe5                	j	24a <strchr+0x1a>

0000000000000254 <gets>:

char*
gets(char *buf, int max)
{
 254:	711d                	addi	sp,sp,-96
 256:	ec86                	sd	ra,88(sp)
 258:	e8a2                	sd	s0,80(sp)
 25a:	e4a6                	sd	s1,72(sp)
 25c:	e0ca                	sd	s2,64(sp)
 25e:	fc4e                	sd	s3,56(sp)
 260:	f852                	sd	s4,48(sp)
 262:	f456                	sd	s5,40(sp)
 264:	f05a                	sd	s6,32(sp)
 266:	ec5e                	sd	s7,24(sp)
 268:	1080                	addi	s0,sp,96
 26a:	8baa                	mv	s7,a0
 26c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26e:	892a                	mv	s2,a0
 270:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 272:	4aa9                	li	s5,10
 274:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 276:	89a6                	mv	s3,s1
 278:	2485                	addiw	s1,s1,1
 27a:	0344d863          	bge	s1,s4,2aa <gets+0x56>
    cc = read(0, &c, 1);
 27e:	4605                	li	a2,1
 280:	faf40593          	addi	a1,s0,-81
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	19a080e7          	jalr	410(ra) # 420 <read>
    if(cc < 1)
 28e:	00a05e63          	blez	a0,2aa <gets+0x56>
    buf[i++] = c;
 292:	faf44783          	lbu	a5,-81(s0)
 296:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 29a:	01578763          	beq	a5,s5,2a8 <gets+0x54>
 29e:	0905                	addi	s2,s2,1
 2a0:	fd679be3          	bne	a5,s6,276 <gets+0x22>
  for(i=0; i+1 < max; ){
 2a4:	89a6                	mv	s3,s1
 2a6:	a011                	j	2aa <gets+0x56>
 2a8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2aa:	99de                	add	s3,s3,s7
 2ac:	00098023          	sb	zero,0(s3)
  return buf;
}
 2b0:	855e                	mv	a0,s7
 2b2:	60e6                	ld	ra,88(sp)
 2b4:	6446                	ld	s0,80(sp)
 2b6:	64a6                	ld	s1,72(sp)
 2b8:	6906                	ld	s2,64(sp)
 2ba:	79e2                	ld	s3,56(sp)
 2bc:	7a42                	ld	s4,48(sp)
 2be:	7aa2                	ld	s5,40(sp)
 2c0:	7b02                	ld	s6,32(sp)
 2c2:	6be2                	ld	s7,24(sp)
 2c4:	6125                	addi	sp,sp,96
 2c6:	8082                	ret

00000000000002c8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c8:	1101                	addi	sp,sp,-32
 2ca:	ec06                	sd	ra,24(sp)
 2cc:	e822                	sd	s0,16(sp)
 2ce:	e426                	sd	s1,8(sp)
 2d0:	e04a                	sd	s2,0(sp)
 2d2:	1000                	addi	s0,sp,32
 2d4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d6:	4581                	li	a1,0
 2d8:	00000097          	auipc	ra,0x0
 2dc:	170080e7          	jalr	368(ra) # 448 <open>
  if(fd < 0)
 2e0:	02054563          	bltz	a0,30a <stat+0x42>
 2e4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2e6:	85ca                	mv	a1,s2
 2e8:	00000097          	auipc	ra,0x0
 2ec:	178080e7          	jalr	376(ra) # 460 <fstat>
 2f0:	892a                	mv	s2,a0
  close(fd);
 2f2:	8526                	mv	a0,s1
 2f4:	00000097          	auipc	ra,0x0
 2f8:	13c080e7          	jalr	316(ra) # 430 <close>
  return r;
}
 2fc:	854a                	mv	a0,s2
 2fe:	60e2                	ld	ra,24(sp)
 300:	6442                	ld	s0,16(sp)
 302:	64a2                	ld	s1,8(sp)
 304:	6902                	ld	s2,0(sp)
 306:	6105                	addi	sp,sp,32
 308:	8082                	ret
    return -1;
 30a:	597d                	li	s2,-1
 30c:	bfc5                	j	2fc <stat+0x34>

000000000000030e <atoi>:

int
atoi(const char *s)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 314:	00054683          	lbu	a3,0(a0)
 318:	fd06879b          	addiw	a5,a3,-48
 31c:	0ff7f793          	zext.b	a5,a5
 320:	4625                	li	a2,9
 322:	02f66863          	bltu	a2,a5,352 <atoi+0x44>
 326:	872a                	mv	a4,a0
  n = 0;
 328:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 32a:	0705                	addi	a4,a4,1
 32c:	0025179b          	slliw	a5,a0,0x2
 330:	9fa9                	addw	a5,a5,a0
 332:	0017979b          	slliw	a5,a5,0x1
 336:	9fb5                	addw	a5,a5,a3
 338:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 33c:	00074683          	lbu	a3,0(a4)
 340:	fd06879b          	addiw	a5,a3,-48
 344:	0ff7f793          	zext.b	a5,a5
 348:	fef671e3          	bgeu	a2,a5,32a <atoi+0x1c>
  return n;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
  n = 0;
 352:	4501                	li	a0,0
 354:	bfe5                	j	34c <atoi+0x3e>

0000000000000356 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 35c:	02b57463          	bgeu	a0,a1,384 <memmove+0x2e>
    while(n-- > 0)
 360:	00c05f63          	blez	a2,37e <memmove+0x28>
 364:	1602                	slli	a2,a2,0x20
 366:	9201                	srli	a2,a2,0x20
 368:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 36c:	872a                	mv	a4,a0
      *dst++ = *src++;
 36e:	0585                	addi	a1,a1,1
 370:	0705                	addi	a4,a4,1
 372:	fff5c683          	lbu	a3,-1(a1)
 376:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 37a:	fee79ae3          	bne	a5,a4,36e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 37e:	6422                	ld	s0,8(sp)
 380:	0141                	addi	sp,sp,16
 382:	8082                	ret
    dst += n;
 384:	00c50733          	add	a4,a0,a2
    src += n;
 388:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 38a:	fec05ae3          	blez	a2,37e <memmove+0x28>
 38e:	fff6079b          	addiw	a5,a2,-1
 392:	1782                	slli	a5,a5,0x20
 394:	9381                	srli	a5,a5,0x20
 396:	fff7c793          	not	a5,a5
 39a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 39c:	15fd                	addi	a1,a1,-1
 39e:	177d                	addi	a4,a4,-1
 3a0:	0005c683          	lbu	a3,0(a1)
 3a4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a8:	fee79ae3          	bne	a5,a4,39c <memmove+0x46>
 3ac:	bfc9                	j	37e <memmove+0x28>

00000000000003ae <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3b4:	ca05                	beqz	a2,3e4 <memcmp+0x36>
 3b6:	fff6069b          	addiw	a3,a2,-1
 3ba:	1682                	slli	a3,a3,0x20
 3bc:	9281                	srli	a3,a3,0x20
 3be:	0685                	addi	a3,a3,1
 3c0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c2:	00054783          	lbu	a5,0(a0)
 3c6:	0005c703          	lbu	a4,0(a1)
 3ca:	00e79863          	bne	a5,a4,3da <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3ce:	0505                	addi	a0,a0,1
    p2++;
 3d0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3d2:	fed518e3          	bne	a0,a3,3c2 <memcmp+0x14>
  }
  return 0;
 3d6:	4501                	li	a0,0
 3d8:	a019                	j	3de <memcmp+0x30>
      return *p1 - *p2;
 3da:	40e7853b          	subw	a0,a5,a4
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  return 0;
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <memcmp+0x30>

00000000000003e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e406                	sd	ra,8(sp)
 3ec:	e022                	sd	s0,0(sp)
 3ee:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3f0:	00000097          	auipc	ra,0x0
 3f4:	f66080e7          	jalr	-154(ra) # 356 <memmove>
}
 3f8:	60a2                	ld	ra,8(sp)
 3fa:	6402                	ld	s0,0(sp)
 3fc:	0141                	addi	sp,sp,16
 3fe:	8082                	ret

0000000000000400 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 400:	4885                	li	a7,1
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <exit>:
.global exit
exit:
 li a7, SYS_exit
 408:	4889                	li	a7,2
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <wait>:
.global wait
wait:
 li a7, SYS_wait
 410:	488d                	li	a7,3
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 418:	4891                	li	a7,4
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <read>:
.global read
read:
 li a7, SYS_read
 420:	4895                	li	a7,5
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <write>:
.global write
write:
 li a7, SYS_write
 428:	48c1                	li	a7,16
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <close>:
.global close
close:
 li a7, SYS_close
 430:	48d5                	li	a7,21
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <kill>:
.global kill
kill:
 li a7, SYS_kill
 438:	4899                	li	a7,6
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <exec>:
.global exec
exec:
 li a7, SYS_exec
 440:	489d                	li	a7,7
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <open>:
.global open
open:
 li a7, SYS_open
 448:	48bd                	li	a7,15
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 450:	48c5                	li	a7,17
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 458:	48c9                	li	a7,18
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 460:	48a1                	li	a7,8
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <link>:
.global link
link:
 li a7, SYS_link
 468:	48cd                	li	a7,19
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 470:	48d1                	li	a7,20
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 478:	48a5                	li	a7,9
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <dup>:
.global dup
dup:
 li a7, SYS_dup
 480:	48a9                	li	a7,10
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 488:	48ad                	li	a7,11
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 490:	48b1                	li	a7,12
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 498:	48b5                	li	a7,13
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4a0:	48b9                	li	a7,14
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a8:	1101                	addi	sp,sp,-32
 4aa:	ec06                	sd	ra,24(sp)
 4ac:	e822                	sd	s0,16(sp)
 4ae:	1000                	addi	s0,sp,32
 4b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b4:	4605                	li	a2,1
 4b6:	fef40593          	addi	a1,s0,-17
 4ba:	00000097          	auipc	ra,0x0
 4be:	f6e080e7          	jalr	-146(ra) # 428 <write>
}
 4c2:	60e2                	ld	ra,24(sp)
 4c4:	6442                	ld	s0,16(sp)
 4c6:	6105                	addi	sp,sp,32
 4c8:	8082                	ret

00000000000004ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ca:	7139                	addi	sp,sp,-64
 4cc:	fc06                	sd	ra,56(sp)
 4ce:	f822                	sd	s0,48(sp)
 4d0:	f426                	sd	s1,40(sp)
 4d2:	f04a                	sd	s2,32(sp)
 4d4:	ec4e                	sd	s3,24(sp)
 4d6:	0080                	addi	s0,sp,64
 4d8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4da:	c299                	beqz	a3,4e0 <printint+0x16>
 4dc:	0805c963          	bltz	a1,56e <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e0:	2581                	sext.w	a1,a1
  neg = 0;
 4e2:	4881                	li	a7,0
 4e4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4e8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ea:	2601                	sext.w	a2,a2
 4ec:	00000517          	auipc	a0,0x0
 4f0:	4b450513          	addi	a0,a0,1204 # 9a0 <digits>
 4f4:	883a                	mv	a6,a4
 4f6:	2705                	addiw	a4,a4,1
 4f8:	02c5f7bb          	remuw	a5,a1,a2
 4fc:	1782                	slli	a5,a5,0x20
 4fe:	9381                	srli	a5,a5,0x20
 500:	97aa                	add	a5,a5,a0
 502:	0007c783          	lbu	a5,0(a5)
 506:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 50a:	0005879b          	sext.w	a5,a1
 50e:	02c5d5bb          	divuw	a1,a1,a2
 512:	0685                	addi	a3,a3,1
 514:	fec7f0e3          	bgeu	a5,a2,4f4 <printint+0x2a>
  if(neg)
 518:	00088c63          	beqz	a7,530 <printint+0x66>
    buf[i++] = '-';
 51c:	fd070793          	addi	a5,a4,-48
 520:	00878733          	add	a4,a5,s0
 524:	02d00793          	li	a5,45
 528:	fef70823          	sb	a5,-16(a4)
 52c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 530:	02e05863          	blez	a4,560 <printint+0x96>
 534:	fc040793          	addi	a5,s0,-64
 538:	00e78933          	add	s2,a5,a4
 53c:	fff78993          	addi	s3,a5,-1
 540:	99ba                	add	s3,s3,a4
 542:	377d                	addiw	a4,a4,-1
 544:	1702                	slli	a4,a4,0x20
 546:	9301                	srli	a4,a4,0x20
 548:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54c:	fff94583          	lbu	a1,-1(s2)
 550:	8526                	mv	a0,s1
 552:	00000097          	auipc	ra,0x0
 556:	f56080e7          	jalr	-170(ra) # 4a8 <putc>
  while(--i >= 0)
 55a:	197d                	addi	s2,s2,-1
 55c:	ff3918e3          	bne	s2,s3,54c <printint+0x82>
}
 560:	70e2                	ld	ra,56(sp)
 562:	7442                	ld	s0,48(sp)
 564:	74a2                	ld	s1,40(sp)
 566:	7902                	ld	s2,32(sp)
 568:	69e2                	ld	s3,24(sp)
 56a:	6121                	addi	sp,sp,64
 56c:	8082                	ret
    x = -xx;
 56e:	40b005bb          	negw	a1,a1
    neg = 1;
 572:	4885                	li	a7,1
    x = -xx;
 574:	bf85                	j	4e4 <printint+0x1a>

0000000000000576 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 576:	7119                	addi	sp,sp,-128
 578:	fc86                	sd	ra,120(sp)
 57a:	f8a2                	sd	s0,112(sp)
 57c:	f4a6                	sd	s1,104(sp)
 57e:	f0ca                	sd	s2,96(sp)
 580:	ecce                	sd	s3,88(sp)
 582:	e8d2                	sd	s4,80(sp)
 584:	e4d6                	sd	s5,72(sp)
 586:	e0da                	sd	s6,64(sp)
 588:	fc5e                	sd	s7,56(sp)
 58a:	f862                	sd	s8,48(sp)
 58c:	f466                	sd	s9,40(sp)
 58e:	f06a                	sd	s10,32(sp)
 590:	ec6e                	sd	s11,24(sp)
 592:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 594:	0005c903          	lbu	s2,0(a1)
 598:	18090f63          	beqz	s2,736 <vprintf+0x1c0>
 59c:	8aaa                	mv	s5,a0
 59e:	8b32                	mv	s6,a2
 5a0:	00158493          	addi	s1,a1,1
  state = 0;
 5a4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a6:	02500a13          	li	s4,37
 5aa:	4c55                	li	s8,21
 5ac:	00000c97          	auipc	s9,0x0
 5b0:	39cc8c93          	addi	s9,s9,924 # 948 <malloc+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b4:	02800d93          	li	s11,40
  putc(fd, 'x');
 5b8:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ba:	00000b97          	auipc	s7,0x0
 5be:	3e6b8b93          	addi	s7,s7,998 # 9a0 <digits>
 5c2:	a839                	j	5e0 <vprintf+0x6a>
        putc(fd, c);
 5c4:	85ca                	mv	a1,s2
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	ee0080e7          	jalr	-288(ra) # 4a8 <putc>
 5d0:	a019                	j	5d6 <vprintf+0x60>
    } else if(state == '%'){
 5d2:	01498d63          	beq	s3,s4,5ec <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 5d6:	0485                	addi	s1,s1,1
 5d8:	fff4c903          	lbu	s2,-1(s1)
 5dc:	14090d63          	beqz	s2,736 <vprintf+0x1c0>
    if(state == 0){
 5e0:	fe0999e3          	bnez	s3,5d2 <vprintf+0x5c>
      if(c == '%'){
 5e4:	ff4910e3          	bne	s2,s4,5c4 <vprintf+0x4e>
        state = '%';
 5e8:	89d2                	mv	s3,s4
 5ea:	b7f5                	j	5d6 <vprintf+0x60>
      if(c == 'd'){
 5ec:	11490c63          	beq	s2,s4,704 <vprintf+0x18e>
 5f0:	f9d9079b          	addiw	a5,s2,-99
 5f4:	0ff7f793          	zext.b	a5,a5
 5f8:	10fc6e63          	bltu	s8,a5,714 <vprintf+0x19e>
 5fc:	f9d9079b          	addiw	a5,s2,-99
 600:	0ff7f713          	zext.b	a4,a5
 604:	10ec6863          	bltu	s8,a4,714 <vprintf+0x19e>
 608:	00271793          	slli	a5,a4,0x2
 60c:	97e6                	add	a5,a5,s9
 60e:	439c                	lw	a5,0(a5)
 610:	97e6                	add	a5,a5,s9
 612:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 614:	008b0913          	addi	s2,s6,8
 618:	4685                	li	a3,1
 61a:	4629                	li	a2,10
 61c:	000b2583          	lw	a1,0(s6)
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	ea8080e7          	jalr	-344(ra) # 4ca <printint>
 62a:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b765                	j	5d6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 630:	008b0913          	addi	s2,s6,8
 634:	4681                	li	a3,0
 636:	4629                	li	a2,10
 638:	000b2583          	lw	a1,0(s6)
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e8c080e7          	jalr	-372(ra) # 4ca <printint>
 646:	8b4a                	mv	s6,s2
      state = 0;
 648:	4981                	li	s3,0
 64a:	b771                	j	5d6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 64c:	008b0913          	addi	s2,s6,8
 650:	4681                	li	a3,0
 652:	866a                	mv	a2,s10
 654:	000b2583          	lw	a1,0(s6)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e70080e7          	jalr	-400(ra) # 4ca <printint>
 662:	8b4a                	mv	s6,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	bf85                	j	5d6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 668:	008b0793          	addi	a5,s6,8
 66c:	f8f43423          	sd	a5,-120(s0)
 670:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 674:	03000593          	li	a1,48
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e2e080e7          	jalr	-466(ra) # 4a8 <putc>
  putc(fd, 'x');
 682:	07800593          	li	a1,120
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	e20080e7          	jalr	-480(ra) # 4a8 <putc>
 690:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 692:	03c9d793          	srli	a5,s3,0x3c
 696:	97de                	add	a5,a5,s7
 698:	0007c583          	lbu	a1,0(a5)
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	e0a080e7          	jalr	-502(ra) # 4a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a6:	0992                	slli	s3,s3,0x4
 6a8:	397d                	addiw	s2,s2,-1
 6aa:	fe0914e3          	bnez	s2,692 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 6ae:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b70d                	j	5d6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6b6:	008b0913          	addi	s2,s6,8
 6ba:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 6be:	02098163          	beqz	s3,6e0 <vprintf+0x16a>
        while(*s != 0){
 6c2:	0009c583          	lbu	a1,0(s3)
 6c6:	c5ad                	beqz	a1,730 <vprintf+0x1ba>
          putc(fd, *s);
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	dde080e7          	jalr	-546(ra) # 4a8 <putc>
          s++;
 6d2:	0985                	addi	s3,s3,1
        while(*s != 0){
 6d4:	0009c583          	lbu	a1,0(s3)
 6d8:	f9e5                	bnez	a1,6c8 <vprintf+0x152>
        s = va_arg(ap, char*);
 6da:	8b4a                	mv	s6,s2
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	bde5                	j	5d6 <vprintf+0x60>
          s = "(null)";
 6e0:	00000997          	auipc	s3,0x0
 6e4:	26098993          	addi	s3,s3,608 # 940 <malloc+0x106>
        while(*s != 0){
 6e8:	85ee                	mv	a1,s11
 6ea:	bff9                	j	6c8 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 6ec:	008b0913          	addi	s2,s6,8
 6f0:	000b4583          	lbu	a1,0(s6)
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	db2080e7          	jalr	-590(ra) # 4a8 <putc>
 6fe:	8b4a                	mv	s6,s2
      state = 0;
 700:	4981                	li	s3,0
 702:	bdd1                	j	5d6 <vprintf+0x60>
        putc(fd, c);
 704:	85d2                	mv	a1,s4
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	da0080e7          	jalr	-608(ra) # 4a8 <putc>
      state = 0;
 710:	4981                	li	s3,0
 712:	b5d1                	j	5d6 <vprintf+0x60>
        putc(fd, '%');
 714:	85d2                	mv	a1,s4
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	d90080e7          	jalr	-624(ra) # 4a8 <putc>
        putc(fd, c);
 720:	85ca                	mv	a1,s2
 722:	8556                	mv	a0,s5
 724:	00000097          	auipc	ra,0x0
 728:	d84080e7          	jalr	-636(ra) # 4a8 <putc>
      state = 0;
 72c:	4981                	li	s3,0
 72e:	b565                	j	5d6 <vprintf+0x60>
        s = va_arg(ap, char*);
 730:	8b4a                	mv	s6,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	b54d                	j	5d6 <vprintf+0x60>
    }
  }
}
 736:	70e6                	ld	ra,120(sp)
 738:	7446                	ld	s0,112(sp)
 73a:	74a6                	ld	s1,104(sp)
 73c:	7906                	ld	s2,96(sp)
 73e:	69e6                	ld	s3,88(sp)
 740:	6a46                	ld	s4,80(sp)
 742:	6aa6                	ld	s5,72(sp)
 744:	6b06                	ld	s6,64(sp)
 746:	7be2                	ld	s7,56(sp)
 748:	7c42                	ld	s8,48(sp)
 74a:	7ca2                	ld	s9,40(sp)
 74c:	7d02                	ld	s10,32(sp)
 74e:	6de2                	ld	s11,24(sp)
 750:	6109                	addi	sp,sp,128
 752:	8082                	ret

0000000000000754 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 754:	715d                	addi	sp,sp,-80
 756:	ec06                	sd	ra,24(sp)
 758:	e822                	sd	s0,16(sp)
 75a:	1000                	addi	s0,sp,32
 75c:	e010                	sd	a2,0(s0)
 75e:	e414                	sd	a3,8(s0)
 760:	e818                	sd	a4,16(s0)
 762:	ec1c                	sd	a5,24(s0)
 764:	03043023          	sd	a6,32(s0)
 768:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 770:	8622                	mv	a2,s0
 772:	00000097          	auipc	ra,0x0
 776:	e04080e7          	jalr	-508(ra) # 576 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <printf>:

void
printf(const char *fmt, ...)
{
 782:	711d                	addi	sp,sp,-96
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e40c                	sd	a1,8(s0)
 78c:	e810                	sd	a2,16(s0)
 78e:	ec14                	sd	a3,24(s0)
 790:	f018                	sd	a4,32(s0)
 792:	f41c                	sd	a5,40(s0)
 794:	03043823          	sd	a6,48(s0)
 798:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	00840613          	addi	a2,s0,8
 7a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a4:	85aa                	mv	a1,a0
 7a6:	4505                	li	a0,1
 7a8:	00000097          	auipc	ra,0x0
 7ac:	dce080e7          	jalr	-562(ra) # 576 <vprintf>
}
 7b0:	60e2                	ld	ra,24(sp)
 7b2:	6442                	ld	s0,16(sp)
 7b4:	6125                	addi	sp,sp,96
 7b6:	8082                	ret

00000000000007b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e422                	sd	s0,8(sp)
 7bc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7be:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	00001797          	auipc	a5,0x1
 7c6:	83e7b783          	ld	a5,-1986(a5) # 1000 <freep>
 7ca:	a02d                	j	7f4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7cc:	4618                	lw	a4,8(a2)
 7ce:	9f2d                	addw	a4,a4,a1
 7d0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d4:	6398                	ld	a4,0(a5)
 7d6:	6310                	ld	a2,0(a4)
 7d8:	a83d                	j	816 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7da:	ff852703          	lw	a4,-8(a0)
 7de:	9f31                	addw	a4,a4,a2
 7e0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e2:	ff053683          	ld	a3,-16(a0)
 7e6:	a091                	j	82a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e7e463          	bltu	a5,a4,7f2 <free+0x3a>
 7ee:	00e6ea63          	bltu	a3,a4,802 <free+0x4a>
{
 7f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f4:	fed7fae3          	bgeu	a5,a3,7e8 <free+0x30>
 7f8:	6398                	ld	a4,0(a5)
 7fa:	00e6e463          	bltu	a3,a4,802 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	fee7eae3          	bltu	a5,a4,7f2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 802:	ff852583          	lw	a1,-8(a0)
 806:	6390                	ld	a2,0(a5)
 808:	02059813          	slli	a6,a1,0x20
 80c:	01c85713          	srli	a4,a6,0x1c
 810:	9736                	add	a4,a4,a3
 812:	fae60de3          	beq	a2,a4,7cc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 816:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 81a:	4790                	lw	a2,8(a5)
 81c:	02061593          	slli	a1,a2,0x20
 820:	01c5d713          	srli	a4,a1,0x1c
 824:	973e                	add	a4,a4,a5
 826:	fae68ae3          	beq	a3,a4,7da <free+0x22>
    p->s.ptr = bp->s.ptr;
 82a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 82c:	00000717          	auipc	a4,0x0
 830:	7cf73a23          	sd	a5,2004(a4) # 1000 <freep>
}
 834:	6422                	ld	s0,8(sp)
 836:	0141                	addi	sp,sp,16
 838:	8082                	ret

000000000000083a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 83a:	7139                	addi	sp,sp,-64
 83c:	fc06                	sd	ra,56(sp)
 83e:	f822                	sd	s0,48(sp)
 840:	f426                	sd	s1,40(sp)
 842:	f04a                	sd	s2,32(sp)
 844:	ec4e                	sd	s3,24(sp)
 846:	e852                	sd	s4,16(sp)
 848:	e456                	sd	s5,8(sp)
 84a:	e05a                	sd	s6,0(sp)
 84c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84e:	02051493          	slli	s1,a0,0x20
 852:	9081                	srli	s1,s1,0x20
 854:	04bd                	addi	s1,s1,15
 856:	8091                	srli	s1,s1,0x4
 858:	0014899b          	addiw	s3,s1,1
 85c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 85e:	00000517          	auipc	a0,0x0
 862:	7a253503          	ld	a0,1954(a0) # 1000 <freep>
 866:	c515                	beqz	a0,892 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86a:	4798                	lw	a4,8(a5)
 86c:	02977f63          	bgeu	a4,s1,8aa <malloc+0x70>
 870:	8a4e                	mv	s4,s3
 872:	0009871b          	sext.w	a4,s3
 876:	6685                	lui	a3,0x1
 878:	00d77363          	bgeu	a4,a3,87e <malloc+0x44>
 87c:	6a05                	lui	s4,0x1
 87e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 882:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 886:	00000917          	auipc	s2,0x0
 88a:	77a90913          	addi	s2,s2,1914 # 1000 <freep>
  if(p == (char*)-1)
 88e:	5afd                	li	s5,-1
 890:	a895                	j	904 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 892:	00000797          	auipc	a5,0x0
 896:	77e78793          	addi	a5,a5,1918 # 1010 <base>
 89a:	00000717          	auipc	a4,0x0
 89e:	76f73323          	sd	a5,1894(a4) # 1000 <freep>
 8a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a8:	b7e1                	j	870 <malloc+0x36>
      if(p->s.size == nunits)
 8aa:	02e48c63          	beq	s1,a4,8e2 <malloc+0xa8>
        p->s.size -= nunits;
 8ae:	4137073b          	subw	a4,a4,s3
 8b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b4:	02071693          	slli	a3,a4,0x20
 8b8:	01c6d713          	srli	a4,a3,0x1c
 8bc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8be:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c2:	00000717          	auipc	a4,0x0
 8c6:	72a73f23          	sd	a0,1854(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ca:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ce:	70e2                	ld	ra,56(sp)
 8d0:	7442                	ld	s0,48(sp)
 8d2:	74a2                	ld	s1,40(sp)
 8d4:	7902                	ld	s2,32(sp)
 8d6:	69e2                	ld	s3,24(sp)
 8d8:	6a42                	ld	s4,16(sp)
 8da:	6aa2                	ld	s5,8(sp)
 8dc:	6b02                	ld	s6,0(sp)
 8de:	6121                	addi	sp,sp,64
 8e0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	e118                	sd	a4,0(a0)
 8e6:	bff1                	j	8c2 <malloc+0x88>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	00000097          	auipc	ra,0x0
 8f2:	eca080e7          	jalr	-310(ra) # 7b8 <free>
  return freep;
 8f6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8fa:	d971                	beqz	a0,8ce <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fe:	4798                	lw	a4,8(a5)
 900:	fa9775e3          	bgeu	a4,s1,8aa <malloc+0x70>
    if(p == freep)
 904:	00093703          	ld	a4,0(s2)
 908:	853e                	mv	a0,a5
 90a:	fef719e3          	bne	a4,a5,8fc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 90e:	8552                	mv	a0,s4
 910:	00000097          	auipc	ra,0x0
 914:	b80080e7          	jalr	-1152(ra) # 490 <sbrk>
  if(p == (char*)-1)
 918:	fd5518e3          	bne	a0,s5,8e8 <malloc+0xae>
        return 0;
 91c:	4501                	li	a0,0
 91e:	bf45                	j	8ce <malloc+0x94>
