
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <streql>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int streql(const char *text, const char *pattern)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    if (!*pattern) {
   6:	0005c703          	lbu	a4,0(a1)
   a:	cb15                	beqz	a4,3e <streql+0x3e>
        return 0;
    }
    for (; *text && *pattern && *pattern == *text; ++text, ++pattern);
   c:	00054783          	lbu	a5,0(a0)
  10:	cf91                	beqz	a5,2c <streql+0x2c>
  12:	00f71f63          	bne	a4,a5,30 <streql+0x30>
  16:	0505                	addi	a0,a0,1
  18:	0585                	addi	a1,a1,1
  1a:	00054783          	lbu	a5,0(a0)
  1e:	cb99                	beqz	a5,34 <streql+0x34>
  20:	0005c703          	lbu	a4,0(a1)
  24:	f77d                	bnez	a4,12 <streql+0x12>
        return 0;
  26:	0017b513          	seqz	a0,a5
  2a:	a819                	j	40 <streql+0x40>
    if (!*pattern && !*text) {
        return 1;
    }
    return 0;
  2c:	4501                	li	a0,0
  2e:	a809                	j	40 <streql+0x40>
  30:	4501                	li	a0,0
  32:	a039                	j	40 <streql+0x40>
    if (!*pattern && !*text) {
  34:	0005c783          	lbu	a5,0(a1)
    return 0;
  38:	4501                	li	a0,0
    if (!*pattern && !*text) {
  3a:	d7f5                	beqz	a5,26 <streql+0x26>
  3c:	a011                	j	40 <streql+0x40>
        return 0;
  3e:	4501                	li	a0,0
}
  40:	6422                	ld	s0,8(sp)
  42:	0141                	addi	sp,sp,16
  44:	8082                	ret

0000000000000046 <find_1>:

void find_1(char *path, char *pattern)
{
  46:	d8010113          	addi	sp,sp,-640
  4a:	26113c23          	sd	ra,632(sp)
  4e:	26813823          	sd	s0,624(sp)
  52:	26913423          	sd	s1,616(sp)
  56:	27213023          	sd	s2,608(sp)
  5a:	25313c23          	sd	s3,600(sp)
  5e:	25413823          	sd	s4,592(sp)
  62:	25513423          	sd	s5,584(sp)
  66:	25613023          	sd	s6,576(sp)
  6a:	23713c23          	sd	s7,568(sp)
  6e:	0500                	addi	s0,sp,640
  70:	892a                	mv	s2,a0
  72:	89ae                	mv	s3,a1
    int fd;
    char buf[512], *p;
    struct stat st;
    struct dirent de;

    if ((fd = open(path, O_RDONLY)) < 0) {
  74:	4581                	li	a1,0
  76:	00000097          	auipc	ra,0x0
  7a:	4aa080e7          	jalr	1194(ra) # 520 <open>
  7e:	04054a63          	bltz	a0,d2 <find_1+0x8c>
  82:	84aa                	mv	s1,a0
        fprintf(2, "%s: cannot open %s\n", __func__, path);
        return;
    }

    if (fstat(fd, &st) < 0) {
  84:	d9840593          	addi	a1,s0,-616
  88:	00000097          	auipc	ra,0x0
  8c:	4b0080e7          	jalr	1200(ra) # 538 <fstat>
  90:	06054063          	bltz	a0,f0 <find_1+0xaa>
        fprintf(2, "%s: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type) {
  94:	da041703          	lh	a4,-608(s0)
  98:	4785                	li	a5,1
  9a:	06f70b63          	beq	a4,a5,110 <find_1+0xca>
            }
            break;
         default:
            break;
   }
    close(fd);
  9e:	8526                	mv	a0,s1
  a0:	00000097          	auipc	ra,0x0
  a4:	468080e7          	jalr	1128(ra) # 508 <close>
}
  a8:	27813083          	ld	ra,632(sp)
  ac:	27013403          	ld	s0,624(sp)
  b0:	26813483          	ld	s1,616(sp)
  b4:	26013903          	ld	s2,608(sp)
  b8:	25813983          	ld	s3,600(sp)
  bc:	25013a03          	ld	s4,592(sp)
  c0:	24813a83          	ld	s5,584(sp)
  c4:	24013b03          	ld	s6,576(sp)
  c8:	23813b83          	ld	s7,568(sp)
  cc:	28010113          	addi	sp,sp,640
  d0:	8082                	ret
        fprintf(2, "%s: cannot open %s\n", __func__, path);
  d2:	86ca                	mv	a3,s2
  d4:	00001617          	auipc	a2,0x1
  d8:	92c60613          	addi	a2,a2,-1748 # a00 <__func__.0>
  dc:	00001597          	auipc	a1,0x1
  e0:	93458593          	addi	a1,a1,-1740 # a10 <__func__.0+0x10>
  e4:	4509                	li	a0,2
  e6:	00000097          	auipc	ra,0x0
  ea:	746080e7          	jalr	1862(ra) # 82c <fprintf>
        return;
  ee:	bf6d                	j	a8 <find_1+0x62>
        fprintf(2, "%s: cannot stat %s\n", path);
  f0:	864a                	mv	a2,s2
  f2:	00001597          	auipc	a1,0x1
  f6:	93658593          	addi	a1,a1,-1738 # a28 <__func__.0+0x28>
  fa:	4509                	li	a0,2
  fc:	00000097          	auipc	ra,0x0
 100:	730080e7          	jalr	1840(ra) # 82c <fprintf>
        close(fd);
 104:	8526                	mv	a0,s1
 106:	00000097          	auipc	ra,0x0
 10a:	402080e7          	jalr	1026(ra) # 508 <close>
        return;
 10e:	bf69                	j	a8 <find_1+0x62>
            if (strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
 110:	854a                	mv	a0,s2
 112:	00000097          	auipc	ra,0x0
 116:	1aa080e7          	jalr	426(ra) # 2bc <strlen>
 11a:	2541                	addiw	a0,a0,16
 11c:	20000793          	li	a5,512
 120:	00a7ff63          	bgeu	a5,a0,13e <find_1+0xf8>
                printf("%s: path too long\n", __func__);
 124:	00001597          	auipc	a1,0x1
 128:	8dc58593          	addi	a1,a1,-1828 # a00 <__func__.0>
 12c:	00001517          	auipc	a0,0x1
 130:	91450513          	addi	a0,a0,-1772 # a40 <__func__.0+0x40>
 134:	00000097          	auipc	ra,0x0
 138:	726080e7          	jalr	1830(ra) # 85a <printf>
                break;
 13c:	b78d                	j	9e <find_1+0x58>
            strcpy(buf, path);
 13e:	85ca                	mv	a1,s2
 140:	db040513          	addi	a0,s0,-592
 144:	00000097          	auipc	ra,0x0
 148:	130080e7          	jalr	304(ra) # 274 <strcpy>
            p = buf + strlen(buf);
 14c:	db040513          	addi	a0,s0,-592
 150:	00000097          	auipc	ra,0x0
 154:	16c080e7          	jalr	364(ra) # 2bc <strlen>
 158:	1502                	slli	a0,a0,0x20
 15a:	9101                	srli	a0,a0,0x20
 15c:	db040793          	addi	a5,s0,-592
 160:	00a78933          	add	s2,a5,a0
            *p++ = '/';
 164:	00190a13          	addi	s4,s2,1
 168:	02f00793          	li	a5,47
 16c:	00f90023          	sb	a5,0(s2)
                    printf("%s\n", buf);
 170:	00001b97          	auipc	s7,0x1
 174:	8b0b8b93          	addi	s7,s7,-1872 # a20 <__func__.0+0x20>
                if (!streql(p, ".") && !streql(p, ".."))
 178:	00001a97          	auipc	s5,0x1
 17c:	8e0a8a93          	addi	s5,s5,-1824 # a58 <__func__.0+0x58>
 180:	00001b17          	auipc	s6,0x1
 184:	8e0b0b13          	addi	s6,s6,-1824 # a60 <__func__.0+0x60>
 188:	a01d                	j	1ae <find_1+0x168>
                    printf("%s\n", buf);
 18a:	db040593          	addi	a1,s0,-592
 18e:	855e                	mv	a0,s7
 190:	00000097          	auipc	ra,0x0
 194:	6ca080e7          	jalr	1738(ra) # 85a <printf>
 198:	a891                	j	1ec <find_1+0x1a6>
                if (stat(buf, &st) < 0) {
 19a:	d9840593          	addi	a1,s0,-616
 19e:	db040513          	addi	a0,s0,-592
 1a2:	00000097          	auipc	ra,0x0
 1a6:	1fe080e7          	jalr	510(ra) # 3a0 <stat>
 1aa:	06054763          	bltz	a0,218 <find_1+0x1d2>
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ae:	4641                	li	a2,16
 1b0:	d8840593          	addi	a1,s0,-632
 1b4:	8526                	mv	a0,s1
 1b6:	00000097          	auipc	ra,0x0
 1ba:	342080e7          	jalr	834(ra) # 4f8 <read>
 1be:	47c1                	li	a5,16
 1c0:	ecf51fe3          	bne	a0,a5,9e <find_1+0x58>
                if (de.inum == 0)
 1c4:	d8845783          	lhu	a5,-632(s0)
 1c8:	d3fd                	beqz	a5,1ae <find_1+0x168>
                memmove(p, de.name, DIRSIZ);
 1ca:	4639                	li	a2,14
 1cc:	d8a40593          	addi	a1,s0,-630
 1d0:	8552                	mv	a0,s4
 1d2:	00000097          	auipc	ra,0x0
 1d6:	25c080e7          	jalr	604(ra) # 42e <memmove>
                p[DIRSIZ] = 0;
 1da:	000907a3          	sb	zero,15(s2)
                if (streql(p, pattern))
 1de:	85ce                	mv	a1,s3
 1e0:	8552                	mv	a0,s4
 1e2:	00000097          	auipc	ra,0x0
 1e6:	e1e080e7          	jalr	-482(ra) # 0 <streql>
 1ea:	f145                	bnez	a0,18a <find_1+0x144>
                if (!streql(p, ".") && !streql(p, ".."))
 1ec:	85d6                	mv	a1,s5
 1ee:	8552                	mv	a0,s4
 1f0:	00000097          	auipc	ra,0x0
 1f4:	e10080e7          	jalr	-496(ra) # 0 <streql>
 1f8:	f14d                	bnez	a0,19a <find_1+0x154>
 1fa:	85da                	mv	a1,s6
 1fc:	8552                	mv	a0,s4
 1fe:	00000097          	auipc	ra,0x0
 202:	e02080e7          	jalr	-510(ra) # 0 <streql>
 206:	f951                	bnez	a0,19a <find_1+0x154>
                    find_1(buf, pattern);
 208:	85ce                	mv	a1,s3
 20a:	db040513          	addi	a0,s0,-592
 20e:	00000097          	auipc	ra,0x0
 212:	e38080e7          	jalr	-456(ra) # 46 <find_1>
 216:	b751                	j	19a <find_1+0x154>
                    printf("%s: cannot stat %s\n", buf);
 218:	db040593          	addi	a1,s0,-592
 21c:	00001517          	auipc	a0,0x1
 220:	80c50513          	addi	a0,a0,-2036 # a28 <__func__.0+0x28>
 224:	00000097          	auipc	ra,0x0
 228:	636080e7          	jalr	1590(ra) # 85a <printf>
                    continue;
 22c:	b7b1                	j	178 <find_1+0x132>

000000000000022e <help>:

void help(void)
{}
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret

000000000000023a <main>:

int main(int argc, char **argv)
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e406                	sd	ra,8(sp)
 23e:	e022                	sd	s0,0(sp)
 240:	0800                	addi	s0,sp,16
 242:	87ae                	mv	a5,a1
    if (argc < 3)
        help();

    find_1(argv[1], argv[2]);
 244:	698c                	ld	a1,16(a1)
 246:	6788                	ld	a0,8(a5)
 248:	00000097          	auipc	ra,0x0
 24c:	dfe080e7          	jalr	-514(ra) # 46 <find_1>
    return 0;
}
 250:	4501                	li	a0,0
 252:	60a2                	ld	ra,8(sp)
 254:	6402                	ld	s0,0(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	addi	s0,sp,16
  extern int main();
  main();
 262:	00000097          	auipc	ra,0x0
 266:	fd8080e7          	jalr	-40(ra) # 23a <main>
  exit(0);
 26a:	4501                	li	a0,0
 26c:	00000097          	auipc	ra,0x0
 270:	274080e7          	jalr	628(ra) # 4e0 <exit>

0000000000000274 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 274:	1141                	addi	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	87aa                	mv	a5,a0
 27c:	0585                	addi	a1,a1,1
 27e:	0785                	addi	a5,a5,1
 280:	fff5c703          	lbu	a4,-1(a1)
 284:	fee78fa3          	sb	a4,-1(a5)
 288:	fb75                	bnez	a4,27c <strcpy+0x8>
    ;
  return os;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret

0000000000000290 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cb91                	beqz	a5,2ae <strcmp+0x1e>
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	00f71763          	bne	a4,a5,2ae <strcmp+0x1e>
    p++, q++;
 2a4:	0505                	addi	a0,a0,1
 2a6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbe5                	bnez	a5,29c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2ae:	0005c503          	lbu	a0,0(a1)
}
 2b2:	40a7853b          	subw	a0,a5,a0
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strlen>:

uint
strlen(const char *s)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cf91                	beqz	a5,2e2 <strlen+0x26>
 2c8:	0505                	addi	a0,a0,1
 2ca:	87aa                	mv	a5,a0
 2cc:	4685                	li	a3,1
 2ce:	9e89                	subw	a3,a3,a0
 2d0:	00f6853b          	addw	a0,a3,a5
 2d4:	0785                	addi	a5,a5,1
 2d6:	fff7c703          	lbu	a4,-1(a5)
 2da:	fb7d                	bnez	a4,2d0 <strlen+0x14>
    ;
  return n;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret
  for(n = 0; s[n]; n++)
 2e2:	4501                	li	a0,0
 2e4:	bfe5                	j	2dc <strlen+0x20>

00000000000002e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ec:	ca19                	beqz	a2,302 <memset+0x1c>
 2ee:	87aa                	mv	a5,a0
 2f0:	1602                	slli	a2,a2,0x20
 2f2:	9201                	srli	a2,a2,0x20
 2f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2fc:	0785                	addi	a5,a5,1
 2fe:	fee79de3          	bne	a5,a4,2f8 <memset+0x12>
  }
  return dst;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <strchr>:

char*
strchr(const char *s, char c)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 30e:	00054783          	lbu	a5,0(a0)
 312:	cb99                	beqz	a5,328 <strchr+0x20>
    if(*s == c)
 314:	00f58763          	beq	a1,a5,322 <strchr+0x1a>
  for(; *s; s++)
 318:	0505                	addi	a0,a0,1
 31a:	00054783          	lbu	a5,0(a0)
 31e:	fbfd                	bnez	a5,314 <strchr+0xc>
      return (char*)s;
  return 0;
 320:	4501                	li	a0,0
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret
  return 0;
 328:	4501                	li	a0,0
 32a:	bfe5                	j	322 <strchr+0x1a>

000000000000032c <gets>:

char*
gets(char *buf, int max)
{
 32c:	711d                	addi	sp,sp,-96
 32e:	ec86                	sd	ra,88(sp)
 330:	e8a2                	sd	s0,80(sp)
 332:	e4a6                	sd	s1,72(sp)
 334:	e0ca                	sd	s2,64(sp)
 336:	fc4e                	sd	s3,56(sp)
 338:	f852                	sd	s4,48(sp)
 33a:	f456                	sd	s5,40(sp)
 33c:	f05a                	sd	s6,32(sp)
 33e:	ec5e                	sd	s7,24(sp)
 340:	1080                	addi	s0,sp,96
 342:	8baa                	mv	s7,a0
 344:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 346:	892a                	mv	s2,a0
 348:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 34a:	4aa9                	li	s5,10
 34c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 34e:	89a6                	mv	s3,s1
 350:	2485                	addiw	s1,s1,1
 352:	0344d863          	bge	s1,s4,382 <gets+0x56>
    cc = read(0, &c, 1);
 356:	4605                	li	a2,1
 358:	faf40593          	addi	a1,s0,-81
 35c:	4501                	li	a0,0
 35e:	00000097          	auipc	ra,0x0
 362:	19a080e7          	jalr	410(ra) # 4f8 <read>
    if(cc < 1)
 366:	00a05e63          	blez	a0,382 <gets+0x56>
    buf[i++] = c;
 36a:	faf44783          	lbu	a5,-81(s0)
 36e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 372:	01578763          	beq	a5,s5,380 <gets+0x54>
 376:	0905                	addi	s2,s2,1
 378:	fd679be3          	bne	a5,s6,34e <gets+0x22>
  for(i=0; i+1 < max; ){
 37c:	89a6                	mv	s3,s1
 37e:	a011                	j	382 <gets+0x56>
 380:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 382:	99de                	add	s3,s3,s7
 384:	00098023          	sb	zero,0(s3)
  return buf;
}
 388:	855e                	mv	a0,s7
 38a:	60e6                	ld	ra,88(sp)
 38c:	6446                	ld	s0,80(sp)
 38e:	64a6                	ld	s1,72(sp)
 390:	6906                	ld	s2,64(sp)
 392:	79e2                	ld	s3,56(sp)
 394:	7a42                	ld	s4,48(sp)
 396:	7aa2                	ld	s5,40(sp)
 398:	7b02                	ld	s6,32(sp)
 39a:	6be2                	ld	s7,24(sp)
 39c:	6125                	addi	sp,sp,96
 39e:	8082                	ret

00000000000003a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a0:	1101                	addi	sp,sp,-32
 3a2:	ec06                	sd	ra,24(sp)
 3a4:	e822                	sd	s0,16(sp)
 3a6:	e426                	sd	s1,8(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ae:	4581                	li	a1,0
 3b0:	00000097          	auipc	ra,0x0
 3b4:	170080e7          	jalr	368(ra) # 520 <open>
  if(fd < 0)
 3b8:	02054563          	bltz	a0,3e2 <stat+0x42>
 3bc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3be:	85ca                	mv	a1,s2
 3c0:	00000097          	auipc	ra,0x0
 3c4:	178080e7          	jalr	376(ra) # 538 <fstat>
 3c8:	892a                	mv	s2,a0
  close(fd);
 3ca:	8526                	mv	a0,s1
 3cc:	00000097          	auipc	ra,0x0
 3d0:	13c080e7          	jalr	316(ra) # 508 <close>
  return r;
}
 3d4:	854a                	mv	a0,s2
 3d6:	60e2                	ld	ra,24(sp)
 3d8:	6442                	ld	s0,16(sp)
 3da:	64a2                	ld	s1,8(sp)
 3dc:	6902                	ld	s2,0(sp)
 3de:	6105                	addi	sp,sp,32
 3e0:	8082                	ret
    return -1;
 3e2:	597d                	li	s2,-1
 3e4:	bfc5                	j	3d4 <stat+0x34>

00000000000003e6 <atoi>:

int
atoi(const char *s)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e422                	sd	s0,8(sp)
 3ea:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ec:	00054683          	lbu	a3,0(a0)
 3f0:	fd06879b          	addiw	a5,a3,-48
 3f4:	0ff7f793          	zext.b	a5,a5
 3f8:	4625                	li	a2,9
 3fa:	02f66863          	bltu	a2,a5,42a <atoi+0x44>
 3fe:	872a                	mv	a4,a0
  n = 0;
 400:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 402:	0705                	addi	a4,a4,1
 404:	0025179b          	slliw	a5,a0,0x2
 408:	9fa9                	addw	a5,a5,a0
 40a:	0017979b          	slliw	a5,a5,0x1
 40e:	9fb5                	addw	a5,a5,a3
 410:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 414:	00074683          	lbu	a3,0(a4)
 418:	fd06879b          	addiw	a5,a3,-48
 41c:	0ff7f793          	zext.b	a5,a5
 420:	fef671e3          	bgeu	a2,a5,402 <atoi+0x1c>
  return n;
}
 424:	6422                	ld	s0,8(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret
  n = 0;
 42a:	4501                	li	a0,0
 42c:	bfe5                	j	424 <atoi+0x3e>

000000000000042e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 42e:	1141                	addi	sp,sp,-16
 430:	e422                	sd	s0,8(sp)
 432:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 434:	02b57463          	bgeu	a0,a1,45c <memmove+0x2e>
    while(n-- > 0)
 438:	00c05f63          	blez	a2,456 <memmove+0x28>
 43c:	1602                	slli	a2,a2,0x20
 43e:	9201                	srli	a2,a2,0x20
 440:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 444:	872a                	mv	a4,a0
      *dst++ = *src++;
 446:	0585                	addi	a1,a1,1
 448:	0705                	addi	a4,a4,1
 44a:	fff5c683          	lbu	a3,-1(a1)
 44e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 452:	fee79ae3          	bne	a5,a4,446 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 456:	6422                	ld	s0,8(sp)
 458:	0141                	addi	sp,sp,16
 45a:	8082                	ret
    dst += n;
 45c:	00c50733          	add	a4,a0,a2
    src += n;
 460:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 462:	fec05ae3          	blez	a2,456 <memmove+0x28>
 466:	fff6079b          	addiw	a5,a2,-1
 46a:	1782                	slli	a5,a5,0x20
 46c:	9381                	srli	a5,a5,0x20
 46e:	fff7c793          	not	a5,a5
 472:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 474:	15fd                	addi	a1,a1,-1
 476:	177d                	addi	a4,a4,-1
 478:	0005c683          	lbu	a3,0(a1)
 47c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 480:	fee79ae3          	bne	a5,a4,474 <memmove+0x46>
 484:	bfc9                	j	456 <memmove+0x28>

0000000000000486 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 486:	1141                	addi	sp,sp,-16
 488:	e422                	sd	s0,8(sp)
 48a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 48c:	ca05                	beqz	a2,4bc <memcmp+0x36>
 48e:	fff6069b          	addiw	a3,a2,-1
 492:	1682                	slli	a3,a3,0x20
 494:	9281                	srli	a3,a3,0x20
 496:	0685                	addi	a3,a3,1
 498:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 49a:	00054783          	lbu	a5,0(a0)
 49e:	0005c703          	lbu	a4,0(a1)
 4a2:	00e79863          	bne	a5,a4,4b2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4a6:	0505                	addi	a0,a0,1
    p2++;
 4a8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4aa:	fed518e3          	bne	a0,a3,49a <memcmp+0x14>
  }
  return 0;
 4ae:	4501                	li	a0,0
 4b0:	a019                	j	4b6 <memcmp+0x30>
      return *p1 - *p2;
 4b2:	40e7853b          	subw	a0,a5,a4
}
 4b6:	6422                	ld	s0,8(sp)
 4b8:	0141                	addi	sp,sp,16
 4ba:	8082                	ret
  return 0;
 4bc:	4501                	li	a0,0
 4be:	bfe5                	j	4b6 <memcmp+0x30>

00000000000004c0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e406                	sd	ra,8(sp)
 4c4:	e022                	sd	s0,0(sp)
 4c6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4c8:	00000097          	auipc	ra,0x0
 4cc:	f66080e7          	jalr	-154(ra) # 42e <memmove>
}
 4d0:	60a2                	ld	ra,8(sp)
 4d2:	6402                	ld	s0,0(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4d8:	4885                	li	a7,1
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e0:	4889                	li	a7,2
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4e8:	488d                	li	a7,3
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f0:	4891                	li	a7,4
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <read>:
.global read
read:
 li a7, SYS_read
 4f8:	4895                	li	a7,5
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <write>:
.global write
write:
 li a7, SYS_write
 500:	48c1                	li	a7,16
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <close>:
.global close
close:
 li a7, SYS_close
 508:	48d5                	li	a7,21
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <kill>:
.global kill
kill:
 li a7, SYS_kill
 510:	4899                	li	a7,6
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <exec>:
.global exec
exec:
 li a7, SYS_exec
 518:	489d                	li	a7,7
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <open>:
.global open
open:
 li a7, SYS_open
 520:	48bd                	li	a7,15
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 528:	48c5                	li	a7,17
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 530:	48c9                	li	a7,18
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 538:	48a1                	li	a7,8
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <link>:
.global link
link:
 li a7, SYS_link
 540:	48cd                	li	a7,19
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 548:	48d1                	li	a7,20
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 550:	48a5                	li	a7,9
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <dup>:
.global dup
dup:
 li a7, SYS_dup
 558:	48a9                	li	a7,10
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 560:	48ad                	li	a7,11
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 568:	48b1                	li	a7,12
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 570:	48b5                	li	a7,13
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 578:	48b9                	li	a7,14
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 580:	1101                	addi	sp,sp,-32
 582:	ec06                	sd	ra,24(sp)
 584:	e822                	sd	s0,16(sp)
 586:	1000                	addi	s0,sp,32
 588:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 58c:	4605                	li	a2,1
 58e:	fef40593          	addi	a1,s0,-17
 592:	00000097          	auipc	ra,0x0
 596:	f6e080e7          	jalr	-146(ra) # 500 <write>
}
 59a:	60e2                	ld	ra,24(sp)
 59c:	6442                	ld	s0,16(sp)
 59e:	6105                	addi	sp,sp,32
 5a0:	8082                	ret

00000000000005a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a2:	7139                	addi	sp,sp,-64
 5a4:	fc06                	sd	ra,56(sp)
 5a6:	f822                	sd	s0,48(sp)
 5a8:	f426                	sd	s1,40(sp)
 5aa:	f04a                	sd	s2,32(sp)
 5ac:	ec4e                	sd	s3,24(sp)
 5ae:	0080                	addi	s0,sp,64
 5b0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b2:	c299                	beqz	a3,5b8 <printint+0x16>
 5b4:	0805c963          	bltz	a1,646 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b8:	2581                	sext.w	a1,a1
  neg = 0;
 5ba:	4881                	li	a7,0
 5bc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5c0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5c2:	2601                	sext.w	a2,a2
 5c4:	00000517          	auipc	a0,0x0
 5c8:	50450513          	addi	a0,a0,1284 # ac8 <digits>
 5cc:	883a                	mv	a6,a4
 5ce:	2705                	addiw	a4,a4,1
 5d0:	02c5f7bb          	remuw	a5,a1,a2
 5d4:	1782                	slli	a5,a5,0x20
 5d6:	9381                	srli	a5,a5,0x20
 5d8:	97aa                	add	a5,a5,a0
 5da:	0007c783          	lbu	a5,0(a5)
 5de:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5e2:	0005879b          	sext.w	a5,a1
 5e6:	02c5d5bb          	divuw	a1,a1,a2
 5ea:	0685                	addi	a3,a3,1
 5ec:	fec7f0e3          	bgeu	a5,a2,5cc <printint+0x2a>
  if(neg)
 5f0:	00088c63          	beqz	a7,608 <printint+0x66>
    buf[i++] = '-';
 5f4:	fd070793          	addi	a5,a4,-48
 5f8:	00878733          	add	a4,a5,s0
 5fc:	02d00793          	li	a5,45
 600:	fef70823          	sb	a5,-16(a4)
 604:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 608:	02e05863          	blez	a4,638 <printint+0x96>
 60c:	fc040793          	addi	a5,s0,-64
 610:	00e78933          	add	s2,a5,a4
 614:	fff78993          	addi	s3,a5,-1
 618:	99ba                	add	s3,s3,a4
 61a:	377d                	addiw	a4,a4,-1
 61c:	1702                	slli	a4,a4,0x20
 61e:	9301                	srli	a4,a4,0x20
 620:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 624:	fff94583          	lbu	a1,-1(s2)
 628:	8526                	mv	a0,s1
 62a:	00000097          	auipc	ra,0x0
 62e:	f56080e7          	jalr	-170(ra) # 580 <putc>
  while(--i >= 0)
 632:	197d                	addi	s2,s2,-1
 634:	ff3918e3          	bne	s2,s3,624 <printint+0x82>
}
 638:	70e2                	ld	ra,56(sp)
 63a:	7442                	ld	s0,48(sp)
 63c:	74a2                	ld	s1,40(sp)
 63e:	7902                	ld	s2,32(sp)
 640:	69e2                	ld	s3,24(sp)
 642:	6121                	addi	sp,sp,64
 644:	8082                	ret
    x = -xx;
 646:	40b005bb          	negw	a1,a1
    neg = 1;
 64a:	4885                	li	a7,1
    x = -xx;
 64c:	bf85                	j	5bc <printint+0x1a>

000000000000064e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 64e:	7119                	addi	sp,sp,-128
 650:	fc86                	sd	ra,120(sp)
 652:	f8a2                	sd	s0,112(sp)
 654:	f4a6                	sd	s1,104(sp)
 656:	f0ca                	sd	s2,96(sp)
 658:	ecce                	sd	s3,88(sp)
 65a:	e8d2                	sd	s4,80(sp)
 65c:	e4d6                	sd	s5,72(sp)
 65e:	e0da                	sd	s6,64(sp)
 660:	fc5e                	sd	s7,56(sp)
 662:	f862                	sd	s8,48(sp)
 664:	f466                	sd	s9,40(sp)
 666:	f06a                	sd	s10,32(sp)
 668:	ec6e                	sd	s11,24(sp)
 66a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 66c:	0005c903          	lbu	s2,0(a1)
 670:	18090f63          	beqz	s2,80e <vprintf+0x1c0>
 674:	8aaa                	mv	s5,a0
 676:	8b32                	mv	s6,a2
 678:	00158493          	addi	s1,a1,1
  state = 0;
 67c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 67e:	02500a13          	li	s4,37
 682:	4c55                	li	s8,21
 684:	00000c97          	auipc	s9,0x0
 688:	3ecc8c93          	addi	s9,s9,1004 # a70 <__func__.0+0x70>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 68c:	02800d93          	li	s11,40
  putc(fd, 'x');
 690:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 692:	00000b97          	auipc	s7,0x0
 696:	436b8b93          	addi	s7,s7,1078 # ac8 <digits>
 69a:	a839                	j	6b8 <vprintf+0x6a>
        putc(fd, c);
 69c:	85ca                	mv	a1,s2
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	ee0080e7          	jalr	-288(ra) # 580 <putc>
 6a8:	a019                	j	6ae <vprintf+0x60>
    } else if(state == '%'){
 6aa:	01498d63          	beq	s3,s4,6c4 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6ae:	0485                	addi	s1,s1,1
 6b0:	fff4c903          	lbu	s2,-1(s1)
 6b4:	14090d63          	beqz	s2,80e <vprintf+0x1c0>
    if(state == 0){
 6b8:	fe0999e3          	bnez	s3,6aa <vprintf+0x5c>
      if(c == '%'){
 6bc:	ff4910e3          	bne	s2,s4,69c <vprintf+0x4e>
        state = '%';
 6c0:	89d2                	mv	s3,s4
 6c2:	b7f5                	j	6ae <vprintf+0x60>
      if(c == 'd'){
 6c4:	11490c63          	beq	s2,s4,7dc <vprintf+0x18e>
 6c8:	f9d9079b          	addiw	a5,s2,-99
 6cc:	0ff7f793          	zext.b	a5,a5
 6d0:	10fc6e63          	bltu	s8,a5,7ec <vprintf+0x19e>
 6d4:	f9d9079b          	addiw	a5,s2,-99
 6d8:	0ff7f713          	zext.b	a4,a5
 6dc:	10ec6863          	bltu	s8,a4,7ec <vprintf+0x19e>
 6e0:	00271793          	slli	a5,a4,0x2
 6e4:	97e6                	add	a5,a5,s9
 6e6:	439c                	lw	a5,0(a5)
 6e8:	97e6                	add	a5,a5,s9
 6ea:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6ec:	008b0913          	addi	s2,s6,8
 6f0:	4685                	li	a3,1
 6f2:	4629                	li	a2,10
 6f4:	000b2583          	lw	a1,0(s6)
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	ea8080e7          	jalr	-344(ra) # 5a2 <printint>
 702:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 704:	4981                	li	s3,0
 706:	b765                	j	6ae <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 708:	008b0913          	addi	s2,s6,8
 70c:	4681                	li	a3,0
 70e:	4629                	li	a2,10
 710:	000b2583          	lw	a1,0(s6)
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	e8c080e7          	jalr	-372(ra) # 5a2 <printint>
 71e:	8b4a                	mv	s6,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	b771                	j	6ae <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 724:	008b0913          	addi	s2,s6,8
 728:	4681                	li	a3,0
 72a:	866a                	mv	a2,s10
 72c:	000b2583          	lw	a1,0(s6)
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e70080e7          	jalr	-400(ra) # 5a2 <printint>
 73a:	8b4a                	mv	s6,s2
      state = 0;
 73c:	4981                	li	s3,0
 73e:	bf85                	j	6ae <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 740:	008b0793          	addi	a5,s6,8
 744:	f8f43423          	sd	a5,-120(s0)
 748:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 74c:	03000593          	li	a1,48
 750:	8556                	mv	a0,s5
 752:	00000097          	auipc	ra,0x0
 756:	e2e080e7          	jalr	-466(ra) # 580 <putc>
  putc(fd, 'x');
 75a:	07800593          	li	a1,120
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	e20080e7          	jalr	-480(ra) # 580 <putc>
 768:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76a:	03c9d793          	srli	a5,s3,0x3c
 76e:	97de                	add	a5,a5,s7
 770:	0007c583          	lbu	a1,0(a5)
 774:	8556                	mv	a0,s5
 776:	00000097          	auipc	ra,0x0
 77a:	e0a080e7          	jalr	-502(ra) # 580 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77e:	0992                	slli	s3,s3,0x4
 780:	397d                	addiw	s2,s2,-1
 782:	fe0914e3          	bnez	s2,76a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 786:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 78a:	4981                	li	s3,0
 78c:	b70d                	j	6ae <vprintf+0x60>
        s = va_arg(ap, char*);
 78e:	008b0913          	addi	s2,s6,8
 792:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 796:	02098163          	beqz	s3,7b8 <vprintf+0x16a>
        while(*s != 0){
 79a:	0009c583          	lbu	a1,0(s3)
 79e:	c5ad                	beqz	a1,808 <vprintf+0x1ba>
          putc(fd, *s);
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	dde080e7          	jalr	-546(ra) # 580 <putc>
          s++;
 7aa:	0985                	addi	s3,s3,1
        while(*s != 0){
 7ac:	0009c583          	lbu	a1,0(s3)
 7b0:	f9e5                	bnez	a1,7a0 <vprintf+0x152>
        s = va_arg(ap, char*);
 7b2:	8b4a                	mv	s6,s2
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	bde5                	j	6ae <vprintf+0x60>
          s = "(null)";
 7b8:	00000997          	auipc	s3,0x0
 7bc:	2b098993          	addi	s3,s3,688 # a68 <__func__.0+0x68>
        while(*s != 0){
 7c0:	85ee                	mv	a1,s11
 7c2:	bff9                	j	7a0 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 7c4:	008b0913          	addi	s2,s6,8
 7c8:	000b4583          	lbu	a1,0(s6)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	db2080e7          	jalr	-590(ra) # 580 <putc>
 7d6:	8b4a                	mv	s6,s2
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	bdd1                	j	6ae <vprintf+0x60>
        putc(fd, c);
 7dc:	85d2                	mv	a1,s4
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	da0080e7          	jalr	-608(ra) # 580 <putc>
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	b5d1                	j	6ae <vprintf+0x60>
        putc(fd, '%');
 7ec:	85d2                	mv	a1,s4
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	d90080e7          	jalr	-624(ra) # 580 <putc>
        putc(fd, c);
 7f8:	85ca                	mv	a1,s2
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	d84080e7          	jalr	-636(ra) # 580 <putc>
      state = 0;
 804:	4981                	li	s3,0
 806:	b565                	j	6ae <vprintf+0x60>
        s = va_arg(ap, char*);
 808:	8b4a                	mv	s6,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b54d                	j	6ae <vprintf+0x60>
    }
  }
}
 80e:	70e6                	ld	ra,120(sp)
 810:	7446                	ld	s0,112(sp)
 812:	74a6                	ld	s1,104(sp)
 814:	7906                	ld	s2,96(sp)
 816:	69e6                	ld	s3,88(sp)
 818:	6a46                	ld	s4,80(sp)
 81a:	6aa6                	ld	s5,72(sp)
 81c:	6b06                	ld	s6,64(sp)
 81e:	7be2                	ld	s7,56(sp)
 820:	7c42                	ld	s8,48(sp)
 822:	7ca2                	ld	s9,40(sp)
 824:	7d02                	ld	s10,32(sp)
 826:	6de2                	ld	s11,24(sp)
 828:	6109                	addi	sp,sp,128
 82a:	8082                	ret

000000000000082c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82c:	715d                	addi	sp,sp,-80
 82e:	ec06                	sd	ra,24(sp)
 830:	e822                	sd	s0,16(sp)
 832:	1000                	addi	s0,sp,32
 834:	e010                	sd	a2,0(s0)
 836:	e414                	sd	a3,8(s0)
 838:	e818                	sd	a4,16(s0)
 83a:	ec1c                	sd	a5,24(s0)
 83c:	03043023          	sd	a6,32(s0)
 840:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 844:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 848:	8622                	mv	a2,s0
 84a:	00000097          	auipc	ra,0x0
 84e:	e04080e7          	jalr	-508(ra) # 64e <vprintf>
}
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	6161                	addi	sp,sp,80
 858:	8082                	ret

000000000000085a <printf>:

void
printf(const char *fmt, ...)
{
 85a:	711d                	addi	sp,sp,-96
 85c:	ec06                	sd	ra,24(sp)
 85e:	e822                	sd	s0,16(sp)
 860:	1000                	addi	s0,sp,32
 862:	e40c                	sd	a1,8(s0)
 864:	e810                	sd	a2,16(s0)
 866:	ec14                	sd	a3,24(s0)
 868:	f018                	sd	a4,32(s0)
 86a:	f41c                	sd	a5,40(s0)
 86c:	03043823          	sd	a6,48(s0)
 870:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 874:	00840613          	addi	a2,s0,8
 878:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87c:	85aa                	mv	a1,a0
 87e:	4505                	li	a0,1
 880:	00000097          	auipc	ra,0x0
 884:	dce080e7          	jalr	-562(ra) # 64e <vprintf>
}
 888:	60e2                	ld	ra,24(sp)
 88a:	6442                	ld	s0,16(sp)
 88c:	6125                	addi	sp,sp,96
 88e:	8082                	ret

0000000000000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	1141                	addi	sp,sp,-16
 892:	e422                	sd	s0,8(sp)
 894:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 896:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	00000797          	auipc	a5,0x0
 89e:	7667b783          	ld	a5,1894(a5) # 1000 <freep>
 8a2:	a02d                	j	8cc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a4:	4618                	lw	a4,8(a2)
 8a6:	9f2d                	addw	a4,a4,a1
 8a8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ac:	6398                	ld	a4,0(a5)
 8ae:	6310                	ld	a2,0(a4)
 8b0:	a83d                	j	8ee <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b2:	ff852703          	lw	a4,-8(a0)
 8b6:	9f31                	addw	a4,a4,a2
 8b8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ba:	ff053683          	ld	a3,-16(a0)
 8be:	a091                	j	902 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	6398                	ld	a4,0(a5)
 8c2:	00e7e463          	bltu	a5,a4,8ca <free+0x3a>
 8c6:	00e6ea63          	bltu	a3,a4,8da <free+0x4a>
{
 8ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	fed7fae3          	bgeu	a5,a3,8c0 <free+0x30>
 8d0:	6398                	ld	a4,0(a5)
 8d2:	00e6e463          	bltu	a3,a4,8da <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	fee7eae3          	bltu	a5,a4,8ca <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8da:	ff852583          	lw	a1,-8(a0)
 8de:	6390                	ld	a2,0(a5)
 8e0:	02059813          	slli	a6,a1,0x20
 8e4:	01c85713          	srli	a4,a6,0x1c
 8e8:	9736                	add	a4,a4,a3
 8ea:	fae60de3          	beq	a2,a4,8a4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f2:	4790                	lw	a2,8(a5)
 8f4:	02061593          	slli	a1,a2,0x20
 8f8:	01c5d713          	srli	a4,a1,0x1c
 8fc:	973e                	add	a4,a4,a5
 8fe:	fae68ae3          	beq	a3,a4,8b2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 902:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 904:	00000717          	auipc	a4,0x0
 908:	6ef73e23          	sd	a5,1788(a4) # 1000 <freep>
}
 90c:	6422                	ld	s0,8(sp)
 90e:	0141                	addi	sp,sp,16
 910:	8082                	ret

0000000000000912 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 912:	7139                	addi	sp,sp,-64
 914:	fc06                	sd	ra,56(sp)
 916:	f822                	sd	s0,48(sp)
 918:	f426                	sd	s1,40(sp)
 91a:	f04a                	sd	s2,32(sp)
 91c:	ec4e                	sd	s3,24(sp)
 91e:	e852                	sd	s4,16(sp)
 920:	e456                	sd	s5,8(sp)
 922:	e05a                	sd	s6,0(sp)
 924:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 926:	02051493          	slli	s1,a0,0x20
 92a:	9081                	srli	s1,s1,0x20
 92c:	04bd                	addi	s1,s1,15
 92e:	8091                	srli	s1,s1,0x4
 930:	0014899b          	addiw	s3,s1,1
 934:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 936:	00000517          	auipc	a0,0x0
 93a:	6ca53503          	ld	a0,1738(a0) # 1000 <freep>
 93e:	c515                	beqz	a0,96a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 940:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 942:	4798                	lw	a4,8(a5)
 944:	02977f63          	bgeu	a4,s1,982 <malloc+0x70>
 948:	8a4e                	mv	s4,s3
 94a:	0009871b          	sext.w	a4,s3
 94e:	6685                	lui	a3,0x1
 950:	00d77363          	bgeu	a4,a3,956 <malloc+0x44>
 954:	6a05                	lui	s4,0x1
 956:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95e:	00000917          	auipc	s2,0x0
 962:	6a290913          	addi	s2,s2,1698 # 1000 <freep>
  if(p == (char*)-1)
 966:	5afd                	li	s5,-1
 968:	a895                	j	9dc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 96a:	00000797          	auipc	a5,0x0
 96e:	6a678793          	addi	a5,a5,1702 # 1010 <base>
 972:	00000717          	auipc	a4,0x0
 976:	68f73723          	sd	a5,1678(a4) # 1000 <freep>
 97a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 97c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 980:	b7e1                	j	948 <malloc+0x36>
      if(p->s.size == nunits)
 982:	02e48c63          	beq	s1,a4,9ba <malloc+0xa8>
        p->s.size -= nunits;
 986:	4137073b          	subw	a4,a4,s3
 98a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 98c:	02071693          	slli	a3,a4,0x20
 990:	01c6d713          	srli	a4,a3,0x1c
 994:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 996:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 99a:	00000717          	auipc	a4,0x0
 99e:	66a73323          	sd	a0,1638(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9a6:	70e2                	ld	ra,56(sp)
 9a8:	7442                	ld	s0,48(sp)
 9aa:	74a2                	ld	s1,40(sp)
 9ac:	7902                	ld	s2,32(sp)
 9ae:	69e2                	ld	s3,24(sp)
 9b0:	6a42                	ld	s4,16(sp)
 9b2:	6aa2                	ld	s5,8(sp)
 9b4:	6b02                	ld	s6,0(sp)
 9b6:	6121                	addi	sp,sp,64
 9b8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9ba:	6398                	ld	a4,0(a5)
 9bc:	e118                	sd	a4,0(a0)
 9be:	bff1                	j	99a <malloc+0x88>
  hp->s.size = nu;
 9c0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c4:	0541                	addi	a0,a0,16
 9c6:	00000097          	auipc	ra,0x0
 9ca:	eca080e7          	jalr	-310(ra) # 890 <free>
  return freep;
 9ce:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9d2:	d971                	beqz	a0,9a6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d6:	4798                	lw	a4,8(a5)
 9d8:	fa9775e3          	bgeu	a4,s1,982 <malloc+0x70>
    if(p == freep)
 9dc:	00093703          	ld	a4,0(s2)
 9e0:	853e                	mv	a0,a5
 9e2:	fef719e3          	bne	a4,a5,9d4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9e6:	8552                	mv	a0,s4
 9e8:	00000097          	auipc	ra,0x0
 9ec:	b80080e7          	jalr	-1152(ra) # 568 <sbrk>
  if(p == (char*)-1)
 9f0:	fd5518e3          	bne	a0,s5,9c0 <malloc+0xae>
        return 0;
 9f4:	4501                	li	a0,0
 9f6:	bf45                	j	9a6 <malloc+0x94>
