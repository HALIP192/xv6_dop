
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	c1e080e7          	jalr	-994(ra) # 5c2e <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	c0c080e7          	jalr	-1012(ra) # 5c2e <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	0d250513          	addi	a0,a0,210 # 6110 <malloc+0xf0>
      46:	00006097          	auipc	ra,0x6
      4a:	f22080e7          	jalr	-222(ra) # 5f68 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	b9e080e7          	jalr	-1122(ra) # 5bee <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	0b050513          	addi	a0,a0,176 # 6130 <malloc+0x110>
      88:	00006097          	auipc	ra,0x6
      8c:	ee0080e7          	jalr	-288(ra) # 5f68 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	b5c080e7          	jalr	-1188(ra) # 5bee <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	0a050513          	addi	a0,a0,160 # 6148 <malloc+0x128>
      b0:	00006097          	auipc	ra,0x6
      b4:	b7e080e7          	jalr	-1154(ra) # 5c2e <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	b5a080e7          	jalr	-1190(ra) # 5c16 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	0a250513          	addi	a0,a0,162 # 6168 <malloc+0x148>
      ce:	00006097          	auipc	ra,0x6
      d2:	b60080e7          	jalr	-1184(ra) # 5c2e <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	06a50513          	addi	a0,a0,106 # 6150 <malloc+0x130>
      ee:	00006097          	auipc	ra,0x6
      f2:	e7a080e7          	jalr	-390(ra) # 5f68 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	af6080e7          	jalr	-1290(ra) # 5bee <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	07650513          	addi	a0,a0,118 # 6178 <malloc+0x158>
     10a:	00006097          	auipc	ra,0x6
     10e:	e5e080e7          	jalr	-418(ra) # 5f68 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	ada080e7          	jalr	-1318(ra) # 5bee <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	07450513          	addi	a0,a0,116 # 61a0 <malloc+0x180>
     134:	00006097          	auipc	ra,0x6
     138:	b0a080e7          	jalr	-1270(ra) # 5c3e <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	06050513          	addi	a0,a0,96 # 61a0 <malloc+0x180>
     148:	00006097          	auipc	ra,0x6
     14c:	ae6080e7          	jalr	-1306(ra) # 5c2e <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	05c58593          	addi	a1,a1,92 # 61b0 <malloc+0x190>
     15c:	00006097          	auipc	ra,0x6
     160:	ab2080e7          	jalr	-1358(ra) # 5c0e <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	03850513          	addi	a0,a0,56 # 61a0 <malloc+0x180>
     170:	00006097          	auipc	ra,0x6
     174:	abe080e7          	jalr	-1346(ra) # 5c2e <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	03c58593          	addi	a1,a1,60 # 61b8 <malloc+0x198>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	a88080e7          	jalr	-1400(ra) # 5c0e <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	00c50513          	addi	a0,a0,12 # 61a0 <malloc+0x180>
     19c:	00006097          	auipc	ra,0x6
     1a0:	aa2080e7          	jalr	-1374(ra) # 5c3e <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	a70080e7          	jalr	-1424(ra) # 5c16 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a66080e7          	jalr	-1434(ra) # 5c16 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	ff650513          	addi	a0,a0,-10 # 61c0 <malloc+0x1a0>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	d96080e7          	jalr	-618(ra) # 5f68 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	a12080e7          	jalr	-1518(ra) # 5bee <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	a1e080e7          	jalr	-1506(ra) # 5c2e <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	9fe080e7          	jalr	-1538(ra) # 5c16 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	9f8080e7          	jalr	-1544(ra) # 5c3e <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	f6c50513          	addi	a0,a0,-148 # 61e8 <malloc+0x1c8>
     284:	00006097          	auipc	ra,0x6
     288:	9ba080e7          	jalr	-1606(ra) # 5c3e <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	f58a8a93          	addi	s5,s5,-168 # 61e8 <malloc+0x1c8>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <fourteen+0x1a3>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	982080e7          	jalr	-1662(ra) # 5c2e <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	950080e7          	jalr	-1712(ra) # 5c0e <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	93c080e7          	jalr	-1732(ra) # 5c0e <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	936080e7          	jalr	-1738(ra) # 5c16 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	954080e7          	jalr	-1708(ra) # 5c3e <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	ee650513          	addi	a0,a0,-282 # 61f8 <malloc+0x1d8>
     31a:	00006097          	auipc	ra,0x6
     31e:	c4e080e7          	jalr	-946(ra) # 5f68 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	8ca080e7          	jalr	-1846(ra) # 5bee <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	ee450513          	addi	a0,a0,-284 # 6218 <malloc+0x1f8>
     33c:	00006097          	auipc	ra,0x6
     340:	c2c080e7          	jalr	-980(ra) # 5f68 <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00006097          	auipc	ra,0x6
     34a:	8a8080e7          	jalr	-1880(ra) # 5bee <exit>

000000000000034e <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     34e:	7179                	addi	sp,sp,-48
     350:	f406                	sd	ra,40(sp)
     352:	f022                	sd	s0,32(sp)
     354:	ec26                	sd	s1,24(sp)
     356:	e84a                	sd	s2,16(sp)
     358:	e44e                	sd	s3,8(sp)
     35a:	e052                	sd	s4,0(sp)
     35c:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     35e:	00006517          	auipc	a0,0x6
     362:	ed250513          	addi	a0,a0,-302 # 6230 <malloc+0x210>
     366:	00006097          	auipc	ra,0x6
     36a:	8d8080e7          	jalr	-1832(ra) # 5c3e <unlink>
     36e:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     372:	00006997          	auipc	s3,0x6
     376:	ebe98993          	addi	s3,s3,-322 # 6230 <malloc+0x210>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37a:	5a7d                	li	s4,-1
     37c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     380:	20100593          	li	a1,513
     384:	854e                	mv	a0,s3
     386:	00006097          	auipc	ra,0x6
     38a:	8a8080e7          	jalr	-1880(ra) # 5c2e <open>
     38e:	84aa                	mv	s1,a0
    if(fd < 0){
     390:	06054b63          	bltz	a0,406 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     394:	4605                	li	a2,1
     396:	85d2                	mv	a1,s4
     398:	00006097          	auipc	ra,0x6
     39c:	876080e7          	jalr	-1930(ra) # 5c0e <write>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00006097          	auipc	ra,0x6
     3a6:	874080e7          	jalr	-1932(ra) # 5c16 <close>
    unlink("junk");
     3aa:	854e                	mv	a0,s3
     3ac:	00006097          	auipc	ra,0x6
     3b0:	892080e7          	jalr	-1902(ra) # 5c3e <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b4:	397d                	addiw	s2,s2,-1
     3b6:	fc0915e3          	bnez	s2,380 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3ba:	20100593          	li	a1,513
     3be:	00006517          	auipc	a0,0x6
     3c2:	e7250513          	addi	a0,a0,-398 # 6230 <malloc+0x210>
     3c6:	00006097          	auipc	ra,0x6
     3ca:	868080e7          	jalr	-1944(ra) # 5c2e <open>
     3ce:	84aa                	mv	s1,a0
  if(fd < 0){
     3d0:	04054863          	bltz	a0,420 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d4:	4605                	li	a2,1
     3d6:	00006597          	auipc	a1,0x6
     3da:	de258593          	addi	a1,a1,-542 # 61b8 <malloc+0x198>
     3de:	00006097          	auipc	ra,0x6
     3e2:	830080e7          	jalr	-2000(ra) # 5c0e <write>
     3e6:	4785                	li	a5,1
     3e8:	04f50963          	beq	a0,a5,43a <badwrite+0xec>
    printf("write failed\n");
     3ec:	00006517          	auipc	a0,0x6
     3f0:	e6450513          	addi	a0,a0,-412 # 6250 <malloc+0x230>
     3f4:	00006097          	auipc	ra,0x6
     3f8:	b74080e7          	jalr	-1164(ra) # 5f68 <printf>
    exit(1);
     3fc:	4505                	li	a0,1
     3fe:	00005097          	auipc	ra,0x5
     402:	7f0080e7          	jalr	2032(ra) # 5bee <exit>
      printf("open junk failed\n");
     406:	00006517          	auipc	a0,0x6
     40a:	e3250513          	addi	a0,a0,-462 # 6238 <malloc+0x218>
     40e:	00006097          	auipc	ra,0x6
     412:	b5a080e7          	jalr	-1190(ra) # 5f68 <printf>
      exit(1);
     416:	4505                	li	a0,1
     418:	00005097          	auipc	ra,0x5
     41c:	7d6080e7          	jalr	2006(ra) # 5bee <exit>
    printf("open junk failed\n");
     420:	00006517          	auipc	a0,0x6
     424:	e1850513          	addi	a0,a0,-488 # 6238 <malloc+0x218>
     428:	00006097          	auipc	ra,0x6
     42c:	b40080e7          	jalr	-1216(ra) # 5f68 <printf>
    exit(1);
     430:	4505                	li	a0,1
     432:	00005097          	auipc	ra,0x5
     436:	7bc080e7          	jalr	1980(ra) # 5bee <exit>
  }
  close(fd);
     43a:	8526                	mv	a0,s1
     43c:	00005097          	auipc	ra,0x5
     440:	7da080e7          	jalr	2010(ra) # 5c16 <close>
  unlink("junk");
     444:	00006517          	auipc	a0,0x6
     448:	dec50513          	addi	a0,a0,-532 # 6230 <malloc+0x210>
     44c:	00005097          	auipc	ra,0x5
     450:	7f2080e7          	jalr	2034(ra) # 5c3e <unlink>

  exit(0);
     454:	4501                	li	a0,0
     456:	00005097          	auipc	ra,0x5
     45a:	798080e7          	jalr	1944(ra) # 5bee <exit>

000000000000045e <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     45e:	715d                	addi	sp,sp,-80
     460:	e486                	sd	ra,72(sp)
     462:	e0a2                	sd	s0,64(sp)
     464:	fc26                	sd	s1,56(sp)
     466:	f84a                	sd	s2,48(sp)
     468:	f44e                	sd	s3,40(sp)
     46a:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46c:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     46e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     472:	40000993          	li	s3,1024
    name[0] = 'z';
     476:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47a:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     47e:	41f4d71b          	sraiw	a4,s1,0x1f
     482:	01b7571b          	srliw	a4,a4,0x1b
     486:	009707bb          	addw	a5,a4,s1
     48a:	4057d69b          	sraiw	a3,a5,0x5
     48e:	0306869b          	addiw	a3,a3,48
     492:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     496:	8bfd                	andi	a5,a5,31
     498:	9f99                	subw	a5,a5,a4
     49a:	0307879b          	addiw	a5,a5,48
     49e:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a2:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a6:	fb040513          	addi	a0,s0,-80
     4aa:	00005097          	auipc	ra,0x5
     4ae:	794080e7          	jalr	1940(ra) # 5c3e <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b2:	60200593          	li	a1,1538
     4b6:	fb040513          	addi	a0,s0,-80
     4ba:	00005097          	auipc	ra,0x5
     4be:	774080e7          	jalr	1908(ra) # 5c2e <open>
    if(fd < 0){
     4c2:	00054963          	bltz	a0,4d4 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c6:	00005097          	auipc	ra,0x5
     4ca:	750080e7          	jalr	1872(ra) # 5c16 <close>
  for(int i = 0; i < nzz; i++){
     4ce:	2485                	addiw	s1,s1,1
     4d0:	fb3493e3          	bne	s1,s3,476 <outofinodes+0x18>
     4d4:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d6:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4da:	40000993          	li	s3,1024
    name[0] = 'z';
     4de:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e2:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e6:	41f4d71b          	sraiw	a4,s1,0x1f
     4ea:	01b7571b          	srliw	a4,a4,0x1b
     4ee:	009707bb          	addw	a5,a4,s1
     4f2:	4057d69b          	sraiw	a3,a5,0x5
     4f6:	0306869b          	addiw	a3,a3,48
     4fa:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4fe:	8bfd                	andi	a5,a5,31
     500:	9f99                	subw	a5,a5,a4
     502:	0307879b          	addiw	a5,a5,48
     506:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50a:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     50e:	fb040513          	addi	a0,s0,-80
     512:	00005097          	auipc	ra,0x5
     516:	72c080e7          	jalr	1836(ra) # 5c3e <unlink>
  for(int i = 0; i < nzz; i++){
     51a:	2485                	addiw	s1,s1,1
     51c:	fd3491e3          	bne	s1,s3,4de <outofinodes+0x80>
  }
}
     520:	60a6                	ld	ra,72(sp)
     522:	6406                	ld	s0,64(sp)
     524:	74e2                	ld	s1,56(sp)
     526:	7942                	ld	s2,48(sp)
     528:	79a2                	ld	s3,40(sp)
     52a:	6161                	addi	sp,sp,80
     52c:	8082                	ret

000000000000052e <copyin>:
{
     52e:	715d                	addi	sp,sp,-80
     530:	e486                	sd	ra,72(sp)
     532:	e0a2                	sd	s0,64(sp)
     534:	fc26                	sd	s1,56(sp)
     536:	f84a                	sd	s2,48(sp)
     538:	f44e                	sd	s3,40(sp)
     53a:	f052                	sd	s4,32(sp)
     53c:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     53e:	4785                	li	a5,1
     540:	07fe                	slli	a5,a5,0x1f
     542:	fcf43023          	sd	a5,-64(s0)
     546:	57fd                	li	a5,-1
     548:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54c:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     550:	00006a17          	auipc	s4,0x6
     554:	d10a0a13          	addi	s4,s4,-752 # 6260 <malloc+0x240>
    uint64 addr = addrs[ai];
     558:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55c:	20100593          	li	a1,513
     560:	8552                	mv	a0,s4
     562:	00005097          	auipc	ra,0x5
     566:	6cc080e7          	jalr	1740(ra) # 5c2e <open>
     56a:	84aa                	mv	s1,a0
    if(fd < 0){
     56c:	08054863          	bltz	a0,5fc <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     570:	6609                	lui	a2,0x2
     572:	85ce                	mv	a1,s3
     574:	00005097          	auipc	ra,0x5
     578:	69a080e7          	jalr	1690(ra) # 5c0e <write>
    if(n >= 0){
     57c:	08055d63          	bgez	a0,616 <copyin+0xe8>
    close(fd);
     580:	8526                	mv	a0,s1
     582:	00005097          	auipc	ra,0x5
     586:	694080e7          	jalr	1684(ra) # 5c16 <close>
    unlink("copyin1");
     58a:	8552                	mv	a0,s4
     58c:	00005097          	auipc	ra,0x5
     590:	6b2080e7          	jalr	1714(ra) # 5c3e <unlink>
    n = write(1, (char*)addr, 8192);
     594:	6609                	lui	a2,0x2
     596:	85ce                	mv	a1,s3
     598:	4505                	li	a0,1
     59a:	00005097          	auipc	ra,0x5
     59e:	674080e7          	jalr	1652(ra) # 5c0e <write>
    if(n > 0){
     5a2:	08a04963          	bgtz	a0,634 <copyin+0x106>
    if(pipe(fds) < 0){
     5a6:	fb840513          	addi	a0,s0,-72
     5aa:	00005097          	auipc	ra,0x5
     5ae:	654080e7          	jalr	1620(ra) # 5bfe <pipe>
     5b2:	0a054063          	bltz	a0,652 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b6:	6609                	lui	a2,0x2
     5b8:	85ce                	mv	a1,s3
     5ba:	fbc42503          	lw	a0,-68(s0)
     5be:	00005097          	auipc	ra,0x5
     5c2:	650080e7          	jalr	1616(ra) # 5c0e <write>
    if(n > 0){
     5c6:	0aa04363          	bgtz	a0,66c <copyin+0x13e>
    close(fds[0]);
     5ca:	fb842503          	lw	a0,-72(s0)
     5ce:	00005097          	auipc	ra,0x5
     5d2:	648080e7          	jalr	1608(ra) # 5c16 <close>
    close(fds[1]);
     5d6:	fbc42503          	lw	a0,-68(s0)
     5da:	00005097          	auipc	ra,0x5
     5de:	63c080e7          	jalr	1596(ra) # 5c16 <close>
  for(int ai = 0; ai < 2; ai++){
     5e2:	0921                	addi	s2,s2,8
     5e4:	fd040793          	addi	a5,s0,-48
     5e8:	f6f918e3          	bne	s2,a5,558 <copyin+0x2a>
}
     5ec:	60a6                	ld	ra,72(sp)
     5ee:	6406                	ld	s0,64(sp)
     5f0:	74e2                	ld	s1,56(sp)
     5f2:	7942                	ld	s2,48(sp)
     5f4:	79a2                	ld	s3,40(sp)
     5f6:	7a02                	ld	s4,32(sp)
     5f8:	6161                	addi	sp,sp,80
     5fa:	8082                	ret
      printf("open(copyin1) failed\n");
     5fc:	00006517          	auipc	a0,0x6
     600:	c6c50513          	addi	a0,a0,-916 # 6268 <malloc+0x248>
     604:	00006097          	auipc	ra,0x6
     608:	964080e7          	jalr	-1692(ra) # 5f68 <printf>
      exit(1);
     60c:	4505                	li	a0,1
     60e:	00005097          	auipc	ra,0x5
     612:	5e0080e7          	jalr	1504(ra) # 5bee <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     616:	862a                	mv	a2,a0
     618:	85ce                	mv	a1,s3
     61a:	00006517          	auipc	a0,0x6
     61e:	c6650513          	addi	a0,a0,-922 # 6280 <malloc+0x260>
     622:	00006097          	auipc	ra,0x6
     626:	946080e7          	jalr	-1722(ra) # 5f68 <printf>
      exit(1);
     62a:	4505                	li	a0,1
     62c:	00005097          	auipc	ra,0x5
     630:	5c2080e7          	jalr	1474(ra) # 5bee <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     634:	862a                	mv	a2,a0
     636:	85ce                	mv	a1,s3
     638:	00006517          	auipc	a0,0x6
     63c:	c7850513          	addi	a0,a0,-904 # 62b0 <malloc+0x290>
     640:	00006097          	auipc	ra,0x6
     644:	928080e7          	jalr	-1752(ra) # 5f68 <printf>
      exit(1);
     648:	4505                	li	a0,1
     64a:	00005097          	auipc	ra,0x5
     64e:	5a4080e7          	jalr	1444(ra) # 5bee <exit>
      printf("pipe() failed\n");
     652:	00006517          	auipc	a0,0x6
     656:	c8e50513          	addi	a0,a0,-882 # 62e0 <malloc+0x2c0>
     65a:	00006097          	auipc	ra,0x6
     65e:	90e080e7          	jalr	-1778(ra) # 5f68 <printf>
      exit(1);
     662:	4505                	li	a0,1
     664:	00005097          	auipc	ra,0x5
     668:	58a080e7          	jalr	1418(ra) # 5bee <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66c:	862a                	mv	a2,a0
     66e:	85ce                	mv	a1,s3
     670:	00006517          	auipc	a0,0x6
     674:	c8050513          	addi	a0,a0,-896 # 62f0 <malloc+0x2d0>
     678:	00006097          	auipc	ra,0x6
     67c:	8f0080e7          	jalr	-1808(ra) # 5f68 <printf>
      exit(1);
     680:	4505                	li	a0,1
     682:	00005097          	auipc	ra,0x5
     686:	56c080e7          	jalr	1388(ra) # 5bee <exit>

000000000000068a <copyout>:
{
     68a:	711d                	addi	sp,sp,-96
     68c:	ec86                	sd	ra,88(sp)
     68e:	e8a2                	sd	s0,80(sp)
     690:	e4a6                	sd	s1,72(sp)
     692:	e0ca                	sd	s2,64(sp)
     694:	fc4e                	sd	s3,56(sp)
     696:	f852                	sd	s4,48(sp)
     698:	f456                	sd	s5,40(sp)
     69a:	f05a                	sd	s6,32(sp)
     69c:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0LL, 0x80000000LL, 0xffffffffffffffff };
     69e:	fa043423          	sd	zero,-88(s0)
     6a2:	4785                	li	a5,1
     6a4:	07fe                	slli	a5,a5,0x1f
     6a6:	faf43823          	sd	a5,-80(s0)
     6aa:	57fd                	li	a5,-1
     6ac:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6b0:	fa840913          	addi	s2,s0,-88
     6b4:	fb840b13          	addi	s6,s0,-72
    int fd = open("README", 0);
     6b8:	00006a17          	auipc	s4,0x6
     6bc:	c68a0a13          	addi	s4,s4,-920 # 6320 <malloc+0x300>
    n = write(fds[1], "x", 1);
     6c0:	00006a97          	auipc	s5,0x6
     6c4:	af8a8a93          	addi	s5,s5,-1288 # 61b8 <malloc+0x198>
    uint64 addr = addrs[ai];
     6c8:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6cc:	4581                	li	a1,0
     6ce:	8552                	mv	a0,s4
     6d0:	00005097          	auipc	ra,0x5
     6d4:	55e080e7          	jalr	1374(ra) # 5c2e <open>
     6d8:	84aa                	mv	s1,a0
    if(fd < 0){
     6da:	08054563          	bltz	a0,764 <copyout+0xda>
    int n = read(fd, (void*)addr, 8192);
     6de:	6609                	lui	a2,0x2
     6e0:	85ce                	mv	a1,s3
     6e2:	00005097          	auipc	ra,0x5
     6e6:	524080e7          	jalr	1316(ra) # 5c06 <read>
    if(n > 0){
     6ea:	08a04a63          	bgtz	a0,77e <copyout+0xf4>
    close(fd);
     6ee:	8526                	mv	a0,s1
     6f0:	00005097          	auipc	ra,0x5
     6f4:	526080e7          	jalr	1318(ra) # 5c16 <close>
    if(pipe(fds) < 0){
     6f8:	fa040513          	addi	a0,s0,-96
     6fc:	00005097          	auipc	ra,0x5
     700:	502080e7          	jalr	1282(ra) # 5bfe <pipe>
     704:	08054c63          	bltz	a0,79c <copyout+0x112>
    n = write(fds[1], "x", 1);
     708:	4605                	li	a2,1
     70a:	85d6                	mv	a1,s5
     70c:	fa442503          	lw	a0,-92(s0)
     710:	00005097          	auipc	ra,0x5
     714:	4fe080e7          	jalr	1278(ra) # 5c0e <write>
    if(n != 1){
     718:	4785                	li	a5,1
     71a:	08f51e63          	bne	a0,a5,7b6 <copyout+0x12c>
    n = read(fds[0], (void*)addr, 8192);
     71e:	6609                	lui	a2,0x2
     720:	85ce                	mv	a1,s3
     722:	fa042503          	lw	a0,-96(s0)
     726:	00005097          	auipc	ra,0x5
     72a:	4e0080e7          	jalr	1248(ra) # 5c06 <read>
    if(n > 0){
     72e:	0aa04163          	bgtz	a0,7d0 <copyout+0x146>
    close(fds[0]);
     732:	fa042503          	lw	a0,-96(s0)
     736:	00005097          	auipc	ra,0x5
     73a:	4e0080e7          	jalr	1248(ra) # 5c16 <close>
    close(fds[1]);
     73e:	fa442503          	lw	a0,-92(s0)
     742:	00005097          	auipc	ra,0x5
     746:	4d4080e7          	jalr	1236(ra) # 5c16 <close>
  for(int ai = 0; ai < 2; ai++){
     74a:	0921                	addi	s2,s2,8
     74c:	f7691ee3          	bne	s2,s6,6c8 <copyout+0x3e>
}
     750:	60e6                	ld	ra,88(sp)
     752:	6446                	ld	s0,80(sp)
     754:	64a6                	ld	s1,72(sp)
     756:	6906                	ld	s2,64(sp)
     758:	79e2                	ld	s3,56(sp)
     75a:	7a42                	ld	s4,48(sp)
     75c:	7aa2                	ld	s5,40(sp)
     75e:	7b02                	ld	s6,32(sp)
     760:	6125                	addi	sp,sp,96
     762:	8082                	ret
      printf("open(README) failed\n");
     764:	00006517          	auipc	a0,0x6
     768:	bc450513          	addi	a0,a0,-1084 # 6328 <malloc+0x308>
     76c:	00005097          	auipc	ra,0x5
     770:	7fc080e7          	jalr	2044(ra) # 5f68 <printf>
      exit(1);
     774:	4505                	li	a0,1
     776:	00005097          	auipc	ra,0x5
     77a:	478080e7          	jalr	1144(ra) # 5bee <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     77e:	862a                	mv	a2,a0
     780:	85ce                	mv	a1,s3
     782:	00006517          	auipc	a0,0x6
     786:	bbe50513          	addi	a0,a0,-1090 # 6340 <malloc+0x320>
     78a:	00005097          	auipc	ra,0x5
     78e:	7de080e7          	jalr	2014(ra) # 5f68 <printf>
      exit(1);
     792:	4505                	li	a0,1
     794:	00005097          	auipc	ra,0x5
     798:	45a080e7          	jalr	1114(ra) # 5bee <exit>
      printf("pipe() failed\n");
     79c:	00006517          	auipc	a0,0x6
     7a0:	b4450513          	addi	a0,a0,-1212 # 62e0 <malloc+0x2c0>
     7a4:	00005097          	auipc	ra,0x5
     7a8:	7c4080e7          	jalr	1988(ra) # 5f68 <printf>
      exit(1);
     7ac:	4505                	li	a0,1
     7ae:	00005097          	auipc	ra,0x5
     7b2:	440080e7          	jalr	1088(ra) # 5bee <exit>
      printf("pipe write failed\n");
     7b6:	00006517          	auipc	a0,0x6
     7ba:	bba50513          	addi	a0,a0,-1094 # 6370 <malloc+0x350>
     7be:	00005097          	auipc	ra,0x5
     7c2:	7aa080e7          	jalr	1962(ra) # 5f68 <printf>
      exit(1);
     7c6:	4505                	li	a0,1
     7c8:	00005097          	auipc	ra,0x5
     7cc:	426080e7          	jalr	1062(ra) # 5bee <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7d0:	862a                	mv	a2,a0
     7d2:	85ce                	mv	a1,s3
     7d4:	00006517          	auipc	a0,0x6
     7d8:	bb450513          	addi	a0,a0,-1100 # 6388 <malloc+0x368>
     7dc:	00005097          	auipc	ra,0x5
     7e0:	78c080e7          	jalr	1932(ra) # 5f68 <printf>
      exit(1);
     7e4:	4505                	li	a0,1
     7e6:	00005097          	auipc	ra,0x5
     7ea:	408080e7          	jalr	1032(ra) # 5bee <exit>

00000000000007ee <truncate1>:
{
     7ee:	711d                	addi	sp,sp,-96
     7f0:	ec86                	sd	ra,88(sp)
     7f2:	e8a2                	sd	s0,80(sp)
     7f4:	e4a6                	sd	s1,72(sp)
     7f6:	e0ca                	sd	s2,64(sp)
     7f8:	fc4e                	sd	s3,56(sp)
     7fa:	f852                	sd	s4,48(sp)
     7fc:	f456                	sd	s5,40(sp)
     7fe:	1080                	addi	s0,sp,96
     800:	8aaa                	mv	s5,a0
  unlink("truncfile");
     802:	00006517          	auipc	a0,0x6
     806:	99e50513          	addi	a0,a0,-1634 # 61a0 <malloc+0x180>
     80a:	00005097          	auipc	ra,0x5
     80e:	434080e7          	jalr	1076(ra) # 5c3e <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     812:	60100593          	li	a1,1537
     816:	00006517          	auipc	a0,0x6
     81a:	98a50513          	addi	a0,a0,-1654 # 61a0 <malloc+0x180>
     81e:	00005097          	auipc	ra,0x5
     822:	410080e7          	jalr	1040(ra) # 5c2e <open>
     826:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     828:	4611                	li	a2,4
     82a:	00006597          	auipc	a1,0x6
     82e:	98658593          	addi	a1,a1,-1658 # 61b0 <malloc+0x190>
     832:	00005097          	auipc	ra,0x5
     836:	3dc080e7          	jalr	988(ra) # 5c0e <write>
  close(fd1);
     83a:	8526                	mv	a0,s1
     83c:	00005097          	auipc	ra,0x5
     840:	3da080e7          	jalr	986(ra) # 5c16 <close>
  int fd2 = open("truncfile", O_RDONLY);
     844:	4581                	li	a1,0
     846:	00006517          	auipc	a0,0x6
     84a:	95a50513          	addi	a0,a0,-1702 # 61a0 <malloc+0x180>
     84e:	00005097          	auipc	ra,0x5
     852:	3e0080e7          	jalr	992(ra) # 5c2e <open>
     856:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     858:	02000613          	li	a2,32
     85c:	fa040593          	addi	a1,s0,-96
     860:	00005097          	auipc	ra,0x5
     864:	3a6080e7          	jalr	934(ra) # 5c06 <read>
  if(n != 4){
     868:	4791                	li	a5,4
     86a:	0cf51e63          	bne	a0,a5,946 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     86e:	40100593          	li	a1,1025
     872:	00006517          	auipc	a0,0x6
     876:	92e50513          	addi	a0,a0,-1746 # 61a0 <malloc+0x180>
     87a:	00005097          	auipc	ra,0x5
     87e:	3b4080e7          	jalr	948(ra) # 5c2e <open>
     882:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     884:	4581                	li	a1,0
     886:	00006517          	auipc	a0,0x6
     88a:	91a50513          	addi	a0,a0,-1766 # 61a0 <malloc+0x180>
     88e:	00005097          	auipc	ra,0x5
     892:	3a0080e7          	jalr	928(ra) # 5c2e <open>
     896:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     898:	02000613          	li	a2,32
     89c:	fa040593          	addi	a1,s0,-96
     8a0:	00005097          	auipc	ra,0x5
     8a4:	366080e7          	jalr	870(ra) # 5c06 <read>
     8a8:	8a2a                	mv	s4,a0
  if(n != 0){
     8aa:	ed4d                	bnez	a0,964 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8ac:	02000613          	li	a2,32
     8b0:	fa040593          	addi	a1,s0,-96
     8b4:	8526                	mv	a0,s1
     8b6:	00005097          	auipc	ra,0x5
     8ba:	350080e7          	jalr	848(ra) # 5c06 <read>
     8be:	8a2a                	mv	s4,a0
  if(n != 0){
     8c0:	e971                	bnez	a0,994 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8c2:	4619                	li	a2,6
     8c4:	00006597          	auipc	a1,0x6
     8c8:	b5458593          	addi	a1,a1,-1196 # 6418 <malloc+0x3f8>
     8cc:	854e                	mv	a0,s3
     8ce:	00005097          	auipc	ra,0x5
     8d2:	340080e7          	jalr	832(ra) # 5c0e <write>
  n = read(fd3, buf, sizeof(buf));
     8d6:	02000613          	li	a2,32
     8da:	fa040593          	addi	a1,s0,-96
     8de:	854a                	mv	a0,s2
     8e0:	00005097          	auipc	ra,0x5
     8e4:	326080e7          	jalr	806(ra) # 5c06 <read>
  if(n != 6){
     8e8:	4799                	li	a5,6
     8ea:	0cf51d63          	bne	a0,a5,9c4 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8ee:	02000613          	li	a2,32
     8f2:	fa040593          	addi	a1,s0,-96
     8f6:	8526                	mv	a0,s1
     8f8:	00005097          	auipc	ra,0x5
     8fc:	30e080e7          	jalr	782(ra) # 5c06 <read>
  if(n != 2){
     900:	4789                	li	a5,2
     902:	0ef51063          	bne	a0,a5,9e2 <truncate1+0x1f4>
  unlink("truncfile");
     906:	00006517          	auipc	a0,0x6
     90a:	89a50513          	addi	a0,a0,-1894 # 61a0 <malloc+0x180>
     90e:	00005097          	auipc	ra,0x5
     912:	330080e7          	jalr	816(ra) # 5c3e <unlink>
  close(fd1);
     916:	854e                	mv	a0,s3
     918:	00005097          	auipc	ra,0x5
     91c:	2fe080e7          	jalr	766(ra) # 5c16 <close>
  close(fd2);
     920:	8526                	mv	a0,s1
     922:	00005097          	auipc	ra,0x5
     926:	2f4080e7          	jalr	756(ra) # 5c16 <close>
  close(fd3);
     92a:	854a                	mv	a0,s2
     92c:	00005097          	auipc	ra,0x5
     930:	2ea080e7          	jalr	746(ra) # 5c16 <close>
}
     934:	60e6                	ld	ra,88(sp)
     936:	6446                	ld	s0,80(sp)
     938:	64a6                	ld	s1,72(sp)
     93a:	6906                	ld	s2,64(sp)
     93c:	79e2                	ld	s3,56(sp)
     93e:	7a42                	ld	s4,48(sp)
     940:	7aa2                	ld	s5,40(sp)
     942:	6125                	addi	sp,sp,96
     944:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     946:	862a                	mv	a2,a0
     948:	85d6                	mv	a1,s5
     94a:	00006517          	auipc	a0,0x6
     94e:	a6e50513          	addi	a0,a0,-1426 # 63b8 <malloc+0x398>
     952:	00005097          	auipc	ra,0x5
     956:	616080e7          	jalr	1558(ra) # 5f68 <printf>
    exit(1);
     95a:	4505                	li	a0,1
     95c:	00005097          	auipc	ra,0x5
     960:	292080e7          	jalr	658(ra) # 5bee <exit>
    printf("aaa fd3=%d\n", fd3);
     964:	85ca                	mv	a1,s2
     966:	00006517          	auipc	a0,0x6
     96a:	a7250513          	addi	a0,a0,-1422 # 63d8 <malloc+0x3b8>
     96e:	00005097          	auipc	ra,0x5
     972:	5fa080e7          	jalr	1530(ra) # 5f68 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     976:	8652                	mv	a2,s4
     978:	85d6                	mv	a1,s5
     97a:	00006517          	auipc	a0,0x6
     97e:	a6e50513          	addi	a0,a0,-1426 # 63e8 <malloc+0x3c8>
     982:	00005097          	auipc	ra,0x5
     986:	5e6080e7          	jalr	1510(ra) # 5f68 <printf>
    exit(1);
     98a:	4505                	li	a0,1
     98c:	00005097          	auipc	ra,0x5
     990:	262080e7          	jalr	610(ra) # 5bee <exit>
    printf("bbb fd2=%d\n", fd2);
     994:	85a6                	mv	a1,s1
     996:	00006517          	auipc	a0,0x6
     99a:	a7250513          	addi	a0,a0,-1422 # 6408 <malloc+0x3e8>
     99e:	00005097          	auipc	ra,0x5
     9a2:	5ca080e7          	jalr	1482(ra) # 5f68 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9a6:	8652                	mv	a2,s4
     9a8:	85d6                	mv	a1,s5
     9aa:	00006517          	auipc	a0,0x6
     9ae:	a3e50513          	addi	a0,a0,-1474 # 63e8 <malloc+0x3c8>
     9b2:	00005097          	auipc	ra,0x5
     9b6:	5b6080e7          	jalr	1462(ra) # 5f68 <printf>
    exit(1);
     9ba:	4505                	li	a0,1
     9bc:	00005097          	auipc	ra,0x5
     9c0:	232080e7          	jalr	562(ra) # 5bee <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9c4:	862a                	mv	a2,a0
     9c6:	85d6                	mv	a1,s5
     9c8:	00006517          	auipc	a0,0x6
     9cc:	a5850513          	addi	a0,a0,-1448 # 6420 <malloc+0x400>
     9d0:	00005097          	auipc	ra,0x5
     9d4:	598080e7          	jalr	1432(ra) # 5f68 <printf>
    exit(1);
     9d8:	4505                	li	a0,1
     9da:	00005097          	auipc	ra,0x5
     9de:	214080e7          	jalr	532(ra) # 5bee <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9e2:	862a                	mv	a2,a0
     9e4:	85d6                	mv	a1,s5
     9e6:	00006517          	auipc	a0,0x6
     9ea:	a5a50513          	addi	a0,a0,-1446 # 6440 <malloc+0x420>
     9ee:	00005097          	auipc	ra,0x5
     9f2:	57a080e7          	jalr	1402(ra) # 5f68 <printf>
    exit(1);
     9f6:	4505                	li	a0,1
     9f8:	00005097          	auipc	ra,0x5
     9fc:	1f6080e7          	jalr	502(ra) # 5bee <exit>

0000000000000a00 <writetest>:
{
     a00:	7139                	addi	sp,sp,-64
     a02:	fc06                	sd	ra,56(sp)
     a04:	f822                	sd	s0,48(sp)
     a06:	f426                	sd	s1,40(sp)
     a08:	f04a                	sd	s2,32(sp)
     a0a:	ec4e                	sd	s3,24(sp)
     a0c:	e852                	sd	s4,16(sp)
     a0e:	e456                	sd	s5,8(sp)
     a10:	e05a                	sd	s6,0(sp)
     a12:	0080                	addi	s0,sp,64
     a14:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a16:	20200593          	li	a1,514
     a1a:	00006517          	auipc	a0,0x6
     a1e:	a4650513          	addi	a0,a0,-1466 # 6460 <malloc+0x440>
     a22:	00005097          	auipc	ra,0x5
     a26:	20c080e7          	jalr	524(ra) # 5c2e <open>
  if(fd < 0){
     a2a:	0a054d63          	bltz	a0,ae4 <writetest+0xe4>
     a2e:	892a                	mv	s2,a0
     a30:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a32:	00006997          	auipc	s3,0x6
     a36:	a5698993          	addi	s3,s3,-1450 # 6488 <malloc+0x468>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a3a:	00006a97          	auipc	s5,0x6
     a3e:	a86a8a93          	addi	s5,s5,-1402 # 64c0 <malloc+0x4a0>
  for(i = 0; i < N; i++){
     a42:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a46:	4629                	li	a2,10
     a48:	85ce                	mv	a1,s3
     a4a:	854a                	mv	a0,s2
     a4c:	00005097          	auipc	ra,0x5
     a50:	1c2080e7          	jalr	450(ra) # 5c0e <write>
     a54:	47a9                	li	a5,10
     a56:	0af51563          	bne	a0,a5,b00 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a5a:	4629                	li	a2,10
     a5c:	85d6                	mv	a1,s5
     a5e:	854a                	mv	a0,s2
     a60:	00005097          	auipc	ra,0x5
     a64:	1ae080e7          	jalr	430(ra) # 5c0e <write>
     a68:	47a9                	li	a5,10
     a6a:	0af51a63          	bne	a0,a5,b1e <writetest+0x11e>
  for(i = 0; i < N; i++){
     a6e:	2485                	addiw	s1,s1,1
     a70:	fd449be3          	bne	s1,s4,a46 <writetest+0x46>
  close(fd);
     a74:	854a                	mv	a0,s2
     a76:	00005097          	auipc	ra,0x5
     a7a:	1a0080e7          	jalr	416(ra) # 5c16 <close>
  fd = open("small", O_RDONLY);
     a7e:	4581                	li	a1,0
     a80:	00006517          	auipc	a0,0x6
     a84:	9e050513          	addi	a0,a0,-1568 # 6460 <malloc+0x440>
     a88:	00005097          	auipc	ra,0x5
     a8c:	1a6080e7          	jalr	422(ra) # 5c2e <open>
     a90:	84aa                	mv	s1,a0
  if(fd < 0){
     a92:	0a054563          	bltz	a0,b3c <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a96:	7d000613          	li	a2,2000
     a9a:	0000c597          	auipc	a1,0xc
     a9e:	1de58593          	addi	a1,a1,478 # cc78 <buf>
     aa2:	00005097          	auipc	ra,0x5
     aa6:	164080e7          	jalr	356(ra) # 5c06 <read>
  if(i != N*SZ*2){
     aaa:	7d000793          	li	a5,2000
     aae:	0af51563          	bne	a0,a5,b58 <writetest+0x158>
  close(fd);
     ab2:	8526                	mv	a0,s1
     ab4:	00005097          	auipc	ra,0x5
     ab8:	162080e7          	jalr	354(ra) # 5c16 <close>
  if(unlink("small") < 0){
     abc:	00006517          	auipc	a0,0x6
     ac0:	9a450513          	addi	a0,a0,-1628 # 6460 <malloc+0x440>
     ac4:	00005097          	auipc	ra,0x5
     ac8:	17a080e7          	jalr	378(ra) # 5c3e <unlink>
     acc:	0a054463          	bltz	a0,b74 <writetest+0x174>
}
     ad0:	70e2                	ld	ra,56(sp)
     ad2:	7442                	ld	s0,48(sp)
     ad4:	74a2                	ld	s1,40(sp)
     ad6:	7902                	ld	s2,32(sp)
     ad8:	69e2                	ld	s3,24(sp)
     ada:	6a42                	ld	s4,16(sp)
     adc:	6aa2                	ld	s5,8(sp)
     ade:	6b02                	ld	s6,0(sp)
     ae0:	6121                	addi	sp,sp,64
     ae2:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     ae4:	85da                	mv	a1,s6
     ae6:	00006517          	auipc	a0,0x6
     aea:	98250513          	addi	a0,a0,-1662 # 6468 <malloc+0x448>
     aee:	00005097          	auipc	ra,0x5
     af2:	47a080e7          	jalr	1146(ra) # 5f68 <printf>
    exit(1);
     af6:	4505                	li	a0,1
     af8:	00005097          	auipc	ra,0x5
     afc:	0f6080e7          	jalr	246(ra) # 5bee <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     b00:	8626                	mv	a2,s1
     b02:	85da                	mv	a1,s6
     b04:	00006517          	auipc	a0,0x6
     b08:	99450513          	addi	a0,a0,-1644 # 6498 <malloc+0x478>
     b0c:	00005097          	auipc	ra,0x5
     b10:	45c080e7          	jalr	1116(ra) # 5f68 <printf>
      exit(1);
     b14:	4505                	li	a0,1
     b16:	00005097          	auipc	ra,0x5
     b1a:	0d8080e7          	jalr	216(ra) # 5bee <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b1e:	8626                	mv	a2,s1
     b20:	85da                	mv	a1,s6
     b22:	00006517          	auipc	a0,0x6
     b26:	9ae50513          	addi	a0,a0,-1618 # 64d0 <malloc+0x4b0>
     b2a:	00005097          	auipc	ra,0x5
     b2e:	43e080e7          	jalr	1086(ra) # 5f68 <printf>
      exit(1);
     b32:	4505                	li	a0,1
     b34:	00005097          	auipc	ra,0x5
     b38:	0ba080e7          	jalr	186(ra) # 5bee <exit>
    printf("%s: error: open small failed!\n", s);
     b3c:	85da                	mv	a1,s6
     b3e:	00006517          	auipc	a0,0x6
     b42:	9ba50513          	addi	a0,a0,-1606 # 64f8 <malloc+0x4d8>
     b46:	00005097          	auipc	ra,0x5
     b4a:	422080e7          	jalr	1058(ra) # 5f68 <printf>
    exit(1);
     b4e:	4505                	li	a0,1
     b50:	00005097          	auipc	ra,0x5
     b54:	09e080e7          	jalr	158(ra) # 5bee <exit>
    printf("%s: read failed\n", s);
     b58:	85da                	mv	a1,s6
     b5a:	00006517          	auipc	a0,0x6
     b5e:	9be50513          	addi	a0,a0,-1602 # 6518 <malloc+0x4f8>
     b62:	00005097          	auipc	ra,0x5
     b66:	406080e7          	jalr	1030(ra) # 5f68 <printf>
    exit(1);
     b6a:	4505                	li	a0,1
     b6c:	00005097          	auipc	ra,0x5
     b70:	082080e7          	jalr	130(ra) # 5bee <exit>
    printf("%s: unlink small failed\n", s);
     b74:	85da                	mv	a1,s6
     b76:	00006517          	auipc	a0,0x6
     b7a:	9ba50513          	addi	a0,a0,-1606 # 6530 <malloc+0x510>
     b7e:	00005097          	auipc	ra,0x5
     b82:	3ea080e7          	jalr	1002(ra) # 5f68 <printf>
    exit(1);
     b86:	4505                	li	a0,1
     b88:	00005097          	auipc	ra,0x5
     b8c:	066080e7          	jalr	102(ra) # 5bee <exit>

0000000000000b90 <writebig>:
{
     b90:	7139                	addi	sp,sp,-64
     b92:	fc06                	sd	ra,56(sp)
     b94:	f822                	sd	s0,48(sp)
     b96:	f426                	sd	s1,40(sp)
     b98:	f04a                	sd	s2,32(sp)
     b9a:	ec4e                	sd	s3,24(sp)
     b9c:	e852                	sd	s4,16(sp)
     b9e:	e456                	sd	s5,8(sp)
     ba0:	0080                	addi	s0,sp,64
     ba2:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     ba4:	20200593          	li	a1,514
     ba8:	00006517          	auipc	a0,0x6
     bac:	9a850513          	addi	a0,a0,-1624 # 6550 <malloc+0x530>
     bb0:	00005097          	auipc	ra,0x5
     bb4:	07e080e7          	jalr	126(ra) # 5c2e <open>
     bb8:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bba:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bbc:	0000c917          	auipc	s2,0xc
     bc0:	0bc90913          	addi	s2,s2,188 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bc4:	10c00a13          	li	s4,268
  if(fd < 0){
     bc8:	06054c63          	bltz	a0,c40 <writebig+0xb0>
    ((int*)buf)[0] = i;
     bcc:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bd0:	40000613          	li	a2,1024
     bd4:	85ca                	mv	a1,s2
     bd6:	854e                	mv	a0,s3
     bd8:	00005097          	auipc	ra,0x5
     bdc:	036080e7          	jalr	54(ra) # 5c0e <write>
     be0:	40000793          	li	a5,1024
     be4:	06f51c63          	bne	a0,a5,c5c <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     be8:	2485                	addiw	s1,s1,1
     bea:	ff4491e3          	bne	s1,s4,bcc <writebig+0x3c>
  close(fd);
     bee:	854e                	mv	a0,s3
     bf0:	00005097          	auipc	ra,0x5
     bf4:	026080e7          	jalr	38(ra) # 5c16 <close>
  fd = open("big", O_RDONLY);
     bf8:	4581                	li	a1,0
     bfa:	00006517          	auipc	a0,0x6
     bfe:	95650513          	addi	a0,a0,-1706 # 6550 <malloc+0x530>
     c02:	00005097          	auipc	ra,0x5
     c06:	02c080e7          	jalr	44(ra) # 5c2e <open>
     c0a:	89aa                	mv	s3,a0
  n = 0;
     c0c:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c0e:	0000c917          	auipc	s2,0xc
     c12:	06a90913          	addi	s2,s2,106 # cc78 <buf>
  if(fd < 0){
     c16:	06054263          	bltz	a0,c7a <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c1a:	40000613          	li	a2,1024
     c1e:	85ca                	mv	a1,s2
     c20:	854e                	mv	a0,s3
     c22:	00005097          	auipc	ra,0x5
     c26:	fe4080e7          	jalr	-28(ra) # 5c06 <read>
    if(i == 0){
     c2a:	c535                	beqz	a0,c96 <writebig+0x106>
    } else if(i != BSIZE){
     c2c:	40000793          	li	a5,1024
     c30:	0af51f63          	bne	a0,a5,cee <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c34:	00092683          	lw	a3,0(s2)
     c38:	0c969a63          	bne	a3,s1,d0c <writebig+0x17c>
    n++;
     c3c:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c3e:	bff1                	j	c1a <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c40:	85d6                	mv	a1,s5
     c42:	00006517          	auipc	a0,0x6
     c46:	91650513          	addi	a0,a0,-1770 # 6558 <malloc+0x538>
     c4a:	00005097          	auipc	ra,0x5
     c4e:	31e080e7          	jalr	798(ra) # 5f68 <printf>
    exit(1);
     c52:	4505                	li	a0,1
     c54:	00005097          	auipc	ra,0x5
     c58:	f9a080e7          	jalr	-102(ra) # 5bee <exit>
      printf("%s: error: write big file failed\n", s, i);
     c5c:	8626                	mv	a2,s1
     c5e:	85d6                	mv	a1,s5
     c60:	00006517          	auipc	a0,0x6
     c64:	91850513          	addi	a0,a0,-1768 # 6578 <malloc+0x558>
     c68:	00005097          	auipc	ra,0x5
     c6c:	300080e7          	jalr	768(ra) # 5f68 <printf>
      exit(1);
     c70:	4505                	li	a0,1
     c72:	00005097          	auipc	ra,0x5
     c76:	f7c080e7          	jalr	-132(ra) # 5bee <exit>
    printf("%s: error: open big failed!\n", s);
     c7a:	85d6                	mv	a1,s5
     c7c:	00006517          	auipc	a0,0x6
     c80:	92450513          	addi	a0,a0,-1756 # 65a0 <malloc+0x580>
     c84:	00005097          	auipc	ra,0x5
     c88:	2e4080e7          	jalr	740(ra) # 5f68 <printf>
    exit(1);
     c8c:	4505                	li	a0,1
     c8e:	00005097          	auipc	ra,0x5
     c92:	f60080e7          	jalr	-160(ra) # 5bee <exit>
      if(n == MAXFILE - 1){
     c96:	10b00793          	li	a5,267
     c9a:	02f48a63          	beq	s1,a5,cce <writebig+0x13e>
  close(fd);
     c9e:	854e                	mv	a0,s3
     ca0:	00005097          	auipc	ra,0x5
     ca4:	f76080e7          	jalr	-138(ra) # 5c16 <close>
  if(unlink("big") < 0){
     ca8:	00006517          	auipc	a0,0x6
     cac:	8a850513          	addi	a0,a0,-1880 # 6550 <malloc+0x530>
     cb0:	00005097          	auipc	ra,0x5
     cb4:	f8e080e7          	jalr	-114(ra) # 5c3e <unlink>
     cb8:	06054963          	bltz	a0,d2a <writebig+0x19a>
}
     cbc:	70e2                	ld	ra,56(sp)
     cbe:	7442                	ld	s0,48(sp)
     cc0:	74a2                	ld	s1,40(sp)
     cc2:	7902                	ld	s2,32(sp)
     cc4:	69e2                	ld	s3,24(sp)
     cc6:	6a42                	ld	s4,16(sp)
     cc8:	6aa2                	ld	s5,8(sp)
     cca:	6121                	addi	sp,sp,64
     ccc:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cce:	10b00613          	li	a2,267
     cd2:	85d6                	mv	a1,s5
     cd4:	00006517          	auipc	a0,0x6
     cd8:	8ec50513          	addi	a0,a0,-1812 # 65c0 <malloc+0x5a0>
     cdc:	00005097          	auipc	ra,0x5
     ce0:	28c080e7          	jalr	652(ra) # 5f68 <printf>
        exit(1);
     ce4:	4505                	li	a0,1
     ce6:	00005097          	auipc	ra,0x5
     cea:	f08080e7          	jalr	-248(ra) # 5bee <exit>
      printf("%s: read failed %d\n", s, i);
     cee:	862a                	mv	a2,a0
     cf0:	85d6                	mv	a1,s5
     cf2:	00006517          	auipc	a0,0x6
     cf6:	8f650513          	addi	a0,a0,-1802 # 65e8 <malloc+0x5c8>
     cfa:	00005097          	auipc	ra,0x5
     cfe:	26e080e7          	jalr	622(ra) # 5f68 <printf>
      exit(1);
     d02:	4505                	li	a0,1
     d04:	00005097          	auipc	ra,0x5
     d08:	eea080e7          	jalr	-278(ra) # 5bee <exit>
      printf("%s: read content of block %d is %d\n", s,
     d0c:	8626                	mv	a2,s1
     d0e:	85d6                	mv	a1,s5
     d10:	00006517          	auipc	a0,0x6
     d14:	8f050513          	addi	a0,a0,-1808 # 6600 <malloc+0x5e0>
     d18:	00005097          	auipc	ra,0x5
     d1c:	250080e7          	jalr	592(ra) # 5f68 <printf>
      exit(1);
     d20:	4505                	li	a0,1
     d22:	00005097          	auipc	ra,0x5
     d26:	ecc080e7          	jalr	-308(ra) # 5bee <exit>
    printf("%s: unlink big failed\n", s);
     d2a:	85d6                	mv	a1,s5
     d2c:	00006517          	auipc	a0,0x6
     d30:	8fc50513          	addi	a0,a0,-1796 # 6628 <malloc+0x608>
     d34:	00005097          	auipc	ra,0x5
     d38:	234080e7          	jalr	564(ra) # 5f68 <printf>
    exit(1);
     d3c:	4505                	li	a0,1
     d3e:	00005097          	auipc	ra,0x5
     d42:	eb0080e7          	jalr	-336(ra) # 5bee <exit>

0000000000000d46 <unlinkread>:
{
     d46:	7179                	addi	sp,sp,-48
     d48:	f406                	sd	ra,40(sp)
     d4a:	f022                	sd	s0,32(sp)
     d4c:	ec26                	sd	s1,24(sp)
     d4e:	e84a                	sd	s2,16(sp)
     d50:	e44e                	sd	s3,8(sp)
     d52:	1800                	addi	s0,sp,48
     d54:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d56:	20200593          	li	a1,514
     d5a:	00006517          	auipc	a0,0x6
     d5e:	8e650513          	addi	a0,a0,-1818 # 6640 <malloc+0x620>
     d62:	00005097          	auipc	ra,0x5
     d66:	ecc080e7          	jalr	-308(ra) # 5c2e <open>
  if(fd < 0){
     d6a:	0e054563          	bltz	a0,e54 <unlinkread+0x10e>
     d6e:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d70:	4615                	li	a2,5
     d72:	00006597          	auipc	a1,0x6
     d76:	8fe58593          	addi	a1,a1,-1794 # 6670 <malloc+0x650>
     d7a:	00005097          	auipc	ra,0x5
     d7e:	e94080e7          	jalr	-364(ra) # 5c0e <write>
  close(fd);
     d82:	8526                	mv	a0,s1
     d84:	00005097          	auipc	ra,0x5
     d88:	e92080e7          	jalr	-366(ra) # 5c16 <close>
  fd = open("unlinkread", O_RDWR);
     d8c:	4589                	li	a1,2
     d8e:	00006517          	auipc	a0,0x6
     d92:	8b250513          	addi	a0,a0,-1870 # 6640 <malloc+0x620>
     d96:	00005097          	auipc	ra,0x5
     d9a:	e98080e7          	jalr	-360(ra) # 5c2e <open>
     d9e:	84aa                	mv	s1,a0
  if(fd < 0){
     da0:	0c054863          	bltz	a0,e70 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     da4:	00006517          	auipc	a0,0x6
     da8:	89c50513          	addi	a0,a0,-1892 # 6640 <malloc+0x620>
     dac:	00005097          	auipc	ra,0x5
     db0:	e92080e7          	jalr	-366(ra) # 5c3e <unlink>
     db4:	ed61                	bnez	a0,e8c <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     db6:	20200593          	li	a1,514
     dba:	00006517          	auipc	a0,0x6
     dbe:	88650513          	addi	a0,a0,-1914 # 6640 <malloc+0x620>
     dc2:	00005097          	auipc	ra,0x5
     dc6:	e6c080e7          	jalr	-404(ra) # 5c2e <open>
     dca:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dcc:	460d                	li	a2,3
     dce:	00006597          	auipc	a1,0x6
     dd2:	8ea58593          	addi	a1,a1,-1814 # 66b8 <malloc+0x698>
     dd6:	00005097          	auipc	ra,0x5
     dda:	e38080e7          	jalr	-456(ra) # 5c0e <write>
  close(fd1);
     dde:	854a                	mv	a0,s2
     de0:	00005097          	auipc	ra,0x5
     de4:	e36080e7          	jalr	-458(ra) # 5c16 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de8:	660d                	lui	a2,0x3
     dea:	0000c597          	auipc	a1,0xc
     dee:	e8e58593          	addi	a1,a1,-370 # cc78 <buf>
     df2:	8526                	mv	a0,s1
     df4:	00005097          	auipc	ra,0x5
     df8:	e12080e7          	jalr	-494(ra) # 5c06 <read>
     dfc:	4795                	li	a5,5
     dfe:	0af51563          	bne	a0,a5,ea8 <unlinkread+0x162>
  if(buf[0] != 'h'){
     e02:	0000c717          	auipc	a4,0xc
     e06:	e7674703          	lbu	a4,-394(a4) # cc78 <buf>
     e0a:	06800793          	li	a5,104
     e0e:	0af71b63          	bne	a4,a5,ec4 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e12:	4629                	li	a2,10
     e14:	0000c597          	auipc	a1,0xc
     e18:	e6458593          	addi	a1,a1,-412 # cc78 <buf>
     e1c:	8526                	mv	a0,s1
     e1e:	00005097          	auipc	ra,0x5
     e22:	df0080e7          	jalr	-528(ra) # 5c0e <write>
     e26:	47a9                	li	a5,10
     e28:	0af51c63          	bne	a0,a5,ee0 <unlinkread+0x19a>
  close(fd);
     e2c:	8526                	mv	a0,s1
     e2e:	00005097          	auipc	ra,0x5
     e32:	de8080e7          	jalr	-536(ra) # 5c16 <close>
  unlink("unlinkread");
     e36:	00006517          	auipc	a0,0x6
     e3a:	80a50513          	addi	a0,a0,-2038 # 6640 <malloc+0x620>
     e3e:	00005097          	auipc	ra,0x5
     e42:	e00080e7          	jalr	-512(ra) # 5c3e <unlink>
}
     e46:	70a2                	ld	ra,40(sp)
     e48:	7402                	ld	s0,32(sp)
     e4a:	64e2                	ld	s1,24(sp)
     e4c:	6942                	ld	s2,16(sp)
     e4e:	69a2                	ld	s3,8(sp)
     e50:	6145                	addi	sp,sp,48
     e52:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e54:	85ce                	mv	a1,s3
     e56:	00005517          	auipc	a0,0x5
     e5a:	7fa50513          	addi	a0,a0,2042 # 6650 <malloc+0x630>
     e5e:	00005097          	auipc	ra,0x5
     e62:	10a080e7          	jalr	266(ra) # 5f68 <printf>
    exit(1);
     e66:	4505                	li	a0,1
     e68:	00005097          	auipc	ra,0x5
     e6c:	d86080e7          	jalr	-634(ra) # 5bee <exit>
    printf("%s: open unlinkread failed\n", s);
     e70:	85ce                	mv	a1,s3
     e72:	00006517          	auipc	a0,0x6
     e76:	80650513          	addi	a0,a0,-2042 # 6678 <malloc+0x658>
     e7a:	00005097          	auipc	ra,0x5
     e7e:	0ee080e7          	jalr	238(ra) # 5f68 <printf>
    exit(1);
     e82:	4505                	li	a0,1
     e84:	00005097          	auipc	ra,0x5
     e88:	d6a080e7          	jalr	-662(ra) # 5bee <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e8c:	85ce                	mv	a1,s3
     e8e:	00006517          	auipc	a0,0x6
     e92:	80a50513          	addi	a0,a0,-2038 # 6698 <malloc+0x678>
     e96:	00005097          	auipc	ra,0x5
     e9a:	0d2080e7          	jalr	210(ra) # 5f68 <printf>
    exit(1);
     e9e:	4505                	li	a0,1
     ea0:	00005097          	auipc	ra,0x5
     ea4:	d4e080e7          	jalr	-690(ra) # 5bee <exit>
    printf("%s: unlinkread read failed", s);
     ea8:	85ce                	mv	a1,s3
     eaa:	00006517          	auipc	a0,0x6
     eae:	81650513          	addi	a0,a0,-2026 # 66c0 <malloc+0x6a0>
     eb2:	00005097          	auipc	ra,0x5
     eb6:	0b6080e7          	jalr	182(ra) # 5f68 <printf>
    exit(1);
     eba:	4505                	li	a0,1
     ebc:	00005097          	auipc	ra,0x5
     ec0:	d32080e7          	jalr	-718(ra) # 5bee <exit>
    printf("%s: unlinkread wrong data\n", s);
     ec4:	85ce                	mv	a1,s3
     ec6:	00006517          	auipc	a0,0x6
     eca:	81a50513          	addi	a0,a0,-2022 # 66e0 <malloc+0x6c0>
     ece:	00005097          	auipc	ra,0x5
     ed2:	09a080e7          	jalr	154(ra) # 5f68 <printf>
    exit(1);
     ed6:	4505                	li	a0,1
     ed8:	00005097          	auipc	ra,0x5
     edc:	d16080e7          	jalr	-746(ra) # 5bee <exit>
    printf("%s: unlinkread write failed\n", s);
     ee0:	85ce                	mv	a1,s3
     ee2:	00006517          	auipc	a0,0x6
     ee6:	81e50513          	addi	a0,a0,-2018 # 6700 <malloc+0x6e0>
     eea:	00005097          	auipc	ra,0x5
     eee:	07e080e7          	jalr	126(ra) # 5f68 <printf>
    exit(1);
     ef2:	4505                	li	a0,1
     ef4:	00005097          	auipc	ra,0x5
     ef8:	cfa080e7          	jalr	-774(ra) # 5bee <exit>

0000000000000efc <linktest>:
{
     efc:	1101                	addi	sp,sp,-32
     efe:	ec06                	sd	ra,24(sp)
     f00:	e822                	sd	s0,16(sp)
     f02:	e426                	sd	s1,8(sp)
     f04:	e04a                	sd	s2,0(sp)
     f06:	1000                	addi	s0,sp,32
     f08:	892a                	mv	s2,a0
  unlink("lf1");
     f0a:	00006517          	auipc	a0,0x6
     f0e:	81650513          	addi	a0,a0,-2026 # 6720 <malloc+0x700>
     f12:	00005097          	auipc	ra,0x5
     f16:	d2c080e7          	jalr	-724(ra) # 5c3e <unlink>
  unlink("lf2");
     f1a:	00006517          	auipc	a0,0x6
     f1e:	80e50513          	addi	a0,a0,-2034 # 6728 <malloc+0x708>
     f22:	00005097          	auipc	ra,0x5
     f26:	d1c080e7          	jalr	-740(ra) # 5c3e <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f2a:	20200593          	li	a1,514
     f2e:	00005517          	auipc	a0,0x5
     f32:	7f250513          	addi	a0,a0,2034 # 6720 <malloc+0x700>
     f36:	00005097          	auipc	ra,0x5
     f3a:	cf8080e7          	jalr	-776(ra) # 5c2e <open>
  if(fd < 0){
     f3e:	10054763          	bltz	a0,104c <linktest+0x150>
     f42:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f44:	4615                	li	a2,5
     f46:	00005597          	auipc	a1,0x5
     f4a:	72a58593          	addi	a1,a1,1834 # 6670 <malloc+0x650>
     f4e:	00005097          	auipc	ra,0x5
     f52:	cc0080e7          	jalr	-832(ra) # 5c0e <write>
     f56:	4795                	li	a5,5
     f58:	10f51863          	bne	a0,a5,1068 <linktest+0x16c>
  close(fd);
     f5c:	8526                	mv	a0,s1
     f5e:	00005097          	auipc	ra,0x5
     f62:	cb8080e7          	jalr	-840(ra) # 5c16 <close>
  if(link("lf1", "lf2") < 0){
     f66:	00005597          	auipc	a1,0x5
     f6a:	7c258593          	addi	a1,a1,1986 # 6728 <malloc+0x708>
     f6e:	00005517          	auipc	a0,0x5
     f72:	7b250513          	addi	a0,a0,1970 # 6720 <malloc+0x700>
     f76:	00005097          	auipc	ra,0x5
     f7a:	cd8080e7          	jalr	-808(ra) # 5c4e <link>
     f7e:	10054363          	bltz	a0,1084 <linktest+0x188>
  unlink("lf1");
     f82:	00005517          	auipc	a0,0x5
     f86:	79e50513          	addi	a0,a0,1950 # 6720 <malloc+0x700>
     f8a:	00005097          	auipc	ra,0x5
     f8e:	cb4080e7          	jalr	-844(ra) # 5c3e <unlink>
  if(open("lf1", 0) >= 0){
     f92:	4581                	li	a1,0
     f94:	00005517          	auipc	a0,0x5
     f98:	78c50513          	addi	a0,a0,1932 # 6720 <malloc+0x700>
     f9c:	00005097          	auipc	ra,0x5
     fa0:	c92080e7          	jalr	-878(ra) # 5c2e <open>
     fa4:	0e055e63          	bgez	a0,10a0 <linktest+0x1a4>
  fd = open("lf2", 0);
     fa8:	4581                	li	a1,0
     faa:	00005517          	auipc	a0,0x5
     fae:	77e50513          	addi	a0,a0,1918 # 6728 <malloc+0x708>
     fb2:	00005097          	auipc	ra,0x5
     fb6:	c7c080e7          	jalr	-900(ra) # 5c2e <open>
     fba:	84aa                	mv	s1,a0
  if(fd < 0){
     fbc:	10054063          	bltz	a0,10bc <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fc0:	660d                	lui	a2,0x3
     fc2:	0000c597          	auipc	a1,0xc
     fc6:	cb658593          	addi	a1,a1,-842 # cc78 <buf>
     fca:	00005097          	auipc	ra,0x5
     fce:	c3c080e7          	jalr	-964(ra) # 5c06 <read>
     fd2:	4795                	li	a5,5
     fd4:	10f51263          	bne	a0,a5,10d8 <linktest+0x1dc>
  close(fd);
     fd8:	8526                	mv	a0,s1
     fda:	00005097          	auipc	ra,0x5
     fde:	c3c080e7          	jalr	-964(ra) # 5c16 <close>
  if(link("lf2", "lf2") >= 0){
     fe2:	00005597          	auipc	a1,0x5
     fe6:	74658593          	addi	a1,a1,1862 # 6728 <malloc+0x708>
     fea:	852e                	mv	a0,a1
     fec:	00005097          	auipc	ra,0x5
     ff0:	c62080e7          	jalr	-926(ra) # 5c4e <link>
     ff4:	10055063          	bgez	a0,10f4 <linktest+0x1f8>
  unlink("lf2");
     ff8:	00005517          	auipc	a0,0x5
     ffc:	73050513          	addi	a0,a0,1840 # 6728 <malloc+0x708>
    1000:	00005097          	auipc	ra,0x5
    1004:	c3e080e7          	jalr	-962(ra) # 5c3e <unlink>
  if(link("lf2", "lf1") >= 0){
    1008:	00005597          	auipc	a1,0x5
    100c:	71858593          	addi	a1,a1,1816 # 6720 <malloc+0x700>
    1010:	00005517          	auipc	a0,0x5
    1014:	71850513          	addi	a0,a0,1816 # 6728 <malloc+0x708>
    1018:	00005097          	auipc	ra,0x5
    101c:	c36080e7          	jalr	-970(ra) # 5c4e <link>
    1020:	0e055863          	bgez	a0,1110 <linktest+0x214>
  if(link(".", "lf1") >= 0){
    1024:	00005597          	auipc	a1,0x5
    1028:	6fc58593          	addi	a1,a1,1788 # 6720 <malloc+0x700>
    102c:	00006517          	auipc	a0,0x6
    1030:	80450513          	addi	a0,a0,-2044 # 6830 <malloc+0x810>
    1034:	00005097          	auipc	ra,0x5
    1038:	c1a080e7          	jalr	-998(ra) # 5c4e <link>
    103c:	0e055863          	bgez	a0,112c <linktest+0x230>
}
    1040:	60e2                	ld	ra,24(sp)
    1042:	6442                	ld	s0,16(sp)
    1044:	64a2                	ld	s1,8(sp)
    1046:	6902                	ld	s2,0(sp)
    1048:	6105                	addi	sp,sp,32
    104a:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    104c:	85ca                	mv	a1,s2
    104e:	00005517          	auipc	a0,0x5
    1052:	6e250513          	addi	a0,a0,1762 # 6730 <malloc+0x710>
    1056:	00005097          	auipc	ra,0x5
    105a:	f12080e7          	jalr	-238(ra) # 5f68 <printf>
    exit(1);
    105e:	4505                	li	a0,1
    1060:	00005097          	auipc	ra,0x5
    1064:	b8e080e7          	jalr	-1138(ra) # 5bee <exit>
    printf("%s: write lf1 failed\n", s);
    1068:	85ca                	mv	a1,s2
    106a:	00005517          	auipc	a0,0x5
    106e:	6de50513          	addi	a0,a0,1758 # 6748 <malloc+0x728>
    1072:	00005097          	auipc	ra,0x5
    1076:	ef6080e7          	jalr	-266(ra) # 5f68 <printf>
    exit(1);
    107a:	4505                	li	a0,1
    107c:	00005097          	auipc	ra,0x5
    1080:	b72080e7          	jalr	-1166(ra) # 5bee <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    1084:	85ca                	mv	a1,s2
    1086:	00005517          	auipc	a0,0x5
    108a:	6da50513          	addi	a0,a0,1754 # 6760 <malloc+0x740>
    108e:	00005097          	auipc	ra,0x5
    1092:	eda080e7          	jalr	-294(ra) # 5f68 <printf>
    exit(1);
    1096:	4505                	li	a0,1
    1098:	00005097          	auipc	ra,0x5
    109c:	b56080e7          	jalr	-1194(ra) # 5bee <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    10a0:	85ca                	mv	a1,s2
    10a2:	00005517          	auipc	a0,0x5
    10a6:	6de50513          	addi	a0,a0,1758 # 6780 <malloc+0x760>
    10aa:	00005097          	auipc	ra,0x5
    10ae:	ebe080e7          	jalr	-322(ra) # 5f68 <printf>
    exit(1);
    10b2:	4505                	li	a0,1
    10b4:	00005097          	auipc	ra,0x5
    10b8:	b3a080e7          	jalr	-1222(ra) # 5bee <exit>
    printf("%s: open lf2 failed\n", s);
    10bc:	85ca                	mv	a1,s2
    10be:	00005517          	auipc	a0,0x5
    10c2:	6f250513          	addi	a0,a0,1778 # 67b0 <malloc+0x790>
    10c6:	00005097          	auipc	ra,0x5
    10ca:	ea2080e7          	jalr	-350(ra) # 5f68 <printf>
    exit(1);
    10ce:	4505                	li	a0,1
    10d0:	00005097          	auipc	ra,0x5
    10d4:	b1e080e7          	jalr	-1250(ra) # 5bee <exit>
    printf("%s: read lf2 failed\n", s);
    10d8:	85ca                	mv	a1,s2
    10da:	00005517          	auipc	a0,0x5
    10de:	6ee50513          	addi	a0,a0,1774 # 67c8 <malloc+0x7a8>
    10e2:	00005097          	auipc	ra,0x5
    10e6:	e86080e7          	jalr	-378(ra) # 5f68 <printf>
    exit(1);
    10ea:	4505                	li	a0,1
    10ec:	00005097          	auipc	ra,0x5
    10f0:	b02080e7          	jalr	-1278(ra) # 5bee <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10f4:	85ca                	mv	a1,s2
    10f6:	00005517          	auipc	a0,0x5
    10fa:	6ea50513          	addi	a0,a0,1770 # 67e0 <malloc+0x7c0>
    10fe:	00005097          	auipc	ra,0x5
    1102:	e6a080e7          	jalr	-406(ra) # 5f68 <printf>
    exit(1);
    1106:	4505                	li	a0,1
    1108:	00005097          	auipc	ra,0x5
    110c:	ae6080e7          	jalr	-1306(ra) # 5bee <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    1110:	85ca                	mv	a1,s2
    1112:	00005517          	auipc	a0,0x5
    1116:	6f650513          	addi	a0,a0,1782 # 6808 <malloc+0x7e8>
    111a:	00005097          	auipc	ra,0x5
    111e:	e4e080e7          	jalr	-434(ra) # 5f68 <printf>
    exit(1);
    1122:	4505                	li	a0,1
    1124:	00005097          	auipc	ra,0x5
    1128:	aca080e7          	jalr	-1334(ra) # 5bee <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    112c:	85ca                	mv	a1,s2
    112e:	00005517          	auipc	a0,0x5
    1132:	70a50513          	addi	a0,a0,1802 # 6838 <malloc+0x818>
    1136:	00005097          	auipc	ra,0x5
    113a:	e32080e7          	jalr	-462(ra) # 5f68 <printf>
    exit(1);
    113e:	4505                	li	a0,1
    1140:	00005097          	auipc	ra,0x5
    1144:	aae080e7          	jalr	-1362(ra) # 5bee <exit>

0000000000001148 <validatetest>:
{
    1148:	7139                	addi	sp,sp,-64
    114a:	fc06                	sd	ra,56(sp)
    114c:	f822                	sd	s0,48(sp)
    114e:	f426                	sd	s1,40(sp)
    1150:	f04a                	sd	s2,32(sp)
    1152:	ec4e                	sd	s3,24(sp)
    1154:	e852                	sd	s4,16(sp)
    1156:	e456                	sd	s5,8(sp)
    1158:	e05a                	sd	s6,0(sp)
    115a:	0080                	addi	s0,sp,64
    115c:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    115e:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    1160:	00005997          	auipc	s3,0x5
    1164:	6f898993          	addi	s3,s3,1784 # 6858 <malloc+0x838>
    1168:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    116a:	6a85                	lui	s5,0x1
    116c:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    1170:	85a6                	mv	a1,s1
    1172:	854e                	mv	a0,s3
    1174:	00005097          	auipc	ra,0x5
    1178:	ada080e7          	jalr	-1318(ra) # 5c4e <link>
    117c:	01251f63          	bne	a0,s2,119a <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1180:	94d6                	add	s1,s1,s5
    1182:	ff4497e3          	bne	s1,s4,1170 <validatetest+0x28>
}
    1186:	70e2                	ld	ra,56(sp)
    1188:	7442                	ld	s0,48(sp)
    118a:	74a2                	ld	s1,40(sp)
    118c:	7902                	ld	s2,32(sp)
    118e:	69e2                	ld	s3,24(sp)
    1190:	6a42                	ld	s4,16(sp)
    1192:	6aa2                	ld	s5,8(sp)
    1194:	6b02                	ld	s6,0(sp)
    1196:	6121                	addi	sp,sp,64
    1198:	8082                	ret
      printf("%s: link should not succeed\n", s);
    119a:	85da                	mv	a1,s6
    119c:	00005517          	auipc	a0,0x5
    11a0:	6cc50513          	addi	a0,a0,1740 # 6868 <malloc+0x848>
    11a4:	00005097          	auipc	ra,0x5
    11a8:	dc4080e7          	jalr	-572(ra) # 5f68 <printf>
      exit(1);
    11ac:	4505                	li	a0,1
    11ae:	00005097          	auipc	ra,0x5
    11b2:	a40080e7          	jalr	-1472(ra) # 5bee <exit>

00000000000011b6 <bigdir>:
{
    11b6:	715d                	addi	sp,sp,-80
    11b8:	e486                	sd	ra,72(sp)
    11ba:	e0a2                	sd	s0,64(sp)
    11bc:	fc26                	sd	s1,56(sp)
    11be:	f84a                	sd	s2,48(sp)
    11c0:	f44e                	sd	s3,40(sp)
    11c2:	f052                	sd	s4,32(sp)
    11c4:	ec56                	sd	s5,24(sp)
    11c6:	e85a                	sd	s6,16(sp)
    11c8:	0880                	addi	s0,sp,80
    11ca:	89aa                	mv	s3,a0
  unlink("bd");
    11cc:	00005517          	auipc	a0,0x5
    11d0:	6bc50513          	addi	a0,a0,1724 # 6888 <malloc+0x868>
    11d4:	00005097          	auipc	ra,0x5
    11d8:	a6a080e7          	jalr	-1430(ra) # 5c3e <unlink>
  fd = open("bd", O_CREATE);
    11dc:	20000593          	li	a1,512
    11e0:	00005517          	auipc	a0,0x5
    11e4:	6a850513          	addi	a0,a0,1704 # 6888 <malloc+0x868>
    11e8:	00005097          	auipc	ra,0x5
    11ec:	a46080e7          	jalr	-1466(ra) # 5c2e <open>
  if(fd < 0){
    11f0:	0c054963          	bltz	a0,12c2 <bigdir+0x10c>
  close(fd);
    11f4:	00005097          	auipc	ra,0x5
    11f8:	a22080e7          	jalr	-1502(ra) # 5c16 <close>
  for(i = 0; i < N; i++){
    11fc:	4901                	li	s2,0
    name[0] = 'x';
    11fe:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    1202:	00005a17          	auipc	s4,0x5
    1206:	686a0a13          	addi	s4,s4,1670 # 6888 <malloc+0x868>
  for(i = 0; i < N; i++){
    120a:	1f400b13          	li	s6,500
    name[0] = 'x';
    120e:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    1212:	41f9571b          	sraiw	a4,s2,0x1f
    1216:	01a7571b          	srliw	a4,a4,0x1a
    121a:	012707bb          	addw	a5,a4,s2
    121e:	4067d69b          	sraiw	a3,a5,0x6
    1222:	0306869b          	addiw	a3,a3,48
    1226:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    122a:	03f7f793          	andi	a5,a5,63
    122e:	9f99                	subw	a5,a5,a4
    1230:	0307879b          	addiw	a5,a5,48
    1234:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1238:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    123c:	fb040593          	addi	a1,s0,-80
    1240:	8552                	mv	a0,s4
    1242:	00005097          	auipc	ra,0x5
    1246:	a0c080e7          	jalr	-1524(ra) # 5c4e <link>
    124a:	84aa                	mv	s1,a0
    124c:	e949                	bnez	a0,12de <bigdir+0x128>
  for(i = 0; i < N; i++){
    124e:	2905                	addiw	s2,s2,1
    1250:	fb691fe3          	bne	s2,s6,120e <bigdir+0x58>
  unlink("bd");
    1254:	00005517          	auipc	a0,0x5
    1258:	63450513          	addi	a0,a0,1588 # 6888 <malloc+0x868>
    125c:	00005097          	auipc	ra,0x5
    1260:	9e2080e7          	jalr	-1566(ra) # 5c3e <unlink>
    name[0] = 'x';
    1264:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1268:	1f400a13          	li	s4,500
    name[0] = 'x';
    126c:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    1270:	41f4d71b          	sraiw	a4,s1,0x1f
    1274:	01a7571b          	srliw	a4,a4,0x1a
    1278:	009707bb          	addw	a5,a4,s1
    127c:	4067d69b          	sraiw	a3,a5,0x6
    1280:	0306869b          	addiw	a3,a3,48
    1284:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1288:	03f7f793          	andi	a5,a5,63
    128c:	9f99                	subw	a5,a5,a4
    128e:	0307879b          	addiw	a5,a5,48
    1292:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1296:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    129a:	fb040513          	addi	a0,s0,-80
    129e:	00005097          	auipc	ra,0x5
    12a2:	9a0080e7          	jalr	-1632(ra) # 5c3e <unlink>
    12a6:	ed21                	bnez	a0,12fe <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a8:	2485                	addiw	s1,s1,1
    12aa:	fd4491e3          	bne	s1,s4,126c <bigdir+0xb6>
}
    12ae:	60a6                	ld	ra,72(sp)
    12b0:	6406                	ld	s0,64(sp)
    12b2:	74e2                	ld	s1,56(sp)
    12b4:	7942                	ld	s2,48(sp)
    12b6:	79a2                	ld	s3,40(sp)
    12b8:	7a02                	ld	s4,32(sp)
    12ba:	6ae2                	ld	s5,24(sp)
    12bc:	6b42                	ld	s6,16(sp)
    12be:	6161                	addi	sp,sp,80
    12c0:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12c2:	85ce                	mv	a1,s3
    12c4:	00005517          	auipc	a0,0x5
    12c8:	5cc50513          	addi	a0,a0,1484 # 6890 <malloc+0x870>
    12cc:	00005097          	auipc	ra,0x5
    12d0:	c9c080e7          	jalr	-868(ra) # 5f68 <printf>
    exit(1);
    12d4:	4505                	li	a0,1
    12d6:	00005097          	auipc	ra,0x5
    12da:	918080e7          	jalr	-1768(ra) # 5bee <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12de:	fb040613          	addi	a2,s0,-80
    12e2:	85ce                	mv	a1,s3
    12e4:	00005517          	auipc	a0,0x5
    12e8:	5cc50513          	addi	a0,a0,1484 # 68b0 <malloc+0x890>
    12ec:	00005097          	auipc	ra,0x5
    12f0:	c7c080e7          	jalr	-900(ra) # 5f68 <printf>
      exit(1);
    12f4:	4505                	li	a0,1
    12f6:	00005097          	auipc	ra,0x5
    12fa:	8f8080e7          	jalr	-1800(ra) # 5bee <exit>
      printf("%s: bigdir unlink failed", s);
    12fe:	85ce                	mv	a1,s3
    1300:	00005517          	auipc	a0,0x5
    1304:	5d050513          	addi	a0,a0,1488 # 68d0 <malloc+0x8b0>
    1308:	00005097          	auipc	ra,0x5
    130c:	c60080e7          	jalr	-928(ra) # 5f68 <printf>
      exit(1);
    1310:	4505                	li	a0,1
    1312:	00005097          	auipc	ra,0x5
    1316:	8dc080e7          	jalr	-1828(ra) # 5bee <exit>

000000000000131a <pgbug>:
{
    131a:	7179                	addi	sp,sp,-48
    131c:	f406                	sd	ra,40(sp)
    131e:	f022                	sd	s0,32(sp)
    1320:	ec26                	sd	s1,24(sp)
    1322:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1324:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1328:	00008497          	auipc	s1,0x8
    132c:	cd848493          	addi	s1,s1,-808 # 9000 <big>
    1330:	fd840593          	addi	a1,s0,-40
    1334:	6088                	ld	a0,0(s1)
    1336:	00005097          	auipc	ra,0x5
    133a:	8f0080e7          	jalr	-1808(ra) # 5c26 <exec>
  pipe(big);
    133e:	6088                	ld	a0,0(s1)
    1340:	00005097          	auipc	ra,0x5
    1344:	8be080e7          	jalr	-1858(ra) # 5bfe <pipe>
  exit(0);
    1348:	4501                	li	a0,0
    134a:	00005097          	auipc	ra,0x5
    134e:	8a4080e7          	jalr	-1884(ra) # 5bee <exit>

0000000000001352 <badarg>:
{
    1352:	7139                	addi	sp,sp,-64
    1354:	fc06                	sd	ra,56(sp)
    1356:	f822                	sd	s0,48(sp)
    1358:	f426                	sd	s1,40(sp)
    135a:	f04a                	sd	s2,32(sp)
    135c:	ec4e                	sd	s3,24(sp)
    135e:	0080                	addi	s0,sp,64
    1360:	64b1                	lui	s1,0xc
    1362:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1366:	597d                	li	s2,-1
    1368:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    136c:	00005997          	auipc	s3,0x5
    1370:	ddc98993          	addi	s3,s3,-548 # 6148 <malloc+0x128>
    argv[0] = (char*)0xffffffff;
    1374:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1378:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    137c:	fc040593          	addi	a1,s0,-64
    1380:	854e                	mv	a0,s3
    1382:	00005097          	auipc	ra,0x5
    1386:	8a4080e7          	jalr	-1884(ra) # 5c26 <exec>
  for(int i = 0; i < 50000; i++){
    138a:	34fd                	addiw	s1,s1,-1
    138c:	f4e5                	bnez	s1,1374 <badarg+0x22>
  exit(0);
    138e:	4501                	li	a0,0
    1390:	00005097          	auipc	ra,0x5
    1394:	85e080e7          	jalr	-1954(ra) # 5bee <exit>

0000000000001398 <copyinstr2>:
{
    1398:	7155                	addi	sp,sp,-208
    139a:	e586                	sd	ra,200(sp)
    139c:	e1a2                	sd	s0,192(sp)
    139e:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    13a0:	f6840793          	addi	a5,s0,-152
    13a4:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13a8:	07800713          	li	a4,120
    13ac:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13b0:	0785                	addi	a5,a5,1
    13b2:	fed79de3          	bne	a5,a3,13ac <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13b6:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13ba:	f6840513          	addi	a0,s0,-152
    13be:	00005097          	auipc	ra,0x5
    13c2:	880080e7          	jalr	-1920(ra) # 5c3e <unlink>
  if(ret != -1){
    13c6:	57fd                	li	a5,-1
    13c8:	0ef51063          	bne	a0,a5,14a8 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13cc:	20100593          	li	a1,513
    13d0:	f6840513          	addi	a0,s0,-152
    13d4:	00005097          	auipc	ra,0x5
    13d8:	85a080e7          	jalr	-1958(ra) # 5c2e <open>
  if(fd != -1){
    13dc:	57fd                	li	a5,-1
    13de:	0ef51563          	bne	a0,a5,14c8 <copyinstr2+0x130>
  ret = link(b, b);
    13e2:	f6840593          	addi	a1,s0,-152
    13e6:	852e                	mv	a0,a1
    13e8:	00005097          	auipc	ra,0x5
    13ec:	866080e7          	jalr	-1946(ra) # 5c4e <link>
  if(ret != -1){
    13f0:	57fd                	li	a5,-1
    13f2:	0ef51b63          	bne	a0,a5,14e8 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13f6:	00006797          	auipc	a5,0x6
    13fa:	73278793          	addi	a5,a5,1842 # 7b28 <malloc+0x1b08>
    13fe:	f4f43c23          	sd	a5,-168(s0)
    1402:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1406:	f5840593          	addi	a1,s0,-168
    140a:	f6840513          	addi	a0,s0,-152
    140e:	00005097          	auipc	ra,0x5
    1412:	818080e7          	jalr	-2024(ra) # 5c26 <exec>
  if(ret != -1){
    1416:	57fd                	li	a5,-1
    1418:	0ef51963          	bne	a0,a5,150a <copyinstr2+0x172>
  int pid = fork();
    141c:	00004097          	auipc	ra,0x4
    1420:	7ca080e7          	jalr	1994(ra) # 5be6 <fork>
  if(pid < 0){
    1424:	10054363          	bltz	a0,152a <copyinstr2+0x192>
  if(pid == 0){
    1428:	12051463          	bnez	a0,1550 <copyinstr2+0x1b8>
    142c:	00008797          	auipc	a5,0x8
    1430:	13478793          	addi	a5,a5,308 # 9560 <big.0>
    1434:	00009697          	auipc	a3,0x9
    1438:	12c68693          	addi	a3,a3,300 # a560 <big.0+0x1000>
      big[i] = 'x';
    143c:	07800713          	li	a4,120
    1440:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1444:	0785                	addi	a5,a5,1
    1446:	fed79de3          	bne	a5,a3,1440 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    144a:	00009797          	auipc	a5,0x9
    144e:	10078b23          	sb	zero,278(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    1452:	00007797          	auipc	a5,0x7
    1456:	11678793          	addi	a5,a5,278 # 8568 <malloc+0x2548>
    145a:	6390                	ld	a2,0(a5)
    145c:	6794                	ld	a3,8(a5)
    145e:	6b98                	ld	a4,16(a5)
    1460:	6f9c                	ld	a5,24(a5)
    1462:	f2c43823          	sd	a2,-208(s0)
    1466:	f2d43c23          	sd	a3,-200(s0)
    146a:	f4e43023          	sd	a4,-192(s0)
    146e:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1472:	f3040593          	addi	a1,s0,-208
    1476:	00005517          	auipc	a0,0x5
    147a:	cd250513          	addi	a0,a0,-814 # 6148 <malloc+0x128>
    147e:	00004097          	auipc	ra,0x4
    1482:	7a8080e7          	jalr	1960(ra) # 5c26 <exec>
    if(ret != -1){
    1486:	57fd                	li	a5,-1
    1488:	0af50e63          	beq	a0,a5,1544 <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    148c:	55fd                	li	a1,-1
    148e:	00005517          	auipc	a0,0x5
    1492:	4ea50513          	addi	a0,a0,1258 # 6978 <malloc+0x958>
    1496:	00005097          	auipc	ra,0x5
    149a:	ad2080e7          	jalr	-1326(ra) # 5f68 <printf>
      exit(1);
    149e:	4505                	li	a0,1
    14a0:	00004097          	auipc	ra,0x4
    14a4:	74e080e7          	jalr	1870(ra) # 5bee <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a8:	862a                	mv	a2,a0
    14aa:	f6840593          	addi	a1,s0,-152
    14ae:	00005517          	auipc	a0,0x5
    14b2:	44250513          	addi	a0,a0,1090 # 68f0 <malloc+0x8d0>
    14b6:	00005097          	auipc	ra,0x5
    14ba:	ab2080e7          	jalr	-1358(ra) # 5f68 <printf>
    exit(1);
    14be:	4505                	li	a0,1
    14c0:	00004097          	auipc	ra,0x4
    14c4:	72e080e7          	jalr	1838(ra) # 5bee <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c8:	862a                	mv	a2,a0
    14ca:	f6840593          	addi	a1,s0,-152
    14ce:	00005517          	auipc	a0,0x5
    14d2:	44250513          	addi	a0,a0,1090 # 6910 <malloc+0x8f0>
    14d6:	00005097          	auipc	ra,0x5
    14da:	a92080e7          	jalr	-1390(ra) # 5f68 <printf>
    exit(1);
    14de:	4505                	li	a0,1
    14e0:	00004097          	auipc	ra,0x4
    14e4:	70e080e7          	jalr	1806(ra) # 5bee <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e8:	86aa                	mv	a3,a0
    14ea:	f6840613          	addi	a2,s0,-152
    14ee:	85b2                	mv	a1,a2
    14f0:	00005517          	auipc	a0,0x5
    14f4:	44050513          	addi	a0,a0,1088 # 6930 <malloc+0x910>
    14f8:	00005097          	auipc	ra,0x5
    14fc:	a70080e7          	jalr	-1424(ra) # 5f68 <printf>
    exit(1);
    1500:	4505                	li	a0,1
    1502:	00004097          	auipc	ra,0x4
    1506:	6ec080e7          	jalr	1772(ra) # 5bee <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    150a:	567d                	li	a2,-1
    150c:	f6840593          	addi	a1,s0,-152
    1510:	00005517          	auipc	a0,0x5
    1514:	44850513          	addi	a0,a0,1096 # 6958 <malloc+0x938>
    1518:	00005097          	auipc	ra,0x5
    151c:	a50080e7          	jalr	-1456(ra) # 5f68 <printf>
    exit(1);
    1520:	4505                	li	a0,1
    1522:	00004097          	auipc	ra,0x4
    1526:	6cc080e7          	jalr	1740(ra) # 5bee <exit>
    printf("fork failed\n");
    152a:	00006517          	auipc	a0,0x6
    152e:	8ae50513          	addi	a0,a0,-1874 # 6dd8 <malloc+0xdb8>
    1532:	00005097          	auipc	ra,0x5
    1536:	a36080e7          	jalr	-1482(ra) # 5f68 <printf>
    exit(1);
    153a:	4505                	li	a0,1
    153c:	00004097          	auipc	ra,0x4
    1540:	6b2080e7          	jalr	1714(ra) # 5bee <exit>
    exit(747); // OK
    1544:	2eb00513          	li	a0,747
    1548:	00004097          	auipc	ra,0x4
    154c:	6a6080e7          	jalr	1702(ra) # 5bee <exit>
  int st = 0;
    1550:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1554:	f5440513          	addi	a0,s0,-172
    1558:	00004097          	auipc	ra,0x4
    155c:	69e080e7          	jalr	1694(ra) # 5bf6 <wait>
  if(st != 747){
    1560:	f5442703          	lw	a4,-172(s0)
    1564:	2eb00793          	li	a5,747
    1568:	00f71663          	bne	a4,a5,1574 <copyinstr2+0x1dc>
}
    156c:	60ae                	ld	ra,200(sp)
    156e:	640e                	ld	s0,192(sp)
    1570:	6169                	addi	sp,sp,208
    1572:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1574:	00005517          	auipc	a0,0x5
    1578:	42c50513          	addi	a0,a0,1068 # 69a0 <malloc+0x980>
    157c:	00005097          	auipc	ra,0x5
    1580:	9ec080e7          	jalr	-1556(ra) # 5f68 <printf>
    exit(1);
    1584:	4505                	li	a0,1
    1586:	00004097          	auipc	ra,0x4
    158a:	668080e7          	jalr	1640(ra) # 5bee <exit>

000000000000158e <truncate3>:
{
    158e:	7159                	addi	sp,sp,-112
    1590:	f486                	sd	ra,104(sp)
    1592:	f0a2                	sd	s0,96(sp)
    1594:	eca6                	sd	s1,88(sp)
    1596:	e8ca                	sd	s2,80(sp)
    1598:	e4ce                	sd	s3,72(sp)
    159a:	e0d2                	sd	s4,64(sp)
    159c:	fc56                	sd	s5,56(sp)
    159e:	1880                	addi	s0,sp,112
    15a0:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    15a2:	60100593          	li	a1,1537
    15a6:	00005517          	auipc	a0,0x5
    15aa:	bfa50513          	addi	a0,a0,-1030 # 61a0 <malloc+0x180>
    15ae:	00004097          	auipc	ra,0x4
    15b2:	680080e7          	jalr	1664(ra) # 5c2e <open>
    15b6:	00004097          	auipc	ra,0x4
    15ba:	660080e7          	jalr	1632(ra) # 5c16 <close>
  pid = fork();
    15be:	00004097          	auipc	ra,0x4
    15c2:	628080e7          	jalr	1576(ra) # 5be6 <fork>
  if(pid < 0){
    15c6:	08054063          	bltz	a0,1646 <truncate3+0xb8>
  if(pid == 0){
    15ca:	e969                	bnez	a0,169c <truncate3+0x10e>
    15cc:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15d0:	00005a17          	auipc	s4,0x5
    15d4:	bd0a0a13          	addi	s4,s4,-1072 # 61a0 <malloc+0x180>
      int n = write(fd, "1234567890", 10);
    15d8:	00005a97          	auipc	s5,0x5
    15dc:	428a8a93          	addi	s5,s5,1064 # 6a00 <malloc+0x9e0>
      int fd = open("truncfile", O_WRONLY);
    15e0:	4585                	li	a1,1
    15e2:	8552                	mv	a0,s4
    15e4:	00004097          	auipc	ra,0x4
    15e8:	64a080e7          	jalr	1610(ra) # 5c2e <open>
    15ec:	84aa                	mv	s1,a0
      if(fd < 0){
    15ee:	06054a63          	bltz	a0,1662 <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15f2:	4629                	li	a2,10
    15f4:	85d6                	mv	a1,s5
    15f6:	00004097          	auipc	ra,0x4
    15fa:	618080e7          	jalr	1560(ra) # 5c0e <write>
      if(n != 10){
    15fe:	47a9                	li	a5,10
    1600:	06f51f63          	bne	a0,a5,167e <truncate3+0xf0>
      close(fd);
    1604:	8526                	mv	a0,s1
    1606:	00004097          	auipc	ra,0x4
    160a:	610080e7          	jalr	1552(ra) # 5c16 <close>
      fd = open("truncfile", O_RDONLY);
    160e:	4581                	li	a1,0
    1610:	8552                	mv	a0,s4
    1612:	00004097          	auipc	ra,0x4
    1616:	61c080e7          	jalr	1564(ra) # 5c2e <open>
    161a:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    161c:	02000613          	li	a2,32
    1620:	f9840593          	addi	a1,s0,-104
    1624:	00004097          	auipc	ra,0x4
    1628:	5e2080e7          	jalr	1506(ra) # 5c06 <read>
      close(fd);
    162c:	8526                	mv	a0,s1
    162e:	00004097          	auipc	ra,0x4
    1632:	5e8080e7          	jalr	1512(ra) # 5c16 <close>
    for(int i = 0; i < 100; i++){
    1636:	39fd                	addiw	s3,s3,-1
    1638:	fa0994e3          	bnez	s3,15e0 <truncate3+0x52>
    exit(0);
    163c:	4501                	li	a0,0
    163e:	00004097          	auipc	ra,0x4
    1642:	5b0080e7          	jalr	1456(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    1646:	85ca                	mv	a1,s2
    1648:	00005517          	auipc	a0,0x5
    164c:	38850513          	addi	a0,a0,904 # 69d0 <malloc+0x9b0>
    1650:	00005097          	auipc	ra,0x5
    1654:	918080e7          	jalr	-1768(ra) # 5f68 <printf>
    exit(1);
    1658:	4505                	li	a0,1
    165a:	00004097          	auipc	ra,0x4
    165e:	594080e7          	jalr	1428(ra) # 5bee <exit>
        printf("%s: open failed\n", s);
    1662:	85ca                	mv	a1,s2
    1664:	00005517          	auipc	a0,0x5
    1668:	38450513          	addi	a0,a0,900 # 69e8 <malloc+0x9c8>
    166c:	00005097          	auipc	ra,0x5
    1670:	8fc080e7          	jalr	-1796(ra) # 5f68 <printf>
        exit(1);
    1674:	4505                	li	a0,1
    1676:	00004097          	auipc	ra,0x4
    167a:	578080e7          	jalr	1400(ra) # 5bee <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    167e:	862a                	mv	a2,a0
    1680:	85ca                	mv	a1,s2
    1682:	00005517          	auipc	a0,0x5
    1686:	38e50513          	addi	a0,a0,910 # 6a10 <malloc+0x9f0>
    168a:	00005097          	auipc	ra,0x5
    168e:	8de080e7          	jalr	-1826(ra) # 5f68 <printf>
        exit(1);
    1692:	4505                	li	a0,1
    1694:	00004097          	auipc	ra,0x4
    1698:	55a080e7          	jalr	1370(ra) # 5bee <exit>
    169c:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16a0:	00005a17          	auipc	s4,0x5
    16a4:	b00a0a13          	addi	s4,s4,-1280 # 61a0 <malloc+0x180>
    int n = write(fd, "xxx", 3);
    16a8:	00005a97          	auipc	s5,0x5
    16ac:	388a8a93          	addi	s5,s5,904 # 6a30 <malloc+0xa10>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16b0:	60100593          	li	a1,1537
    16b4:	8552                	mv	a0,s4
    16b6:	00004097          	auipc	ra,0x4
    16ba:	578080e7          	jalr	1400(ra) # 5c2e <open>
    16be:	84aa                	mv	s1,a0
    if(fd < 0){
    16c0:	04054763          	bltz	a0,170e <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16c4:	460d                	li	a2,3
    16c6:	85d6                	mv	a1,s5
    16c8:	00004097          	auipc	ra,0x4
    16cc:	546080e7          	jalr	1350(ra) # 5c0e <write>
    if(n != 3){
    16d0:	478d                	li	a5,3
    16d2:	04f51c63          	bne	a0,a5,172a <truncate3+0x19c>
    close(fd);
    16d6:	8526                	mv	a0,s1
    16d8:	00004097          	auipc	ra,0x4
    16dc:	53e080e7          	jalr	1342(ra) # 5c16 <close>
  for(int i = 0; i < 150; i++){
    16e0:	39fd                	addiw	s3,s3,-1
    16e2:	fc0997e3          	bnez	s3,16b0 <truncate3+0x122>
  wait(&xstatus);
    16e6:	fbc40513          	addi	a0,s0,-68
    16ea:	00004097          	auipc	ra,0x4
    16ee:	50c080e7          	jalr	1292(ra) # 5bf6 <wait>
  unlink("truncfile");
    16f2:	00005517          	auipc	a0,0x5
    16f6:	aae50513          	addi	a0,a0,-1362 # 61a0 <malloc+0x180>
    16fa:	00004097          	auipc	ra,0x4
    16fe:	544080e7          	jalr	1348(ra) # 5c3e <unlink>
  exit(xstatus);
    1702:	fbc42503          	lw	a0,-68(s0)
    1706:	00004097          	auipc	ra,0x4
    170a:	4e8080e7          	jalr	1256(ra) # 5bee <exit>
      printf("%s: open failed\n", s);
    170e:	85ca                	mv	a1,s2
    1710:	00005517          	auipc	a0,0x5
    1714:	2d850513          	addi	a0,a0,728 # 69e8 <malloc+0x9c8>
    1718:	00005097          	auipc	ra,0x5
    171c:	850080e7          	jalr	-1968(ra) # 5f68 <printf>
      exit(1);
    1720:	4505                	li	a0,1
    1722:	00004097          	auipc	ra,0x4
    1726:	4cc080e7          	jalr	1228(ra) # 5bee <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    172a:	862a                	mv	a2,a0
    172c:	85ca                	mv	a1,s2
    172e:	00005517          	auipc	a0,0x5
    1732:	30a50513          	addi	a0,a0,778 # 6a38 <malloc+0xa18>
    1736:	00005097          	auipc	ra,0x5
    173a:	832080e7          	jalr	-1998(ra) # 5f68 <printf>
      exit(1);
    173e:	4505                	li	a0,1
    1740:	00004097          	auipc	ra,0x4
    1744:	4ae080e7          	jalr	1198(ra) # 5bee <exit>

0000000000001748 <exectest>:
{
    1748:	715d                	addi	sp,sp,-80
    174a:	e486                	sd	ra,72(sp)
    174c:	e0a2                	sd	s0,64(sp)
    174e:	fc26                	sd	s1,56(sp)
    1750:	f84a                	sd	s2,48(sp)
    1752:	0880                	addi	s0,sp,80
    1754:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1756:	00005797          	auipc	a5,0x5
    175a:	9f278793          	addi	a5,a5,-1550 # 6148 <malloc+0x128>
    175e:	fcf43023          	sd	a5,-64(s0)
    1762:	00005797          	auipc	a5,0x5
    1766:	2f678793          	addi	a5,a5,758 # 6a58 <malloc+0xa38>
    176a:	fcf43423          	sd	a5,-56(s0)
    176e:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1772:	00005517          	auipc	a0,0x5
    1776:	2ee50513          	addi	a0,a0,750 # 6a60 <malloc+0xa40>
    177a:	00004097          	auipc	ra,0x4
    177e:	4c4080e7          	jalr	1220(ra) # 5c3e <unlink>
  pid = fork();
    1782:	00004097          	auipc	ra,0x4
    1786:	464080e7          	jalr	1124(ra) # 5be6 <fork>
  if(pid < 0) {
    178a:	04054663          	bltz	a0,17d6 <exectest+0x8e>
    178e:	84aa                	mv	s1,a0
  if(pid == 0) {
    1790:	e959                	bnez	a0,1826 <exectest+0xde>
    close(1);
    1792:	4505                	li	a0,1
    1794:	00004097          	auipc	ra,0x4
    1798:	482080e7          	jalr	1154(ra) # 5c16 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    179c:	20100593          	li	a1,513
    17a0:	00005517          	auipc	a0,0x5
    17a4:	2c050513          	addi	a0,a0,704 # 6a60 <malloc+0xa40>
    17a8:	00004097          	auipc	ra,0x4
    17ac:	486080e7          	jalr	1158(ra) # 5c2e <open>
    if(fd < 0) {
    17b0:	04054163          	bltz	a0,17f2 <exectest+0xaa>
    if(fd != 1) {
    17b4:	4785                	li	a5,1
    17b6:	04f50c63          	beq	a0,a5,180e <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17ba:	85ca                	mv	a1,s2
    17bc:	00005517          	auipc	a0,0x5
    17c0:	2c450513          	addi	a0,a0,708 # 6a80 <malloc+0xa60>
    17c4:	00004097          	auipc	ra,0x4
    17c8:	7a4080e7          	jalr	1956(ra) # 5f68 <printf>
      exit(1);
    17cc:	4505                	li	a0,1
    17ce:	00004097          	auipc	ra,0x4
    17d2:	420080e7          	jalr	1056(ra) # 5bee <exit>
     printf("%s: fork failed\n", s);
    17d6:	85ca                	mv	a1,s2
    17d8:	00005517          	auipc	a0,0x5
    17dc:	1f850513          	addi	a0,a0,504 # 69d0 <malloc+0x9b0>
    17e0:	00004097          	auipc	ra,0x4
    17e4:	788080e7          	jalr	1928(ra) # 5f68 <printf>
     exit(1);
    17e8:	4505                	li	a0,1
    17ea:	00004097          	auipc	ra,0x4
    17ee:	404080e7          	jalr	1028(ra) # 5bee <exit>
      printf("%s: create failed\n", s);
    17f2:	85ca                	mv	a1,s2
    17f4:	00005517          	auipc	a0,0x5
    17f8:	27450513          	addi	a0,a0,628 # 6a68 <malloc+0xa48>
    17fc:	00004097          	auipc	ra,0x4
    1800:	76c080e7          	jalr	1900(ra) # 5f68 <printf>
      exit(1);
    1804:	4505                	li	a0,1
    1806:	00004097          	auipc	ra,0x4
    180a:	3e8080e7          	jalr	1000(ra) # 5bee <exit>
    if(exec("echo", echoargv) < 0){
    180e:	fc040593          	addi	a1,s0,-64
    1812:	00005517          	auipc	a0,0x5
    1816:	93650513          	addi	a0,a0,-1738 # 6148 <malloc+0x128>
    181a:	00004097          	auipc	ra,0x4
    181e:	40c080e7          	jalr	1036(ra) # 5c26 <exec>
    1822:	02054163          	bltz	a0,1844 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1826:	fdc40513          	addi	a0,s0,-36
    182a:	00004097          	auipc	ra,0x4
    182e:	3cc080e7          	jalr	972(ra) # 5bf6 <wait>
    1832:	02951763          	bne	a0,s1,1860 <exectest+0x118>
  if(xstatus != 0)
    1836:	fdc42503          	lw	a0,-36(s0)
    183a:	cd0d                	beqz	a0,1874 <exectest+0x12c>
    exit(xstatus);
    183c:	00004097          	auipc	ra,0x4
    1840:	3b2080e7          	jalr	946(ra) # 5bee <exit>
      printf("%s: exec echo failed\n", s);
    1844:	85ca                	mv	a1,s2
    1846:	00005517          	auipc	a0,0x5
    184a:	24a50513          	addi	a0,a0,586 # 6a90 <malloc+0xa70>
    184e:	00004097          	auipc	ra,0x4
    1852:	71a080e7          	jalr	1818(ra) # 5f68 <printf>
      exit(1);
    1856:	4505                	li	a0,1
    1858:	00004097          	auipc	ra,0x4
    185c:	396080e7          	jalr	918(ra) # 5bee <exit>
    printf("%s: wait failed!\n", s);
    1860:	85ca                	mv	a1,s2
    1862:	00005517          	auipc	a0,0x5
    1866:	24650513          	addi	a0,a0,582 # 6aa8 <malloc+0xa88>
    186a:	00004097          	auipc	ra,0x4
    186e:	6fe080e7          	jalr	1790(ra) # 5f68 <printf>
    1872:	b7d1                	j	1836 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1874:	4581                	li	a1,0
    1876:	00005517          	auipc	a0,0x5
    187a:	1ea50513          	addi	a0,a0,490 # 6a60 <malloc+0xa40>
    187e:	00004097          	auipc	ra,0x4
    1882:	3b0080e7          	jalr	944(ra) # 5c2e <open>
  if(fd < 0) {
    1886:	02054a63          	bltz	a0,18ba <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    188a:	4609                	li	a2,2
    188c:	fb840593          	addi	a1,s0,-72
    1890:	00004097          	auipc	ra,0x4
    1894:	376080e7          	jalr	886(ra) # 5c06 <read>
    1898:	4789                	li	a5,2
    189a:	02f50e63          	beq	a0,a5,18d6 <exectest+0x18e>
    printf("%s: read failed\n", s);
    189e:	85ca                	mv	a1,s2
    18a0:	00005517          	auipc	a0,0x5
    18a4:	c7850513          	addi	a0,a0,-904 # 6518 <malloc+0x4f8>
    18a8:	00004097          	auipc	ra,0x4
    18ac:	6c0080e7          	jalr	1728(ra) # 5f68 <printf>
    exit(1);
    18b0:	4505                	li	a0,1
    18b2:	00004097          	auipc	ra,0x4
    18b6:	33c080e7          	jalr	828(ra) # 5bee <exit>
    printf("%s: open failed\n", s);
    18ba:	85ca                	mv	a1,s2
    18bc:	00005517          	auipc	a0,0x5
    18c0:	12c50513          	addi	a0,a0,300 # 69e8 <malloc+0x9c8>
    18c4:	00004097          	auipc	ra,0x4
    18c8:	6a4080e7          	jalr	1700(ra) # 5f68 <printf>
    exit(1);
    18cc:	4505                	li	a0,1
    18ce:	00004097          	auipc	ra,0x4
    18d2:	320080e7          	jalr	800(ra) # 5bee <exit>
  unlink("echo-ok");
    18d6:	00005517          	auipc	a0,0x5
    18da:	18a50513          	addi	a0,a0,394 # 6a60 <malloc+0xa40>
    18de:	00004097          	auipc	ra,0x4
    18e2:	360080e7          	jalr	864(ra) # 5c3e <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18e6:	fb844703          	lbu	a4,-72(s0)
    18ea:	04f00793          	li	a5,79
    18ee:	00f71863          	bne	a4,a5,18fe <exectest+0x1b6>
    18f2:	fb944703          	lbu	a4,-71(s0)
    18f6:	04b00793          	li	a5,75
    18fa:	02f70063          	beq	a4,a5,191a <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18fe:	85ca                	mv	a1,s2
    1900:	00005517          	auipc	a0,0x5
    1904:	1c050513          	addi	a0,a0,448 # 6ac0 <malloc+0xaa0>
    1908:	00004097          	auipc	ra,0x4
    190c:	660080e7          	jalr	1632(ra) # 5f68 <printf>
    exit(1);
    1910:	4505                	li	a0,1
    1912:	00004097          	auipc	ra,0x4
    1916:	2dc080e7          	jalr	732(ra) # 5bee <exit>
    exit(0);
    191a:	4501                	li	a0,0
    191c:	00004097          	auipc	ra,0x4
    1920:	2d2080e7          	jalr	722(ra) # 5bee <exit>

0000000000001924 <pipe1>:
{
    1924:	711d                	addi	sp,sp,-96
    1926:	ec86                	sd	ra,88(sp)
    1928:	e8a2                	sd	s0,80(sp)
    192a:	e4a6                	sd	s1,72(sp)
    192c:	e0ca                	sd	s2,64(sp)
    192e:	fc4e                	sd	s3,56(sp)
    1930:	f852                	sd	s4,48(sp)
    1932:	f456                	sd	s5,40(sp)
    1934:	f05a                	sd	s6,32(sp)
    1936:	ec5e                	sd	s7,24(sp)
    1938:	1080                	addi	s0,sp,96
    193a:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    193c:	fa840513          	addi	a0,s0,-88
    1940:	00004097          	auipc	ra,0x4
    1944:	2be080e7          	jalr	702(ra) # 5bfe <pipe>
    1948:	e93d                	bnez	a0,19be <pipe1+0x9a>
    194a:	84aa                	mv	s1,a0
  pid = fork();
    194c:	00004097          	auipc	ra,0x4
    1950:	29a080e7          	jalr	666(ra) # 5be6 <fork>
    1954:	8a2a                	mv	s4,a0
  if(pid == 0){
    1956:	c151                	beqz	a0,19da <pipe1+0xb6>
  } else if(pid > 0){
    1958:	16a05d63          	blez	a0,1ad2 <pipe1+0x1ae>
    close(fds[1]);
    195c:	fac42503          	lw	a0,-84(s0)
    1960:	00004097          	auipc	ra,0x4
    1964:	2b6080e7          	jalr	694(ra) # 5c16 <close>
    total = 0;
    1968:	8a26                	mv	s4,s1
    cc = 1;
    196a:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    196c:	0000ba97          	auipc	s5,0xb
    1970:	30ca8a93          	addi	s5,s5,780 # cc78 <buf>
      if(cc > sizeof(buf))
    1974:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1976:	864e                	mv	a2,s3
    1978:	85d6                	mv	a1,s5
    197a:	fa842503          	lw	a0,-88(s0)
    197e:	00004097          	auipc	ra,0x4
    1982:	288080e7          	jalr	648(ra) # 5c06 <read>
    1986:	10a05163          	blez	a0,1a88 <pipe1+0x164>
      for(i = 0; i < n; i++){
    198a:	0000b717          	auipc	a4,0xb
    198e:	2ee70713          	addi	a4,a4,750 # cc78 <buf>
    1992:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1996:	00074683          	lbu	a3,0(a4)
    199a:	0ff4f793          	zext.b	a5,s1
    199e:	2485                	addiw	s1,s1,1
    19a0:	0cf69063          	bne	a3,a5,1a60 <pipe1+0x13c>
      for(i = 0; i < n; i++){
    19a4:	0705                	addi	a4,a4,1
    19a6:	fec498e3          	bne	s1,a2,1996 <pipe1+0x72>
      total += n;
    19aa:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19ae:	0019979b          	slliw	a5,s3,0x1
    19b2:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19b6:	fd3b70e3          	bgeu	s6,s3,1976 <pipe1+0x52>
        cc = sizeof(buf);
    19ba:	89da                	mv	s3,s6
    19bc:	bf6d                	j	1976 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    19be:	85ca                	mv	a1,s2
    19c0:	00005517          	auipc	a0,0x5
    19c4:	11850513          	addi	a0,a0,280 # 6ad8 <malloc+0xab8>
    19c8:	00004097          	auipc	ra,0x4
    19cc:	5a0080e7          	jalr	1440(ra) # 5f68 <printf>
    exit(1);
    19d0:	4505                	li	a0,1
    19d2:	00004097          	auipc	ra,0x4
    19d6:	21c080e7          	jalr	540(ra) # 5bee <exit>
    close(fds[0]);
    19da:	fa842503          	lw	a0,-88(s0)
    19de:	00004097          	auipc	ra,0x4
    19e2:	238080e7          	jalr	568(ra) # 5c16 <close>
    for(n = 0; n < N; n++){
    19e6:	0000bb17          	auipc	s6,0xb
    19ea:	292b0b13          	addi	s6,s6,658 # cc78 <buf>
    19ee:	416004bb          	negw	s1,s6
    19f2:	0ff4f493          	zext.b	s1,s1
    19f6:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19fa:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19fc:	6a85                	lui	s5,0x1
    19fe:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x95>
{
    1a02:	87da                	mv	a5,s6
        buf[i] = seq++;
    1a04:	0097873b          	addw	a4,a5,s1
    1a08:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a0c:	0785                	addi	a5,a5,1
    1a0e:	fef99be3          	bne	s3,a5,1a04 <pipe1+0xe0>
        buf[i] = seq++;
    1a12:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a16:	40900613          	li	a2,1033
    1a1a:	85de                	mv	a1,s7
    1a1c:	fac42503          	lw	a0,-84(s0)
    1a20:	00004097          	auipc	ra,0x4
    1a24:	1ee080e7          	jalr	494(ra) # 5c0e <write>
    1a28:	40900793          	li	a5,1033
    1a2c:	00f51c63          	bne	a0,a5,1a44 <pipe1+0x120>
    for(n = 0; n < N; n++){
    1a30:	24a5                	addiw	s1,s1,9
    1a32:	0ff4f493          	zext.b	s1,s1
    1a36:	fd5a16e3          	bne	s4,s5,1a02 <pipe1+0xde>
    exit(0);
    1a3a:	4501                	li	a0,0
    1a3c:	00004097          	auipc	ra,0x4
    1a40:	1b2080e7          	jalr	434(ra) # 5bee <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a44:	85ca                	mv	a1,s2
    1a46:	00005517          	auipc	a0,0x5
    1a4a:	0aa50513          	addi	a0,a0,170 # 6af0 <malloc+0xad0>
    1a4e:	00004097          	auipc	ra,0x4
    1a52:	51a080e7          	jalr	1306(ra) # 5f68 <printf>
        exit(1);
    1a56:	4505                	li	a0,1
    1a58:	00004097          	auipc	ra,0x4
    1a5c:	196080e7          	jalr	406(ra) # 5bee <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a60:	85ca                	mv	a1,s2
    1a62:	00005517          	auipc	a0,0x5
    1a66:	0a650513          	addi	a0,a0,166 # 6b08 <malloc+0xae8>
    1a6a:	00004097          	auipc	ra,0x4
    1a6e:	4fe080e7          	jalr	1278(ra) # 5f68 <printf>
}
    1a72:	60e6                	ld	ra,88(sp)
    1a74:	6446                	ld	s0,80(sp)
    1a76:	64a6                	ld	s1,72(sp)
    1a78:	6906                	ld	s2,64(sp)
    1a7a:	79e2                	ld	s3,56(sp)
    1a7c:	7a42                	ld	s4,48(sp)
    1a7e:	7aa2                	ld	s5,40(sp)
    1a80:	7b02                	ld	s6,32(sp)
    1a82:	6be2                	ld	s7,24(sp)
    1a84:	6125                	addi	sp,sp,96
    1a86:	8082                	ret
    if(total != N * SZ){
    1a88:	6785                	lui	a5,0x1
    1a8a:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x95>
    1a8e:	02fa0063          	beq	s4,a5,1aae <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a92:	85d2                	mv	a1,s4
    1a94:	00005517          	auipc	a0,0x5
    1a98:	08c50513          	addi	a0,a0,140 # 6b20 <malloc+0xb00>
    1a9c:	00004097          	auipc	ra,0x4
    1aa0:	4cc080e7          	jalr	1228(ra) # 5f68 <printf>
      exit(1);
    1aa4:	4505                	li	a0,1
    1aa6:	00004097          	auipc	ra,0x4
    1aaa:	148080e7          	jalr	328(ra) # 5bee <exit>
    close(fds[0]);
    1aae:	fa842503          	lw	a0,-88(s0)
    1ab2:	00004097          	auipc	ra,0x4
    1ab6:	164080e7          	jalr	356(ra) # 5c16 <close>
    wait(&xstatus);
    1aba:	fa440513          	addi	a0,s0,-92
    1abe:	00004097          	auipc	ra,0x4
    1ac2:	138080e7          	jalr	312(ra) # 5bf6 <wait>
    exit(xstatus);
    1ac6:	fa442503          	lw	a0,-92(s0)
    1aca:	00004097          	auipc	ra,0x4
    1ace:	124080e7          	jalr	292(ra) # 5bee <exit>
    printf("%s: fork() failed\n", s);
    1ad2:	85ca                	mv	a1,s2
    1ad4:	00005517          	auipc	a0,0x5
    1ad8:	06c50513          	addi	a0,a0,108 # 6b40 <malloc+0xb20>
    1adc:	00004097          	auipc	ra,0x4
    1ae0:	48c080e7          	jalr	1164(ra) # 5f68 <printf>
    exit(1);
    1ae4:	4505                	li	a0,1
    1ae6:	00004097          	auipc	ra,0x4
    1aea:	108080e7          	jalr	264(ra) # 5bee <exit>

0000000000001aee <exitwait>:
{
    1aee:	7139                	addi	sp,sp,-64
    1af0:	fc06                	sd	ra,56(sp)
    1af2:	f822                	sd	s0,48(sp)
    1af4:	f426                	sd	s1,40(sp)
    1af6:	f04a                	sd	s2,32(sp)
    1af8:	ec4e                	sd	s3,24(sp)
    1afa:	e852                	sd	s4,16(sp)
    1afc:	0080                	addi	s0,sp,64
    1afe:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1b00:	4901                	li	s2,0
    1b02:	06400993          	li	s3,100
    pid = fork();
    1b06:	00004097          	auipc	ra,0x4
    1b0a:	0e0080e7          	jalr	224(ra) # 5be6 <fork>
    1b0e:	84aa                	mv	s1,a0
    if(pid < 0){
    1b10:	02054a63          	bltz	a0,1b44 <exitwait+0x56>
    if(pid){
    1b14:	c151                	beqz	a0,1b98 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b16:	fcc40513          	addi	a0,s0,-52
    1b1a:	00004097          	auipc	ra,0x4
    1b1e:	0dc080e7          	jalr	220(ra) # 5bf6 <wait>
    1b22:	02951f63          	bne	a0,s1,1b60 <exitwait+0x72>
      if(i != xstate) {
    1b26:	fcc42783          	lw	a5,-52(s0)
    1b2a:	05279963          	bne	a5,s2,1b7c <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b2e:	2905                	addiw	s2,s2,1
    1b30:	fd391be3          	bne	s2,s3,1b06 <exitwait+0x18>
}
    1b34:	70e2                	ld	ra,56(sp)
    1b36:	7442                	ld	s0,48(sp)
    1b38:	74a2                	ld	s1,40(sp)
    1b3a:	7902                	ld	s2,32(sp)
    1b3c:	69e2                	ld	s3,24(sp)
    1b3e:	6a42                	ld	s4,16(sp)
    1b40:	6121                	addi	sp,sp,64
    1b42:	8082                	ret
      printf("%s: fork failed\n", s);
    1b44:	85d2                	mv	a1,s4
    1b46:	00005517          	auipc	a0,0x5
    1b4a:	e8a50513          	addi	a0,a0,-374 # 69d0 <malloc+0x9b0>
    1b4e:	00004097          	auipc	ra,0x4
    1b52:	41a080e7          	jalr	1050(ra) # 5f68 <printf>
      exit(1);
    1b56:	4505                	li	a0,1
    1b58:	00004097          	auipc	ra,0x4
    1b5c:	096080e7          	jalr	150(ra) # 5bee <exit>
        printf("%s: wait wrong pid\n", s);
    1b60:	85d2                	mv	a1,s4
    1b62:	00005517          	auipc	a0,0x5
    1b66:	ff650513          	addi	a0,a0,-10 # 6b58 <malloc+0xb38>
    1b6a:	00004097          	auipc	ra,0x4
    1b6e:	3fe080e7          	jalr	1022(ra) # 5f68 <printf>
        exit(1);
    1b72:	4505                	li	a0,1
    1b74:	00004097          	auipc	ra,0x4
    1b78:	07a080e7          	jalr	122(ra) # 5bee <exit>
        printf("%s: wait wrong exit status\n", s);
    1b7c:	85d2                	mv	a1,s4
    1b7e:	00005517          	auipc	a0,0x5
    1b82:	ff250513          	addi	a0,a0,-14 # 6b70 <malloc+0xb50>
    1b86:	00004097          	auipc	ra,0x4
    1b8a:	3e2080e7          	jalr	994(ra) # 5f68 <printf>
        exit(1);
    1b8e:	4505                	li	a0,1
    1b90:	00004097          	auipc	ra,0x4
    1b94:	05e080e7          	jalr	94(ra) # 5bee <exit>
      exit(i);
    1b98:	854a                	mv	a0,s2
    1b9a:	00004097          	auipc	ra,0x4
    1b9e:	054080e7          	jalr	84(ra) # 5bee <exit>

0000000000001ba2 <twochildren>:
{
    1ba2:	1101                	addi	sp,sp,-32
    1ba4:	ec06                	sd	ra,24(sp)
    1ba6:	e822                	sd	s0,16(sp)
    1ba8:	e426                	sd	s1,8(sp)
    1baa:	e04a                	sd	s2,0(sp)
    1bac:	1000                	addi	s0,sp,32
    1bae:	892a                	mv	s2,a0
    1bb0:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bb4:	00004097          	auipc	ra,0x4
    1bb8:	032080e7          	jalr	50(ra) # 5be6 <fork>
    if(pid1 < 0){
    1bbc:	02054c63          	bltz	a0,1bf4 <twochildren+0x52>
    if(pid1 == 0){
    1bc0:	c921                	beqz	a0,1c10 <twochildren+0x6e>
      int pid2 = fork();
    1bc2:	00004097          	auipc	ra,0x4
    1bc6:	024080e7          	jalr	36(ra) # 5be6 <fork>
      if(pid2 < 0){
    1bca:	04054763          	bltz	a0,1c18 <twochildren+0x76>
      if(pid2 == 0){
    1bce:	c13d                	beqz	a0,1c34 <twochildren+0x92>
        wait(0);
    1bd0:	4501                	li	a0,0
    1bd2:	00004097          	auipc	ra,0x4
    1bd6:	024080e7          	jalr	36(ra) # 5bf6 <wait>
        wait(0);
    1bda:	4501                	li	a0,0
    1bdc:	00004097          	auipc	ra,0x4
    1be0:	01a080e7          	jalr	26(ra) # 5bf6 <wait>
  for(int i = 0; i < 1000; i++){
    1be4:	34fd                	addiw	s1,s1,-1
    1be6:	f4f9                	bnez	s1,1bb4 <twochildren+0x12>
}
    1be8:	60e2                	ld	ra,24(sp)
    1bea:	6442                	ld	s0,16(sp)
    1bec:	64a2                	ld	s1,8(sp)
    1bee:	6902                	ld	s2,0(sp)
    1bf0:	6105                	addi	sp,sp,32
    1bf2:	8082                	ret
      printf("%s: fork failed\n", s);
    1bf4:	85ca                	mv	a1,s2
    1bf6:	00005517          	auipc	a0,0x5
    1bfa:	dda50513          	addi	a0,a0,-550 # 69d0 <malloc+0x9b0>
    1bfe:	00004097          	auipc	ra,0x4
    1c02:	36a080e7          	jalr	874(ra) # 5f68 <printf>
      exit(1);
    1c06:	4505                	li	a0,1
    1c08:	00004097          	auipc	ra,0x4
    1c0c:	fe6080e7          	jalr	-26(ra) # 5bee <exit>
      exit(0);
    1c10:	00004097          	auipc	ra,0x4
    1c14:	fde080e7          	jalr	-34(ra) # 5bee <exit>
        printf("%s: fork failed\n", s);
    1c18:	85ca                	mv	a1,s2
    1c1a:	00005517          	auipc	a0,0x5
    1c1e:	db650513          	addi	a0,a0,-586 # 69d0 <malloc+0x9b0>
    1c22:	00004097          	auipc	ra,0x4
    1c26:	346080e7          	jalr	838(ra) # 5f68 <printf>
        exit(1);
    1c2a:	4505                	li	a0,1
    1c2c:	00004097          	auipc	ra,0x4
    1c30:	fc2080e7          	jalr	-62(ra) # 5bee <exit>
        exit(0);
    1c34:	00004097          	auipc	ra,0x4
    1c38:	fba080e7          	jalr	-70(ra) # 5bee <exit>

0000000000001c3c <forkfork>:
{
    1c3c:	7179                	addi	sp,sp,-48
    1c3e:	f406                	sd	ra,40(sp)
    1c40:	f022                	sd	s0,32(sp)
    1c42:	ec26                	sd	s1,24(sp)
    1c44:	1800                	addi	s0,sp,48
    1c46:	84aa                	mv	s1,a0
    int pid = fork();
    1c48:	00004097          	auipc	ra,0x4
    1c4c:	f9e080e7          	jalr	-98(ra) # 5be6 <fork>
    if(pid < 0){
    1c50:	04054163          	bltz	a0,1c92 <forkfork+0x56>
    if(pid == 0){
    1c54:	cd29                	beqz	a0,1cae <forkfork+0x72>
    int pid = fork();
    1c56:	00004097          	auipc	ra,0x4
    1c5a:	f90080e7          	jalr	-112(ra) # 5be6 <fork>
    if(pid < 0){
    1c5e:	02054a63          	bltz	a0,1c92 <forkfork+0x56>
    if(pid == 0){
    1c62:	c531                	beqz	a0,1cae <forkfork+0x72>
    wait(&xstatus);
    1c64:	fdc40513          	addi	a0,s0,-36
    1c68:	00004097          	auipc	ra,0x4
    1c6c:	f8e080e7          	jalr	-114(ra) # 5bf6 <wait>
    if(xstatus != 0) {
    1c70:	fdc42783          	lw	a5,-36(s0)
    1c74:	ebbd                	bnez	a5,1cea <forkfork+0xae>
    wait(&xstatus);
    1c76:	fdc40513          	addi	a0,s0,-36
    1c7a:	00004097          	auipc	ra,0x4
    1c7e:	f7c080e7          	jalr	-132(ra) # 5bf6 <wait>
    if(xstatus != 0) {
    1c82:	fdc42783          	lw	a5,-36(s0)
    1c86:	e3b5                	bnez	a5,1cea <forkfork+0xae>
}
    1c88:	70a2                	ld	ra,40(sp)
    1c8a:	7402                	ld	s0,32(sp)
    1c8c:	64e2                	ld	s1,24(sp)
    1c8e:	6145                	addi	sp,sp,48
    1c90:	8082                	ret
      printf("%s: fork failed", s);
    1c92:	85a6                	mv	a1,s1
    1c94:	00005517          	auipc	a0,0x5
    1c98:	efc50513          	addi	a0,a0,-260 # 6b90 <malloc+0xb70>
    1c9c:	00004097          	auipc	ra,0x4
    1ca0:	2cc080e7          	jalr	716(ra) # 5f68 <printf>
      exit(1);
    1ca4:	4505                	li	a0,1
    1ca6:	00004097          	auipc	ra,0x4
    1caa:	f48080e7          	jalr	-184(ra) # 5bee <exit>
{
    1cae:	0c800493          	li	s1,200
        int pid1 = fork();
    1cb2:	00004097          	auipc	ra,0x4
    1cb6:	f34080e7          	jalr	-204(ra) # 5be6 <fork>
        if(pid1 < 0){
    1cba:	00054f63          	bltz	a0,1cd8 <forkfork+0x9c>
        if(pid1 == 0){
    1cbe:	c115                	beqz	a0,1ce2 <forkfork+0xa6>
        wait(0);
    1cc0:	4501                	li	a0,0
    1cc2:	00004097          	auipc	ra,0x4
    1cc6:	f34080e7          	jalr	-204(ra) # 5bf6 <wait>
      for(int j = 0; j < 200; j++){
    1cca:	34fd                	addiw	s1,s1,-1
    1ccc:	f0fd                	bnez	s1,1cb2 <forkfork+0x76>
      exit(0);
    1cce:	4501                	li	a0,0
    1cd0:	00004097          	auipc	ra,0x4
    1cd4:	f1e080e7          	jalr	-226(ra) # 5bee <exit>
          exit(1);
    1cd8:	4505                	li	a0,1
    1cda:	00004097          	auipc	ra,0x4
    1cde:	f14080e7          	jalr	-236(ra) # 5bee <exit>
          exit(0);
    1ce2:	00004097          	auipc	ra,0x4
    1ce6:	f0c080e7          	jalr	-244(ra) # 5bee <exit>
      printf("%s: fork in child failed", s);
    1cea:	85a6                	mv	a1,s1
    1cec:	00005517          	auipc	a0,0x5
    1cf0:	eb450513          	addi	a0,a0,-332 # 6ba0 <malloc+0xb80>
    1cf4:	00004097          	auipc	ra,0x4
    1cf8:	274080e7          	jalr	628(ra) # 5f68 <printf>
      exit(1);
    1cfc:	4505                	li	a0,1
    1cfe:	00004097          	auipc	ra,0x4
    1d02:	ef0080e7          	jalr	-272(ra) # 5bee <exit>

0000000000001d06 <reparent2>:
{
    1d06:	1101                	addi	sp,sp,-32
    1d08:	ec06                	sd	ra,24(sp)
    1d0a:	e822                	sd	s0,16(sp)
    1d0c:	e426                	sd	s1,8(sp)
    1d0e:	1000                	addi	s0,sp,32
    1d10:	32000493          	li	s1,800
    int pid1 = fork();
    1d14:	00004097          	auipc	ra,0x4
    1d18:	ed2080e7          	jalr	-302(ra) # 5be6 <fork>
    if(pid1 < 0){
    1d1c:	00054f63          	bltz	a0,1d3a <reparent2+0x34>
    if(pid1 == 0){
    1d20:	c915                	beqz	a0,1d54 <reparent2+0x4e>
    wait(0);
    1d22:	4501                	li	a0,0
    1d24:	00004097          	auipc	ra,0x4
    1d28:	ed2080e7          	jalr	-302(ra) # 5bf6 <wait>
  for(int i = 0; i < 800; i++){
    1d2c:	34fd                	addiw	s1,s1,-1
    1d2e:	f0fd                	bnez	s1,1d14 <reparent2+0xe>
  exit(0);
    1d30:	4501                	li	a0,0
    1d32:	00004097          	auipc	ra,0x4
    1d36:	ebc080e7          	jalr	-324(ra) # 5bee <exit>
      printf("fork failed\n");
    1d3a:	00005517          	auipc	a0,0x5
    1d3e:	09e50513          	addi	a0,a0,158 # 6dd8 <malloc+0xdb8>
    1d42:	00004097          	auipc	ra,0x4
    1d46:	226080e7          	jalr	550(ra) # 5f68 <printf>
      exit(1);
    1d4a:	4505                	li	a0,1
    1d4c:	00004097          	auipc	ra,0x4
    1d50:	ea2080e7          	jalr	-350(ra) # 5bee <exit>
      fork();
    1d54:	00004097          	auipc	ra,0x4
    1d58:	e92080e7          	jalr	-366(ra) # 5be6 <fork>
      fork();
    1d5c:	00004097          	auipc	ra,0x4
    1d60:	e8a080e7          	jalr	-374(ra) # 5be6 <fork>
      exit(0);
    1d64:	4501                	li	a0,0
    1d66:	00004097          	auipc	ra,0x4
    1d6a:	e88080e7          	jalr	-376(ra) # 5bee <exit>

0000000000001d6e <createdelete>:
{
    1d6e:	7175                	addi	sp,sp,-144
    1d70:	e506                	sd	ra,136(sp)
    1d72:	e122                	sd	s0,128(sp)
    1d74:	fca6                	sd	s1,120(sp)
    1d76:	f8ca                	sd	s2,112(sp)
    1d78:	f4ce                	sd	s3,104(sp)
    1d7a:	f0d2                	sd	s4,96(sp)
    1d7c:	ecd6                	sd	s5,88(sp)
    1d7e:	e8da                	sd	s6,80(sp)
    1d80:	e4de                	sd	s7,72(sp)
    1d82:	e0e2                	sd	s8,64(sp)
    1d84:	fc66                	sd	s9,56(sp)
    1d86:	0900                	addi	s0,sp,144
    1d88:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d8a:	4901                	li	s2,0
    1d8c:	4991                	li	s3,4
    pid = fork();
    1d8e:	00004097          	auipc	ra,0x4
    1d92:	e58080e7          	jalr	-424(ra) # 5be6 <fork>
    1d96:	84aa                	mv	s1,a0
    if(pid < 0){
    1d98:	02054f63          	bltz	a0,1dd6 <createdelete+0x68>
    if(pid == 0){
    1d9c:	c939                	beqz	a0,1df2 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d9e:	2905                	addiw	s2,s2,1
    1da0:	ff3917e3          	bne	s2,s3,1d8e <createdelete+0x20>
    1da4:	4491                	li	s1,4
    wait(&xstatus);
    1da6:	f7c40513          	addi	a0,s0,-132
    1daa:	00004097          	auipc	ra,0x4
    1dae:	e4c080e7          	jalr	-436(ra) # 5bf6 <wait>
    if(xstatus != 0)
    1db2:	f7c42903          	lw	s2,-132(s0)
    1db6:	0e091263          	bnez	s2,1e9a <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1dba:	34fd                	addiw	s1,s1,-1
    1dbc:	f4ed                	bnez	s1,1da6 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1dbe:	f8040123          	sb	zero,-126(s0)
    1dc2:	03000993          	li	s3,48
    1dc6:	5a7d                	li	s4,-1
    1dc8:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dcc:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dce:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dd0:	07400a93          	li	s5,116
    1dd4:	a29d                	j	1f3a <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dd6:	85e6                	mv	a1,s9
    1dd8:	00005517          	auipc	a0,0x5
    1ddc:	00050513          	mv	a0,a0
    1de0:	00004097          	auipc	ra,0x4
    1de4:	188080e7          	jalr	392(ra) # 5f68 <printf>
      exit(1);
    1de8:	4505                	li	a0,1
    1dea:	00004097          	auipc	ra,0x4
    1dee:	e04080e7          	jalr	-508(ra) # 5bee <exit>
      name[0] = 'p' + pi;
    1df2:	0709091b          	addiw	s2,s2,112
    1df6:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1dfa:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1dfe:	4951                	li	s2,20
    1e00:	a015                	j	1e24 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1e02:	85e6                	mv	a1,s9
    1e04:	00005517          	auipc	a0,0x5
    1e08:	c6450513          	addi	a0,a0,-924 # 6a68 <malloc+0xa48>
    1e0c:	00004097          	auipc	ra,0x4
    1e10:	15c080e7          	jalr	348(ra) # 5f68 <printf>
          exit(1);
    1e14:	4505                	li	a0,1
    1e16:	00004097          	auipc	ra,0x4
    1e1a:	dd8080e7          	jalr	-552(ra) # 5bee <exit>
      for(i = 0; i < N; i++){
    1e1e:	2485                	addiw	s1,s1,1
    1e20:	07248863          	beq	s1,s2,1e90 <createdelete+0x122>
        name[1] = '0' + i;
    1e24:	0304879b          	addiw	a5,s1,48
    1e28:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e2c:	20200593          	li	a1,514
    1e30:	f8040513          	addi	a0,s0,-128
    1e34:	00004097          	auipc	ra,0x4
    1e38:	dfa080e7          	jalr	-518(ra) # 5c2e <open>
        if(fd < 0){
    1e3c:	fc0543e3          	bltz	a0,1e02 <createdelete+0x94>
        close(fd);
    1e40:	00004097          	auipc	ra,0x4
    1e44:	dd6080e7          	jalr	-554(ra) # 5c16 <close>
        if(i > 0 && (i % 2 ) == 0){
    1e48:	fc905be3          	blez	s1,1e1e <createdelete+0xb0>
    1e4c:	0014f793          	andi	a5,s1,1
    1e50:	f7f9                	bnez	a5,1e1e <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e52:	01f4d79b          	srliw	a5,s1,0x1f
    1e56:	9fa5                	addw	a5,a5,s1
    1e58:	4017d79b          	sraiw	a5,a5,0x1
    1e5c:	0307879b          	addiw	a5,a5,48
    1e60:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e64:	f8040513          	addi	a0,s0,-128
    1e68:	00004097          	auipc	ra,0x4
    1e6c:	dd6080e7          	jalr	-554(ra) # 5c3e <unlink>
    1e70:	fa0557e3          	bgez	a0,1e1e <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e74:	85e6                	mv	a1,s9
    1e76:	00005517          	auipc	a0,0x5
    1e7a:	d4a50513          	addi	a0,a0,-694 # 6bc0 <malloc+0xba0>
    1e7e:	00004097          	auipc	ra,0x4
    1e82:	0ea080e7          	jalr	234(ra) # 5f68 <printf>
            exit(1);
    1e86:	4505                	li	a0,1
    1e88:	00004097          	auipc	ra,0x4
    1e8c:	d66080e7          	jalr	-666(ra) # 5bee <exit>
      exit(0);
    1e90:	4501                	li	a0,0
    1e92:	00004097          	auipc	ra,0x4
    1e96:	d5c080e7          	jalr	-676(ra) # 5bee <exit>
      exit(1);
    1e9a:	4505                	li	a0,1
    1e9c:	00004097          	auipc	ra,0x4
    1ea0:	d52080e7          	jalr	-686(ra) # 5bee <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1ea4:	f8040613          	addi	a2,s0,-128
    1ea8:	85e6                	mv	a1,s9
    1eaa:	00005517          	auipc	a0,0x5
    1eae:	d2e50513          	addi	a0,a0,-722 # 6bd8 <malloc+0xbb8>
    1eb2:	00004097          	auipc	ra,0x4
    1eb6:	0b6080e7          	jalr	182(ra) # 5f68 <printf>
        exit(1);
    1eba:	4505                	li	a0,1
    1ebc:	00004097          	auipc	ra,0x4
    1ec0:	d32080e7          	jalr	-718(ra) # 5bee <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ec4:	054b7163          	bgeu	s6,s4,1f06 <createdelete+0x198>
      if(fd >= 0)
    1ec8:	02055a63          	bgez	a0,1efc <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ecc:	2485                	addiw	s1,s1,1
    1ece:	0ff4f493          	zext.b	s1,s1
    1ed2:	05548c63          	beq	s1,s5,1f2a <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ed6:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1eda:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1ede:	4581                	li	a1,0
    1ee0:	f8040513          	addi	a0,s0,-128
    1ee4:	00004097          	auipc	ra,0x4
    1ee8:	d4a080e7          	jalr	-694(ra) # 5c2e <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1eec:	00090463          	beqz	s2,1ef4 <createdelete+0x186>
    1ef0:	fd2bdae3          	bge	s7,s2,1ec4 <createdelete+0x156>
    1ef4:	fa0548e3          	bltz	a0,1ea4 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef8:	014b7963          	bgeu	s6,s4,1f0a <createdelete+0x19c>
        close(fd);
    1efc:	00004097          	auipc	ra,0x4
    1f00:	d1a080e7          	jalr	-742(ra) # 5c16 <close>
    1f04:	b7e1                	j	1ecc <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1f06:	fc0543e3          	bltz	a0,1ecc <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f0a:	f8040613          	addi	a2,s0,-128
    1f0e:	85e6                	mv	a1,s9
    1f10:	00005517          	auipc	a0,0x5
    1f14:	cf050513          	addi	a0,a0,-784 # 6c00 <malloc+0xbe0>
    1f18:	00004097          	auipc	ra,0x4
    1f1c:	050080e7          	jalr	80(ra) # 5f68 <printf>
        exit(1);
    1f20:	4505                	li	a0,1
    1f22:	00004097          	auipc	ra,0x4
    1f26:	ccc080e7          	jalr	-820(ra) # 5bee <exit>
  for(i = 0; i < N; i++){
    1f2a:	2905                	addiw	s2,s2,1
    1f2c:	2a05                	addiw	s4,s4,1
    1f2e:	2985                	addiw	s3,s3,1
    1f30:	0ff9f993          	zext.b	s3,s3
    1f34:	47d1                	li	a5,20
    1f36:	02f90a63          	beq	s2,a5,1f6a <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f3a:	84e2                	mv	s1,s8
    1f3c:	bf69                	j	1ed6 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f3e:	2905                	addiw	s2,s2,1
    1f40:	0ff97913          	zext.b	s2,s2
    1f44:	2985                	addiw	s3,s3,1
    1f46:	0ff9f993          	zext.b	s3,s3
    1f4a:	03490863          	beq	s2,s4,1f7a <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f4e:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f50:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f54:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f58:	f8040513          	addi	a0,s0,-128
    1f5c:	00004097          	auipc	ra,0x4
    1f60:	ce2080e7          	jalr	-798(ra) # 5c3e <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f64:	34fd                	addiw	s1,s1,-1
    1f66:	f4ed                	bnez	s1,1f50 <createdelete+0x1e2>
    1f68:	bfd9                	j	1f3e <createdelete+0x1d0>
    1f6a:	03000993          	li	s3,48
    1f6e:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f72:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f74:	08400a13          	li	s4,132
    1f78:	bfd9                	j	1f4e <createdelete+0x1e0>
}
    1f7a:	60aa                	ld	ra,136(sp)
    1f7c:	640a                	ld	s0,128(sp)
    1f7e:	74e6                	ld	s1,120(sp)
    1f80:	7946                	ld	s2,112(sp)
    1f82:	79a6                	ld	s3,104(sp)
    1f84:	7a06                	ld	s4,96(sp)
    1f86:	6ae6                	ld	s5,88(sp)
    1f88:	6b46                	ld	s6,80(sp)
    1f8a:	6ba6                	ld	s7,72(sp)
    1f8c:	6c06                	ld	s8,64(sp)
    1f8e:	7ce2                	ld	s9,56(sp)
    1f90:	6149                	addi	sp,sp,144
    1f92:	8082                	ret

0000000000001f94 <linkunlink>:
{
    1f94:	711d                	addi	sp,sp,-96
    1f96:	ec86                	sd	ra,88(sp)
    1f98:	e8a2                	sd	s0,80(sp)
    1f9a:	e4a6                	sd	s1,72(sp)
    1f9c:	e0ca                	sd	s2,64(sp)
    1f9e:	fc4e                	sd	s3,56(sp)
    1fa0:	f852                	sd	s4,48(sp)
    1fa2:	f456                	sd	s5,40(sp)
    1fa4:	f05a                	sd	s6,32(sp)
    1fa6:	ec5e                	sd	s7,24(sp)
    1fa8:	e862                	sd	s8,16(sp)
    1faa:	e466                	sd	s9,8(sp)
    1fac:	1080                	addi	s0,sp,96
    1fae:	84aa                	mv	s1,a0
  unlink("x");
    1fb0:	00004517          	auipc	a0,0x4
    1fb4:	20850513          	addi	a0,a0,520 # 61b8 <malloc+0x198>
    1fb8:	00004097          	auipc	ra,0x4
    1fbc:	c86080e7          	jalr	-890(ra) # 5c3e <unlink>
  pid = fork();
    1fc0:	00004097          	auipc	ra,0x4
    1fc4:	c26080e7          	jalr	-986(ra) # 5be6 <fork>
  if(pid < 0){
    1fc8:	02054b63          	bltz	a0,1ffe <linkunlink+0x6a>
    1fcc:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fce:	4c85                	li	s9,1
    1fd0:	e119                	bnez	a0,1fd6 <linkunlink+0x42>
    1fd2:	06100c93          	li	s9,97
    1fd6:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fda:	41c659b7          	lui	s3,0x41c65
    1fde:	e6d9899b          	addiw	s3,s3,-403 # 41c64e6d <base+0x41c551f5>
    1fe2:	690d                	lui	s2,0x3
    1fe4:	0399091b          	addiw	s2,s2,57 # 3039 <fourteen+0x13>
    if((x % 3) == 0){
    1fe8:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fea:	4b05                	li	s6,1
      unlink("x");
    1fec:	00004a97          	auipc	s5,0x4
    1ff0:	1cca8a93          	addi	s5,s5,460 # 61b8 <malloc+0x198>
      link("cat", "x");
    1ff4:	00005b97          	auipc	s7,0x5
    1ff8:	c34b8b93          	addi	s7,s7,-972 # 6c28 <malloc+0xc08>
    1ffc:	a825                	j	2034 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1ffe:	85a6                	mv	a1,s1
    2000:	00005517          	auipc	a0,0x5
    2004:	9d050513          	addi	a0,a0,-1584 # 69d0 <malloc+0x9b0>
    2008:	00004097          	auipc	ra,0x4
    200c:	f60080e7          	jalr	-160(ra) # 5f68 <printf>
    exit(1);
    2010:	4505                	li	a0,1
    2012:	00004097          	auipc	ra,0x4
    2016:	bdc080e7          	jalr	-1060(ra) # 5bee <exit>
      close(open("x", O_RDWR | O_CREATE));
    201a:	20200593          	li	a1,514
    201e:	8556                	mv	a0,s5
    2020:	00004097          	auipc	ra,0x4
    2024:	c0e080e7          	jalr	-1010(ra) # 5c2e <open>
    2028:	00004097          	auipc	ra,0x4
    202c:	bee080e7          	jalr	-1042(ra) # 5c16 <close>
  for(i = 0; i < 100; i++){
    2030:	34fd                	addiw	s1,s1,-1
    2032:	c88d                	beqz	s1,2064 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    2034:	033c87bb          	mulw	a5,s9,s3
    2038:	012787bb          	addw	a5,a5,s2
    203c:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2040:	0347f7bb          	remuw	a5,a5,s4
    2044:	dbf9                	beqz	a5,201a <linkunlink+0x86>
    } else if((x % 3) == 1){
    2046:	01678863          	beq	a5,s6,2056 <linkunlink+0xc2>
      unlink("x");
    204a:	8556                	mv	a0,s5
    204c:	00004097          	auipc	ra,0x4
    2050:	bf2080e7          	jalr	-1038(ra) # 5c3e <unlink>
    2054:	bff1                	j	2030 <linkunlink+0x9c>
      link("cat", "x");
    2056:	85d6                	mv	a1,s5
    2058:	855e                	mv	a0,s7
    205a:	00004097          	auipc	ra,0x4
    205e:	bf4080e7          	jalr	-1036(ra) # 5c4e <link>
    2062:	b7f9                	j	2030 <linkunlink+0x9c>
  if(pid)
    2064:	020c0463          	beqz	s8,208c <linkunlink+0xf8>
    wait(0);
    2068:	4501                	li	a0,0
    206a:	00004097          	auipc	ra,0x4
    206e:	b8c080e7          	jalr	-1140(ra) # 5bf6 <wait>
}
    2072:	60e6                	ld	ra,88(sp)
    2074:	6446                	ld	s0,80(sp)
    2076:	64a6                	ld	s1,72(sp)
    2078:	6906                	ld	s2,64(sp)
    207a:	79e2                	ld	s3,56(sp)
    207c:	7a42                	ld	s4,48(sp)
    207e:	7aa2                	ld	s5,40(sp)
    2080:	7b02                	ld	s6,32(sp)
    2082:	6be2                	ld	s7,24(sp)
    2084:	6c42                	ld	s8,16(sp)
    2086:	6ca2                	ld	s9,8(sp)
    2088:	6125                	addi	sp,sp,96
    208a:	8082                	ret
    exit(0);
    208c:	4501                	li	a0,0
    208e:	00004097          	auipc	ra,0x4
    2092:	b60080e7          	jalr	-1184(ra) # 5bee <exit>

0000000000002096 <forktest>:
{
    2096:	7179                	addi	sp,sp,-48
    2098:	f406                	sd	ra,40(sp)
    209a:	f022                	sd	s0,32(sp)
    209c:	ec26                	sd	s1,24(sp)
    209e:	e84a                	sd	s2,16(sp)
    20a0:	e44e                	sd	s3,8(sp)
    20a2:	1800                	addi	s0,sp,48
    20a4:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    20a6:	4481                	li	s1,0
    20a8:	3e800913          	li	s2,1000
    pid = fork();
    20ac:	00004097          	auipc	ra,0x4
    20b0:	b3a080e7          	jalr	-1222(ra) # 5be6 <fork>
    if(pid < 0)
    20b4:	02054863          	bltz	a0,20e4 <forktest+0x4e>
    if(pid == 0)
    20b8:	c115                	beqz	a0,20dc <forktest+0x46>
  for(n=0; n<N; n++){
    20ba:	2485                	addiw	s1,s1,1
    20bc:	ff2498e3          	bne	s1,s2,20ac <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20c0:	85ce                	mv	a1,s3
    20c2:	00005517          	auipc	a0,0x5
    20c6:	b8650513          	addi	a0,a0,-1146 # 6c48 <malloc+0xc28>
    20ca:	00004097          	auipc	ra,0x4
    20ce:	e9e080e7          	jalr	-354(ra) # 5f68 <printf>
    exit(1);
    20d2:	4505                	li	a0,1
    20d4:	00004097          	auipc	ra,0x4
    20d8:	b1a080e7          	jalr	-1254(ra) # 5bee <exit>
      exit(0);
    20dc:	00004097          	auipc	ra,0x4
    20e0:	b12080e7          	jalr	-1262(ra) # 5bee <exit>
  if (n == 0) {
    20e4:	cc9d                	beqz	s1,2122 <forktest+0x8c>
  if(n == N){
    20e6:	3e800793          	li	a5,1000
    20ea:	fcf48be3          	beq	s1,a5,20c0 <forktest+0x2a>
  for(; n > 0; n--){
    20ee:	00905b63          	blez	s1,2104 <forktest+0x6e>
    if(wait(0) < 0){
    20f2:	4501                	li	a0,0
    20f4:	00004097          	auipc	ra,0x4
    20f8:	b02080e7          	jalr	-1278(ra) # 5bf6 <wait>
    20fc:	04054163          	bltz	a0,213e <forktest+0xa8>
  for(; n > 0; n--){
    2100:	34fd                	addiw	s1,s1,-1
    2102:	f8e5                	bnez	s1,20f2 <forktest+0x5c>
  if(wait(0) != -1){
    2104:	4501                	li	a0,0
    2106:	00004097          	auipc	ra,0x4
    210a:	af0080e7          	jalr	-1296(ra) # 5bf6 <wait>
    210e:	57fd                	li	a5,-1
    2110:	04f51563          	bne	a0,a5,215a <forktest+0xc4>
}
    2114:	70a2                	ld	ra,40(sp)
    2116:	7402                	ld	s0,32(sp)
    2118:	64e2                	ld	s1,24(sp)
    211a:	6942                	ld	s2,16(sp)
    211c:	69a2                	ld	s3,8(sp)
    211e:	6145                	addi	sp,sp,48
    2120:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2122:	85ce                	mv	a1,s3
    2124:	00005517          	auipc	a0,0x5
    2128:	b0c50513          	addi	a0,a0,-1268 # 6c30 <malloc+0xc10>
    212c:	00004097          	auipc	ra,0x4
    2130:	e3c080e7          	jalr	-452(ra) # 5f68 <printf>
    exit(1);
    2134:	4505                	li	a0,1
    2136:	00004097          	auipc	ra,0x4
    213a:	ab8080e7          	jalr	-1352(ra) # 5bee <exit>
      printf("%s: wait stopped early\n", s);
    213e:	85ce                	mv	a1,s3
    2140:	00005517          	auipc	a0,0x5
    2144:	b3050513          	addi	a0,a0,-1232 # 6c70 <malloc+0xc50>
    2148:	00004097          	auipc	ra,0x4
    214c:	e20080e7          	jalr	-480(ra) # 5f68 <printf>
      exit(1);
    2150:	4505                	li	a0,1
    2152:	00004097          	auipc	ra,0x4
    2156:	a9c080e7          	jalr	-1380(ra) # 5bee <exit>
    printf("%s: wait got too many\n", s);
    215a:	85ce                	mv	a1,s3
    215c:	00005517          	auipc	a0,0x5
    2160:	b2c50513          	addi	a0,a0,-1236 # 6c88 <malloc+0xc68>
    2164:	00004097          	auipc	ra,0x4
    2168:	e04080e7          	jalr	-508(ra) # 5f68 <printf>
    exit(1);
    216c:	4505                	li	a0,1
    216e:	00004097          	auipc	ra,0x4
    2172:	a80080e7          	jalr	-1408(ra) # 5bee <exit>

0000000000002176 <kernmem>:
{
    2176:	715d                	addi	sp,sp,-80
    2178:	e486                	sd	ra,72(sp)
    217a:	e0a2                	sd	s0,64(sp)
    217c:	fc26                	sd	s1,56(sp)
    217e:	f84a                	sd	s2,48(sp)
    2180:	f44e                	sd	s3,40(sp)
    2182:	f052                	sd	s4,32(sp)
    2184:	ec56                	sd	s5,24(sp)
    2186:	0880                	addi	s0,sp,80
    2188:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    218a:	4485                	li	s1,1
    218c:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    218e:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2190:	69b1                	lui	s3,0xc
    2192:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    2196:	1003d937          	lui	s2,0x1003d
    219a:	090e                	slli	s2,s2,0x3
    219c:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    21a0:	00004097          	auipc	ra,0x4
    21a4:	a46080e7          	jalr	-1466(ra) # 5be6 <fork>
    if(pid < 0){
    21a8:	02054963          	bltz	a0,21da <kernmem+0x64>
    if(pid == 0){
    21ac:	c529                	beqz	a0,21f6 <kernmem+0x80>
    wait(&xstatus);
    21ae:	fbc40513          	addi	a0,s0,-68
    21b2:	00004097          	auipc	ra,0x4
    21b6:	a44080e7          	jalr	-1468(ra) # 5bf6 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21ba:	fbc42783          	lw	a5,-68(s0)
    21be:	05579d63          	bne	a5,s5,2218 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21c2:	94ce                	add	s1,s1,s3
    21c4:	fd249ee3          	bne	s1,s2,21a0 <kernmem+0x2a>
}
    21c8:	60a6                	ld	ra,72(sp)
    21ca:	6406                	ld	s0,64(sp)
    21cc:	74e2                	ld	s1,56(sp)
    21ce:	7942                	ld	s2,48(sp)
    21d0:	79a2                	ld	s3,40(sp)
    21d2:	7a02                	ld	s4,32(sp)
    21d4:	6ae2                	ld	s5,24(sp)
    21d6:	6161                	addi	sp,sp,80
    21d8:	8082                	ret
      printf("%s: fork failed\n", s);
    21da:	85d2                	mv	a1,s4
    21dc:	00004517          	auipc	a0,0x4
    21e0:	7f450513          	addi	a0,a0,2036 # 69d0 <malloc+0x9b0>
    21e4:	00004097          	auipc	ra,0x4
    21e8:	d84080e7          	jalr	-636(ra) # 5f68 <printf>
      exit(1);
    21ec:	4505                	li	a0,1
    21ee:	00004097          	auipc	ra,0x4
    21f2:	a00080e7          	jalr	-1536(ra) # 5bee <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21f6:	0004c683          	lbu	a3,0(s1)
    21fa:	8626                	mv	a2,s1
    21fc:	85d2                	mv	a1,s4
    21fe:	00005517          	auipc	a0,0x5
    2202:	aa250513          	addi	a0,a0,-1374 # 6ca0 <malloc+0xc80>
    2206:	00004097          	auipc	ra,0x4
    220a:	d62080e7          	jalr	-670(ra) # 5f68 <printf>
      exit(1);
    220e:	4505                	li	a0,1
    2210:	00004097          	auipc	ra,0x4
    2214:	9de080e7          	jalr	-1570(ra) # 5bee <exit>
      exit(1);
    2218:	4505                	li	a0,1
    221a:	00004097          	auipc	ra,0x4
    221e:	9d4080e7          	jalr	-1580(ra) # 5bee <exit>

0000000000002222 <MAXVAplus>:
{
    2222:	7179                	addi	sp,sp,-48
    2224:	f406                	sd	ra,40(sp)
    2226:	f022                	sd	s0,32(sp)
    2228:	ec26                	sd	s1,24(sp)
    222a:	e84a                	sd	s2,16(sp)
    222c:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    222e:	4785                	li	a5,1
    2230:	179a                	slli	a5,a5,0x26
    2232:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2236:	fd843783          	ld	a5,-40(s0)
    223a:	cf85                	beqz	a5,2272 <MAXVAplus+0x50>
    223c:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    223e:	54fd                	li	s1,-1
    pid = fork();
    2240:	00004097          	auipc	ra,0x4
    2244:	9a6080e7          	jalr	-1626(ra) # 5be6 <fork>
    if(pid < 0){
    2248:	02054b63          	bltz	a0,227e <MAXVAplus+0x5c>
    if(pid == 0){
    224c:	c539                	beqz	a0,229a <MAXVAplus+0x78>
    wait(&xstatus);
    224e:	fd440513          	addi	a0,s0,-44
    2252:	00004097          	auipc	ra,0x4
    2256:	9a4080e7          	jalr	-1628(ra) # 5bf6 <wait>
    if(xstatus != -1)  // did kernel kill child?
    225a:	fd442783          	lw	a5,-44(s0)
    225e:	06979463          	bne	a5,s1,22c6 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    2262:	fd843783          	ld	a5,-40(s0)
    2266:	0786                	slli	a5,a5,0x1
    2268:	fcf43c23          	sd	a5,-40(s0)
    226c:	fd843783          	ld	a5,-40(s0)
    2270:	fbe1                	bnez	a5,2240 <MAXVAplus+0x1e>
}
    2272:	70a2                	ld	ra,40(sp)
    2274:	7402                	ld	s0,32(sp)
    2276:	64e2                	ld	s1,24(sp)
    2278:	6942                	ld	s2,16(sp)
    227a:	6145                	addi	sp,sp,48
    227c:	8082                	ret
      printf("%s: fork failed\n", s);
    227e:	85ca                	mv	a1,s2
    2280:	00004517          	auipc	a0,0x4
    2284:	75050513          	addi	a0,a0,1872 # 69d0 <malloc+0x9b0>
    2288:	00004097          	auipc	ra,0x4
    228c:	ce0080e7          	jalr	-800(ra) # 5f68 <printf>
      exit(1);
    2290:	4505                	li	a0,1
    2292:	00004097          	auipc	ra,0x4
    2296:	95c080e7          	jalr	-1700(ra) # 5bee <exit>
      *(char*)a = 99;
    229a:	fd843783          	ld	a5,-40(s0)
    229e:	06300713          	li	a4,99
    22a2:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    22a6:	fd843603          	ld	a2,-40(s0)
    22aa:	85ca                	mv	a1,s2
    22ac:	00005517          	auipc	a0,0x5
    22b0:	a1450513          	addi	a0,a0,-1516 # 6cc0 <malloc+0xca0>
    22b4:	00004097          	auipc	ra,0x4
    22b8:	cb4080e7          	jalr	-844(ra) # 5f68 <printf>
      exit(1);
    22bc:	4505                	li	a0,1
    22be:	00004097          	auipc	ra,0x4
    22c2:	930080e7          	jalr	-1744(ra) # 5bee <exit>
      exit(1);
    22c6:	4505                	li	a0,1
    22c8:	00004097          	auipc	ra,0x4
    22cc:	926080e7          	jalr	-1754(ra) # 5bee <exit>

00000000000022d0 <bigargtest>:
{
    22d0:	7179                	addi	sp,sp,-48
    22d2:	f406                	sd	ra,40(sp)
    22d4:	f022                	sd	s0,32(sp)
    22d6:	ec26                	sd	s1,24(sp)
    22d8:	1800                	addi	s0,sp,48
    22da:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22dc:	00005517          	auipc	a0,0x5
    22e0:	9fc50513          	addi	a0,a0,-1540 # 6cd8 <malloc+0xcb8>
    22e4:	00004097          	auipc	ra,0x4
    22e8:	95a080e7          	jalr	-1702(ra) # 5c3e <unlink>
  pid = fork();
    22ec:	00004097          	auipc	ra,0x4
    22f0:	8fa080e7          	jalr	-1798(ra) # 5be6 <fork>
  if(pid == 0){
    22f4:	c121                	beqz	a0,2334 <bigargtest+0x64>
  } else if(pid < 0){
    22f6:	0a054063          	bltz	a0,2396 <bigargtest+0xc6>
  wait(&xstatus);
    22fa:	fdc40513          	addi	a0,s0,-36
    22fe:	00004097          	auipc	ra,0x4
    2302:	8f8080e7          	jalr	-1800(ra) # 5bf6 <wait>
  if(xstatus != 0)
    2306:	fdc42503          	lw	a0,-36(s0)
    230a:	e545                	bnez	a0,23b2 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    230c:	4581                	li	a1,0
    230e:	00005517          	auipc	a0,0x5
    2312:	9ca50513          	addi	a0,a0,-1590 # 6cd8 <malloc+0xcb8>
    2316:	00004097          	auipc	ra,0x4
    231a:	918080e7          	jalr	-1768(ra) # 5c2e <open>
  if(fd < 0){
    231e:	08054e63          	bltz	a0,23ba <bigargtest+0xea>
  close(fd);
    2322:	00004097          	auipc	ra,0x4
    2326:	8f4080e7          	jalr	-1804(ra) # 5c16 <close>
}
    232a:	70a2                	ld	ra,40(sp)
    232c:	7402                	ld	s0,32(sp)
    232e:	64e2                	ld	s1,24(sp)
    2330:	6145                	addi	sp,sp,48
    2332:	8082                	ret
    2334:	00007797          	auipc	a5,0x7
    2338:	12c78793          	addi	a5,a5,300 # 9460 <args.1>
    233c:	00007697          	auipc	a3,0x7
    2340:	21c68693          	addi	a3,a3,540 # 9558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2344:	00005717          	auipc	a4,0x5
    2348:	9a470713          	addi	a4,a4,-1628 # 6ce8 <malloc+0xcc8>
    234c:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    234e:	07a1                	addi	a5,a5,8
    2350:	fed79ee3          	bne	a5,a3,234c <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2354:	00007597          	auipc	a1,0x7
    2358:	10c58593          	addi	a1,a1,268 # 9460 <args.1>
    235c:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2360:	00004517          	auipc	a0,0x4
    2364:	de850513          	addi	a0,a0,-536 # 6148 <malloc+0x128>
    2368:	00004097          	auipc	ra,0x4
    236c:	8be080e7          	jalr	-1858(ra) # 5c26 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2370:	20000593          	li	a1,512
    2374:	00005517          	auipc	a0,0x5
    2378:	96450513          	addi	a0,a0,-1692 # 6cd8 <malloc+0xcb8>
    237c:	00004097          	auipc	ra,0x4
    2380:	8b2080e7          	jalr	-1870(ra) # 5c2e <open>
    close(fd);
    2384:	00004097          	auipc	ra,0x4
    2388:	892080e7          	jalr	-1902(ra) # 5c16 <close>
    exit(0);
    238c:	4501                	li	a0,0
    238e:	00004097          	auipc	ra,0x4
    2392:	860080e7          	jalr	-1952(ra) # 5bee <exit>
    printf("%s: bigargtest: fork failed\n", s);
    2396:	85a6                	mv	a1,s1
    2398:	00005517          	auipc	a0,0x5
    239c:	a3050513          	addi	a0,a0,-1488 # 6dc8 <malloc+0xda8>
    23a0:	00004097          	auipc	ra,0x4
    23a4:	bc8080e7          	jalr	-1080(ra) # 5f68 <printf>
    exit(1);
    23a8:	4505                	li	a0,1
    23aa:	00004097          	auipc	ra,0x4
    23ae:	844080e7          	jalr	-1980(ra) # 5bee <exit>
    exit(xstatus);
    23b2:	00004097          	auipc	ra,0x4
    23b6:	83c080e7          	jalr	-1988(ra) # 5bee <exit>
    printf("%s: bigarg test failed!\n", s);
    23ba:	85a6                	mv	a1,s1
    23bc:	00005517          	auipc	a0,0x5
    23c0:	a2c50513          	addi	a0,a0,-1492 # 6de8 <malloc+0xdc8>
    23c4:	00004097          	auipc	ra,0x4
    23c8:	ba4080e7          	jalr	-1116(ra) # 5f68 <printf>
    exit(1);
    23cc:	4505                	li	a0,1
    23ce:	00004097          	auipc	ra,0x4
    23d2:	820080e7          	jalr	-2016(ra) # 5bee <exit>

00000000000023d6 <stacktest>:
{
    23d6:	7179                	addi	sp,sp,-48
    23d8:	f406                	sd	ra,40(sp)
    23da:	f022                	sd	s0,32(sp)
    23dc:	ec26                	sd	s1,24(sp)
    23de:	1800                	addi	s0,sp,48
    23e0:	84aa                	mv	s1,a0
  pid = fork();
    23e2:	00004097          	auipc	ra,0x4
    23e6:	804080e7          	jalr	-2044(ra) # 5be6 <fork>
  if(pid == 0) {
    23ea:	c115                	beqz	a0,240e <stacktest+0x38>
  } else if(pid < 0){
    23ec:	04054463          	bltz	a0,2434 <stacktest+0x5e>
  wait(&xstatus);
    23f0:	fdc40513          	addi	a0,s0,-36
    23f4:	00004097          	auipc	ra,0x4
    23f8:	802080e7          	jalr	-2046(ra) # 5bf6 <wait>
  if(xstatus == -1)  // kernel killed child?
    23fc:	fdc42503          	lw	a0,-36(s0)
    2400:	57fd                	li	a5,-1
    2402:	04f50763          	beq	a0,a5,2450 <stacktest+0x7a>
    exit(xstatus);
    2406:	00003097          	auipc	ra,0x3
    240a:	7e8080e7          	jalr	2024(ra) # 5bee <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    240e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2410:	77fd                	lui	a5,0xfffff
    2412:	97ba                	add	a5,a5,a4
    2414:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2418:	85a6                	mv	a1,s1
    241a:	00005517          	auipc	a0,0x5
    241e:	9ee50513          	addi	a0,a0,-1554 # 6e08 <malloc+0xde8>
    2422:	00004097          	auipc	ra,0x4
    2426:	b46080e7          	jalr	-1210(ra) # 5f68 <printf>
    exit(1);
    242a:	4505                	li	a0,1
    242c:	00003097          	auipc	ra,0x3
    2430:	7c2080e7          	jalr	1986(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    2434:	85a6                	mv	a1,s1
    2436:	00004517          	auipc	a0,0x4
    243a:	59a50513          	addi	a0,a0,1434 # 69d0 <malloc+0x9b0>
    243e:	00004097          	auipc	ra,0x4
    2442:	b2a080e7          	jalr	-1238(ra) # 5f68 <printf>
    exit(1);
    2446:	4505                	li	a0,1
    2448:	00003097          	auipc	ra,0x3
    244c:	7a6080e7          	jalr	1958(ra) # 5bee <exit>
    exit(0);
    2450:	4501                	li	a0,0
    2452:	00003097          	auipc	ra,0x3
    2456:	79c080e7          	jalr	1948(ra) # 5bee <exit>

000000000000245a <textwrite>:
{
    245a:	7179                	addi	sp,sp,-48
    245c:	f406                	sd	ra,40(sp)
    245e:	f022                	sd	s0,32(sp)
    2460:	ec26                	sd	s1,24(sp)
    2462:	1800                	addi	s0,sp,48
    2464:	84aa                	mv	s1,a0
  pid = fork();
    2466:	00003097          	auipc	ra,0x3
    246a:	780080e7          	jalr	1920(ra) # 5be6 <fork>
  if(pid == 0) {
    246e:	c115                	beqz	a0,2492 <textwrite+0x38>
  } else if(pid < 0){
    2470:	02054963          	bltz	a0,24a2 <textwrite+0x48>
  wait(&xstatus);
    2474:	fdc40513          	addi	a0,s0,-36
    2478:	00003097          	auipc	ra,0x3
    247c:	77e080e7          	jalr	1918(ra) # 5bf6 <wait>
  if(xstatus == -1)  // kernel killed child?
    2480:	fdc42503          	lw	a0,-36(s0)
    2484:	57fd                	li	a5,-1
    2486:	02f50c63          	beq	a0,a5,24be <textwrite+0x64>
    exit(xstatus);
    248a:	00003097          	auipc	ra,0x3
    248e:	764080e7          	jalr	1892(ra) # 5bee <exit>
    *addr = 10;
    2492:	47a9                	li	a5,10
    2494:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2498:	4505                	li	a0,1
    249a:	00003097          	auipc	ra,0x3
    249e:	754080e7          	jalr	1876(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    24a2:	85a6                	mv	a1,s1
    24a4:	00004517          	auipc	a0,0x4
    24a8:	52c50513          	addi	a0,a0,1324 # 69d0 <malloc+0x9b0>
    24ac:	00004097          	auipc	ra,0x4
    24b0:	abc080e7          	jalr	-1348(ra) # 5f68 <printf>
    exit(1);
    24b4:	4505                	li	a0,1
    24b6:	00003097          	auipc	ra,0x3
    24ba:	738080e7          	jalr	1848(ra) # 5bee <exit>
    exit(0);
    24be:	4501                	li	a0,0
    24c0:	00003097          	auipc	ra,0x3
    24c4:	72e080e7          	jalr	1838(ra) # 5bee <exit>

00000000000024c8 <manywrites>:
{
    24c8:	711d                	addi	sp,sp,-96
    24ca:	ec86                	sd	ra,88(sp)
    24cc:	e8a2                	sd	s0,80(sp)
    24ce:	e4a6                	sd	s1,72(sp)
    24d0:	e0ca                	sd	s2,64(sp)
    24d2:	fc4e                	sd	s3,56(sp)
    24d4:	f852                	sd	s4,48(sp)
    24d6:	f456                	sd	s5,40(sp)
    24d8:	f05a                	sd	s6,32(sp)
    24da:	ec5e                	sd	s7,24(sp)
    24dc:	1080                	addi	s0,sp,96
    24de:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24e0:	4981                	li	s3,0
    24e2:	4911                	li	s2,4
    int pid = fork();
    24e4:	00003097          	auipc	ra,0x3
    24e8:	702080e7          	jalr	1794(ra) # 5be6 <fork>
    24ec:	84aa                	mv	s1,a0
    if(pid < 0){
    24ee:	02054963          	bltz	a0,2520 <manywrites+0x58>
    if(pid == 0){
    24f2:	c521                	beqz	a0,253a <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24f4:	2985                	addiw	s3,s3,1
    24f6:	ff2997e3          	bne	s3,s2,24e4 <manywrites+0x1c>
    24fa:	4491                	li	s1,4
    int st = 0;
    24fc:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    2500:	fa840513          	addi	a0,s0,-88
    2504:	00003097          	auipc	ra,0x3
    2508:	6f2080e7          	jalr	1778(ra) # 5bf6 <wait>
    if(st != 0)
    250c:	fa842503          	lw	a0,-88(s0)
    2510:	ed6d                	bnez	a0,260a <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    2512:	34fd                	addiw	s1,s1,-1
    2514:	f4e5                	bnez	s1,24fc <manywrites+0x34>
  exit(0);
    2516:	4501                	li	a0,0
    2518:	00003097          	auipc	ra,0x3
    251c:	6d6080e7          	jalr	1750(ra) # 5bee <exit>
      printf("fork failed\n");
    2520:	00005517          	auipc	a0,0x5
    2524:	8b850513          	addi	a0,a0,-1864 # 6dd8 <malloc+0xdb8>
    2528:	00004097          	auipc	ra,0x4
    252c:	a40080e7          	jalr	-1472(ra) # 5f68 <printf>
      exit(1);
    2530:	4505                	li	a0,1
    2532:	00003097          	auipc	ra,0x3
    2536:	6bc080e7          	jalr	1724(ra) # 5bee <exit>
      name[0] = 'b';
    253a:	06200793          	li	a5,98
    253e:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    2542:	0619879b          	addiw	a5,s3,97
    2546:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    254a:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    254e:	fa840513          	addi	a0,s0,-88
    2552:	00003097          	auipc	ra,0x3
    2556:	6ec080e7          	jalr	1772(ra) # 5c3e <unlink>
    255a:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    255c:	0000ab17          	auipc	s6,0xa
    2560:	71cb0b13          	addi	s6,s6,1820 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    2564:	8a26                	mv	s4,s1
    2566:	0209ce63          	bltz	s3,25a2 <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    256a:	20200593          	li	a1,514
    256e:	fa840513          	addi	a0,s0,-88
    2572:	00003097          	auipc	ra,0x3
    2576:	6bc080e7          	jalr	1724(ra) # 5c2e <open>
    257a:	892a                	mv	s2,a0
          if(fd < 0){
    257c:	04054763          	bltz	a0,25ca <manywrites+0x102>
          int cc = write(fd, buf, sz);
    2580:	660d                	lui	a2,0x3
    2582:	85da                	mv	a1,s6
    2584:	00003097          	auipc	ra,0x3
    2588:	68a080e7          	jalr	1674(ra) # 5c0e <write>
          if(cc != sz){
    258c:	678d                	lui	a5,0x3
    258e:	04f51e63          	bne	a0,a5,25ea <manywrites+0x122>
          close(fd);
    2592:	854a                	mv	a0,s2
    2594:	00003097          	auipc	ra,0x3
    2598:	682080e7          	jalr	1666(ra) # 5c16 <close>
        for(int i = 0; i < ci+1; i++){
    259c:	2a05                	addiw	s4,s4,1
    259e:	fd49d6e3          	bge	s3,s4,256a <manywrites+0xa2>
        unlink(name);
    25a2:	fa840513          	addi	a0,s0,-88
    25a6:	00003097          	auipc	ra,0x3
    25aa:	698080e7          	jalr	1688(ra) # 5c3e <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25ae:	3bfd                	addiw	s7,s7,-1
    25b0:	fa0b9ae3          	bnez	s7,2564 <manywrites+0x9c>
      unlink(name);
    25b4:	fa840513          	addi	a0,s0,-88
    25b8:	00003097          	auipc	ra,0x3
    25bc:	686080e7          	jalr	1670(ra) # 5c3e <unlink>
      exit(0);
    25c0:	4501                	li	a0,0
    25c2:	00003097          	auipc	ra,0x3
    25c6:	62c080e7          	jalr	1580(ra) # 5bee <exit>
            printf("%s: cannot create %s\n", s, name);
    25ca:	fa840613          	addi	a2,s0,-88
    25ce:	85d6                	mv	a1,s5
    25d0:	00005517          	auipc	a0,0x5
    25d4:	86050513          	addi	a0,a0,-1952 # 6e30 <malloc+0xe10>
    25d8:	00004097          	auipc	ra,0x4
    25dc:	990080e7          	jalr	-1648(ra) # 5f68 <printf>
            exit(1);
    25e0:	4505                	li	a0,1
    25e2:	00003097          	auipc	ra,0x3
    25e6:	60c080e7          	jalr	1548(ra) # 5bee <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25ea:	86aa                	mv	a3,a0
    25ec:	660d                	lui	a2,0x3
    25ee:	85d6                	mv	a1,s5
    25f0:	00004517          	auipc	a0,0x4
    25f4:	c2850513          	addi	a0,a0,-984 # 6218 <malloc+0x1f8>
    25f8:	00004097          	auipc	ra,0x4
    25fc:	970080e7          	jalr	-1680(ra) # 5f68 <printf>
            exit(1);
    2600:	4505                	li	a0,1
    2602:	00003097          	auipc	ra,0x3
    2606:	5ec080e7          	jalr	1516(ra) # 5bee <exit>
      exit(st);
    260a:	00003097          	auipc	ra,0x3
    260e:	5e4080e7          	jalr	1508(ra) # 5bee <exit>

0000000000002612 <copyinstr3>:
{
    2612:	7179                	addi	sp,sp,-48
    2614:	f406                	sd	ra,40(sp)
    2616:	f022                	sd	s0,32(sp)
    2618:	ec26                	sd	s1,24(sp)
    261a:	1800                	addi	s0,sp,48
  sbrk(8192);
    261c:	6509                	lui	a0,0x2
    261e:	00003097          	auipc	ra,0x3
    2622:	658080e7          	jalr	1624(ra) # 5c76 <sbrk>
  uint64 top = (uint64) sbrk(0);
    2626:	4501                	li	a0,0
    2628:	00003097          	auipc	ra,0x3
    262c:	64e080e7          	jalr	1614(ra) # 5c76 <sbrk>
  if((top % PGSIZE) != 0){
    2630:	03451793          	slli	a5,a0,0x34
    2634:	e3c9                	bnez	a5,26b6 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2636:	4501                	li	a0,0
    2638:	00003097          	auipc	ra,0x3
    263c:	63e080e7          	jalr	1598(ra) # 5c76 <sbrk>
  if(top % PGSIZE){
    2640:	03451793          	slli	a5,a0,0x34
    2644:	e3d9                	bnez	a5,26ca <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2646:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x6b>
  *b = 'x';
    264a:	07800793          	li	a5,120
    264e:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2652:	8526                	mv	a0,s1
    2654:	00003097          	auipc	ra,0x3
    2658:	5ea080e7          	jalr	1514(ra) # 5c3e <unlink>
  if(ret != -1){
    265c:	57fd                	li	a5,-1
    265e:	08f51363          	bne	a0,a5,26e4 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2662:	20100593          	li	a1,513
    2666:	8526                	mv	a0,s1
    2668:	00003097          	auipc	ra,0x3
    266c:	5c6080e7          	jalr	1478(ra) # 5c2e <open>
  if(fd != -1){
    2670:	57fd                	li	a5,-1
    2672:	08f51863          	bne	a0,a5,2702 <copyinstr3+0xf0>
  ret = link(b, b);
    2676:	85a6                	mv	a1,s1
    2678:	8526                	mv	a0,s1
    267a:	00003097          	auipc	ra,0x3
    267e:	5d4080e7          	jalr	1492(ra) # 5c4e <link>
  if(ret != -1){
    2682:	57fd                	li	a5,-1
    2684:	08f51e63          	bne	a0,a5,2720 <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2688:	00005797          	auipc	a5,0x5
    268c:	4a078793          	addi	a5,a5,1184 # 7b28 <malloc+0x1b08>
    2690:	fcf43823          	sd	a5,-48(s0)
    2694:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2698:	fd040593          	addi	a1,s0,-48
    269c:	8526                	mv	a0,s1
    269e:	00003097          	auipc	ra,0x3
    26a2:	588080e7          	jalr	1416(ra) # 5c26 <exec>
  if(ret != -1){
    26a6:	57fd                	li	a5,-1
    26a8:	08f51c63          	bne	a0,a5,2740 <copyinstr3+0x12e>
}
    26ac:	70a2                	ld	ra,40(sp)
    26ae:	7402                	ld	s0,32(sp)
    26b0:	64e2                	ld	s1,24(sp)
    26b2:	6145                	addi	sp,sp,48
    26b4:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26b6:	0347d513          	srli	a0,a5,0x34
    26ba:	6785                	lui	a5,0x1
    26bc:	40a7853b          	subw	a0,a5,a0
    26c0:	00003097          	auipc	ra,0x3
    26c4:	5b6080e7          	jalr	1462(ra) # 5c76 <sbrk>
    26c8:	b7bd                	j	2636 <copyinstr3+0x24>
    printf("oops\n");
    26ca:	00004517          	auipc	a0,0x4
    26ce:	77e50513          	addi	a0,a0,1918 # 6e48 <malloc+0xe28>
    26d2:	00004097          	auipc	ra,0x4
    26d6:	896080e7          	jalr	-1898(ra) # 5f68 <printf>
    exit(1);
    26da:	4505                	li	a0,1
    26dc:	00003097          	auipc	ra,0x3
    26e0:	512080e7          	jalr	1298(ra) # 5bee <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26e4:	862a                	mv	a2,a0
    26e6:	85a6                	mv	a1,s1
    26e8:	00004517          	auipc	a0,0x4
    26ec:	20850513          	addi	a0,a0,520 # 68f0 <malloc+0x8d0>
    26f0:	00004097          	auipc	ra,0x4
    26f4:	878080e7          	jalr	-1928(ra) # 5f68 <printf>
    exit(1);
    26f8:	4505                	li	a0,1
    26fa:	00003097          	auipc	ra,0x3
    26fe:	4f4080e7          	jalr	1268(ra) # 5bee <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2702:	862a                	mv	a2,a0
    2704:	85a6                	mv	a1,s1
    2706:	00004517          	auipc	a0,0x4
    270a:	20a50513          	addi	a0,a0,522 # 6910 <malloc+0x8f0>
    270e:	00004097          	auipc	ra,0x4
    2712:	85a080e7          	jalr	-1958(ra) # 5f68 <printf>
    exit(1);
    2716:	4505                	li	a0,1
    2718:	00003097          	auipc	ra,0x3
    271c:	4d6080e7          	jalr	1238(ra) # 5bee <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2720:	86aa                	mv	a3,a0
    2722:	8626                	mv	a2,s1
    2724:	85a6                	mv	a1,s1
    2726:	00004517          	auipc	a0,0x4
    272a:	20a50513          	addi	a0,a0,522 # 6930 <malloc+0x910>
    272e:	00004097          	auipc	ra,0x4
    2732:	83a080e7          	jalr	-1990(ra) # 5f68 <printf>
    exit(1);
    2736:	4505                	li	a0,1
    2738:	00003097          	auipc	ra,0x3
    273c:	4b6080e7          	jalr	1206(ra) # 5bee <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2740:	567d                	li	a2,-1
    2742:	85a6                	mv	a1,s1
    2744:	00004517          	auipc	a0,0x4
    2748:	21450513          	addi	a0,a0,532 # 6958 <malloc+0x938>
    274c:	00004097          	auipc	ra,0x4
    2750:	81c080e7          	jalr	-2020(ra) # 5f68 <printf>
    exit(1);
    2754:	4505                	li	a0,1
    2756:	00003097          	auipc	ra,0x3
    275a:	498080e7          	jalr	1176(ra) # 5bee <exit>

000000000000275e <rwsbrk>:
{
    275e:	1101                	addi	sp,sp,-32
    2760:	ec06                	sd	ra,24(sp)
    2762:	e822                	sd	s0,16(sp)
    2764:	e426                	sd	s1,8(sp)
    2766:	e04a                	sd	s2,0(sp)
    2768:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    276a:	6509                	lui	a0,0x2
    276c:	00003097          	auipc	ra,0x3
    2770:	50a080e7          	jalr	1290(ra) # 5c76 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2774:	57fd                	li	a5,-1
    2776:	06f50263          	beq	a0,a5,27da <rwsbrk+0x7c>
    277a:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    277c:	7579                	lui	a0,0xffffe
    277e:	00003097          	auipc	ra,0x3
    2782:	4f8080e7          	jalr	1272(ra) # 5c76 <sbrk>
    2786:	57fd                	li	a5,-1
    2788:	06f50663          	beq	a0,a5,27f4 <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    278c:	20100593          	li	a1,513
    2790:	00004517          	auipc	a0,0x4
    2794:	6f850513          	addi	a0,a0,1784 # 6e88 <malloc+0xe68>
    2798:	00003097          	auipc	ra,0x3
    279c:	496080e7          	jalr	1174(ra) # 5c2e <open>
    27a0:	892a                	mv	s2,a0
  if(fd < 0){
    27a2:	06054663          	bltz	a0,280e <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    27a6:	6785                	lui	a5,0x1
    27a8:	94be                	add	s1,s1,a5
    27aa:	40000613          	li	a2,1024
    27ae:	85a6                	mv	a1,s1
    27b0:	00003097          	auipc	ra,0x3
    27b4:	45e080e7          	jalr	1118(ra) # 5c0e <write>
    27b8:	862a                	mv	a2,a0
  if(n >= 0){
    27ba:	06054763          	bltz	a0,2828 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27be:	85a6                	mv	a1,s1
    27c0:	00004517          	auipc	a0,0x4
    27c4:	6e850513          	addi	a0,a0,1768 # 6ea8 <malloc+0xe88>
    27c8:	00003097          	auipc	ra,0x3
    27cc:	7a0080e7          	jalr	1952(ra) # 5f68 <printf>
    exit(1);
    27d0:	4505                	li	a0,1
    27d2:	00003097          	auipc	ra,0x3
    27d6:	41c080e7          	jalr	1052(ra) # 5bee <exit>
    printf("sbrk(rwsbrk) failed\n");
    27da:	00004517          	auipc	a0,0x4
    27de:	67650513          	addi	a0,a0,1654 # 6e50 <malloc+0xe30>
    27e2:	00003097          	auipc	ra,0x3
    27e6:	786080e7          	jalr	1926(ra) # 5f68 <printf>
    exit(1);
    27ea:	4505                	li	a0,1
    27ec:	00003097          	auipc	ra,0x3
    27f0:	402080e7          	jalr	1026(ra) # 5bee <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27f4:	00004517          	auipc	a0,0x4
    27f8:	67450513          	addi	a0,a0,1652 # 6e68 <malloc+0xe48>
    27fc:	00003097          	auipc	ra,0x3
    2800:	76c080e7          	jalr	1900(ra) # 5f68 <printf>
    exit(1);
    2804:	4505                	li	a0,1
    2806:	00003097          	auipc	ra,0x3
    280a:	3e8080e7          	jalr	1000(ra) # 5bee <exit>
    printf("open(rwsbrk) failed\n");
    280e:	00004517          	auipc	a0,0x4
    2812:	68250513          	addi	a0,a0,1666 # 6e90 <malloc+0xe70>
    2816:	00003097          	auipc	ra,0x3
    281a:	752080e7          	jalr	1874(ra) # 5f68 <printf>
    exit(1);
    281e:	4505                	li	a0,1
    2820:	00003097          	auipc	ra,0x3
    2824:	3ce080e7          	jalr	974(ra) # 5bee <exit>
  close(fd);
    2828:	854a                	mv	a0,s2
    282a:	00003097          	auipc	ra,0x3
    282e:	3ec080e7          	jalr	1004(ra) # 5c16 <close>
  unlink("rwsbrk");
    2832:	00004517          	auipc	a0,0x4
    2836:	65650513          	addi	a0,a0,1622 # 6e88 <malloc+0xe68>
    283a:	00003097          	auipc	ra,0x3
    283e:	404080e7          	jalr	1028(ra) # 5c3e <unlink>
  fd = open("README", O_RDONLY);
    2842:	4581                	li	a1,0
    2844:	00004517          	auipc	a0,0x4
    2848:	adc50513          	addi	a0,a0,-1316 # 6320 <malloc+0x300>
    284c:	00003097          	auipc	ra,0x3
    2850:	3e2080e7          	jalr	994(ra) # 5c2e <open>
    2854:	892a                	mv	s2,a0
  if(fd < 0){
    2856:	02054963          	bltz	a0,2888 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    285a:	4629                	li	a2,10
    285c:	85a6                	mv	a1,s1
    285e:	00003097          	auipc	ra,0x3
    2862:	3a8080e7          	jalr	936(ra) # 5c06 <read>
    2866:	862a                	mv	a2,a0
  if(n >= 0){
    2868:	02054d63          	bltz	a0,28a2 <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    286c:	85a6                	mv	a1,s1
    286e:	00004517          	auipc	a0,0x4
    2872:	66a50513          	addi	a0,a0,1642 # 6ed8 <malloc+0xeb8>
    2876:	00003097          	auipc	ra,0x3
    287a:	6f2080e7          	jalr	1778(ra) # 5f68 <printf>
    exit(1);
    287e:	4505                	li	a0,1
    2880:	00003097          	auipc	ra,0x3
    2884:	36e080e7          	jalr	878(ra) # 5bee <exit>
    printf("open(rwsbrk) failed\n");
    2888:	00004517          	auipc	a0,0x4
    288c:	60850513          	addi	a0,a0,1544 # 6e90 <malloc+0xe70>
    2890:	00003097          	auipc	ra,0x3
    2894:	6d8080e7          	jalr	1752(ra) # 5f68 <printf>
    exit(1);
    2898:	4505                	li	a0,1
    289a:	00003097          	auipc	ra,0x3
    289e:	354080e7          	jalr	852(ra) # 5bee <exit>
  close(fd);
    28a2:	854a                	mv	a0,s2
    28a4:	00003097          	auipc	ra,0x3
    28a8:	372080e7          	jalr	882(ra) # 5c16 <close>
  exit(0);
    28ac:	4501                	li	a0,0
    28ae:	00003097          	auipc	ra,0x3
    28b2:	340080e7          	jalr	832(ra) # 5bee <exit>

00000000000028b6 <sbrkbasic>:
{
    28b6:	7139                	addi	sp,sp,-64
    28b8:	fc06                	sd	ra,56(sp)
    28ba:	f822                	sd	s0,48(sp)
    28bc:	f426                	sd	s1,40(sp)
    28be:	f04a                	sd	s2,32(sp)
    28c0:	ec4e                	sd	s3,24(sp)
    28c2:	e852                	sd	s4,16(sp)
    28c4:	0080                	addi	s0,sp,64
    28c6:	8a2a                	mv	s4,a0
  pid = fork();
    28c8:	00003097          	auipc	ra,0x3
    28cc:	31e080e7          	jalr	798(ra) # 5be6 <fork>
  if(pid < 0){
    28d0:	02054c63          	bltz	a0,2908 <sbrkbasic+0x52>
  if(pid == 0){
    28d4:	ed21                	bnez	a0,292c <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28d6:	40000537          	lui	a0,0x40000
    28da:	00003097          	auipc	ra,0x3
    28de:	39c080e7          	jalr	924(ra) # 5c76 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28e2:	57fd                	li	a5,-1
    28e4:	02f50f63          	beq	a0,a5,2922 <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28e8:	400007b7          	lui	a5,0x40000
    28ec:	97aa                	add	a5,a5,a0
      *b = 99;
    28ee:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f2:	6705                	lui	a4,0x1
      *b = 99;
    28f4:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f8:	953a                	add	a0,a0,a4
    28fa:	fef51de3          	bne	a0,a5,28f4 <sbrkbasic+0x3e>
    exit(1);
    28fe:	4505                	li	a0,1
    2900:	00003097          	auipc	ra,0x3
    2904:	2ee080e7          	jalr	750(ra) # 5bee <exit>
    printf("fork failed in sbrkbasic\n");
    2908:	00004517          	auipc	a0,0x4
    290c:	5f850513          	addi	a0,a0,1528 # 6f00 <malloc+0xee0>
    2910:	00003097          	auipc	ra,0x3
    2914:	658080e7          	jalr	1624(ra) # 5f68 <printf>
    exit(1);
    2918:	4505                	li	a0,1
    291a:	00003097          	auipc	ra,0x3
    291e:	2d4080e7          	jalr	724(ra) # 5bee <exit>
      exit(0);
    2922:	4501                	li	a0,0
    2924:	00003097          	auipc	ra,0x3
    2928:	2ca080e7          	jalr	714(ra) # 5bee <exit>
  wait(&xstatus);
    292c:	fcc40513          	addi	a0,s0,-52
    2930:	00003097          	auipc	ra,0x3
    2934:	2c6080e7          	jalr	710(ra) # 5bf6 <wait>
  if(xstatus == 1){
    2938:	fcc42703          	lw	a4,-52(s0)
    293c:	4785                	li	a5,1
    293e:	00f70d63          	beq	a4,a5,2958 <sbrkbasic+0xa2>
  a = sbrk(0);
    2942:	4501                	li	a0,0
    2944:	00003097          	auipc	ra,0x3
    2948:	332080e7          	jalr	818(ra) # 5c76 <sbrk>
    294c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    294e:	4901                	li	s2,0
    2950:	6985                	lui	s3,0x1
    2952:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x36>
    2956:	a005                	j	2976 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2958:	85d2                	mv	a1,s4
    295a:	00004517          	auipc	a0,0x4
    295e:	5c650513          	addi	a0,a0,1478 # 6f20 <malloc+0xf00>
    2962:	00003097          	auipc	ra,0x3
    2966:	606080e7          	jalr	1542(ra) # 5f68 <printf>
    exit(1);
    296a:	4505                	li	a0,1
    296c:	00003097          	auipc	ra,0x3
    2970:	282080e7          	jalr	642(ra) # 5bee <exit>
    a = b + 1;
    2974:	84be                	mv	s1,a5
    b = sbrk(1);
    2976:	4505                	li	a0,1
    2978:	00003097          	auipc	ra,0x3
    297c:	2fe080e7          	jalr	766(ra) # 5c76 <sbrk>
    if(b != a){
    2980:	04951c63          	bne	a0,s1,29d8 <sbrkbasic+0x122>
    *b = 1;
    2984:	4785                	li	a5,1
    2986:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    298a:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    298e:	2905                	addiw	s2,s2,1
    2990:	ff3912e3          	bne	s2,s3,2974 <sbrkbasic+0xbe>
  pid = fork();
    2994:	00003097          	auipc	ra,0x3
    2998:	252080e7          	jalr	594(ra) # 5be6 <fork>
    299c:	892a                	mv	s2,a0
  if(pid < 0){
    299e:	04054e63          	bltz	a0,29fa <sbrkbasic+0x144>
  c = sbrk(1);
    29a2:	4505                	li	a0,1
    29a4:	00003097          	auipc	ra,0x3
    29a8:	2d2080e7          	jalr	722(ra) # 5c76 <sbrk>
  c = sbrk(1);
    29ac:	4505                	li	a0,1
    29ae:	00003097          	auipc	ra,0x3
    29b2:	2c8080e7          	jalr	712(ra) # 5c76 <sbrk>
  if(c != a + 1){
    29b6:	0489                	addi	s1,s1,2
    29b8:	04a48f63          	beq	s1,a0,2a16 <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29bc:	85d2                	mv	a1,s4
    29be:	00004517          	auipc	a0,0x4
    29c2:	5c250513          	addi	a0,a0,1474 # 6f80 <malloc+0xf60>
    29c6:	00003097          	auipc	ra,0x3
    29ca:	5a2080e7          	jalr	1442(ra) # 5f68 <printf>
    exit(1);
    29ce:	4505                	li	a0,1
    29d0:	00003097          	auipc	ra,0x3
    29d4:	21e080e7          	jalr	542(ra) # 5bee <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29d8:	872a                	mv	a4,a0
    29da:	86a6                	mv	a3,s1
    29dc:	864a                	mv	a2,s2
    29de:	85d2                	mv	a1,s4
    29e0:	00004517          	auipc	a0,0x4
    29e4:	56050513          	addi	a0,a0,1376 # 6f40 <malloc+0xf20>
    29e8:	00003097          	auipc	ra,0x3
    29ec:	580080e7          	jalr	1408(ra) # 5f68 <printf>
      exit(1);
    29f0:	4505                	li	a0,1
    29f2:	00003097          	auipc	ra,0x3
    29f6:	1fc080e7          	jalr	508(ra) # 5bee <exit>
    printf("%s: sbrk test fork failed\n", s);
    29fa:	85d2                	mv	a1,s4
    29fc:	00004517          	auipc	a0,0x4
    2a00:	56450513          	addi	a0,a0,1380 # 6f60 <malloc+0xf40>
    2a04:	00003097          	auipc	ra,0x3
    2a08:	564080e7          	jalr	1380(ra) # 5f68 <printf>
    exit(1);
    2a0c:	4505                	li	a0,1
    2a0e:	00003097          	auipc	ra,0x3
    2a12:	1e0080e7          	jalr	480(ra) # 5bee <exit>
  if(pid == 0)
    2a16:	00091763          	bnez	s2,2a24 <sbrkbasic+0x16e>
    exit(0);
    2a1a:	4501                	li	a0,0
    2a1c:	00003097          	auipc	ra,0x3
    2a20:	1d2080e7          	jalr	466(ra) # 5bee <exit>
  wait(&xstatus);
    2a24:	fcc40513          	addi	a0,s0,-52
    2a28:	00003097          	auipc	ra,0x3
    2a2c:	1ce080e7          	jalr	462(ra) # 5bf6 <wait>
  exit(xstatus);
    2a30:	fcc42503          	lw	a0,-52(s0)
    2a34:	00003097          	auipc	ra,0x3
    2a38:	1ba080e7          	jalr	442(ra) # 5bee <exit>

0000000000002a3c <sbrkmuch>:
{
    2a3c:	7179                	addi	sp,sp,-48
    2a3e:	f406                	sd	ra,40(sp)
    2a40:	f022                	sd	s0,32(sp)
    2a42:	ec26                	sd	s1,24(sp)
    2a44:	e84a                	sd	s2,16(sp)
    2a46:	e44e                	sd	s3,8(sp)
    2a48:	e052                	sd	s4,0(sp)
    2a4a:	1800                	addi	s0,sp,48
    2a4c:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a4e:	4501                	li	a0,0
    2a50:	00003097          	auipc	ra,0x3
    2a54:	226080e7          	jalr	550(ra) # 5c76 <sbrk>
    2a58:	892a                	mv	s2,a0
  a = sbrk(0);
    2a5a:	4501                	li	a0,0
    2a5c:	00003097          	auipc	ra,0x3
    2a60:	21a080e7          	jalr	538(ra) # 5c76 <sbrk>
    2a64:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a66:	06400537          	lui	a0,0x6400
    2a6a:	9d05                	subw	a0,a0,s1
    2a6c:	00003097          	auipc	ra,0x3
    2a70:	20a080e7          	jalr	522(ra) # 5c76 <sbrk>
  if (p != a) {
    2a74:	0ca49863          	bne	s1,a0,2b44 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a78:	4501                	li	a0,0
    2a7a:	00003097          	auipc	ra,0x3
    2a7e:	1fc080e7          	jalr	508(ra) # 5c76 <sbrk>
    2a82:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a84:	00a4f963          	bgeu	s1,a0,2a96 <sbrkmuch+0x5a>
    *pp = 1;
    2a88:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a8a:	6705                	lui	a4,0x1
    *pp = 1;
    2a8c:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a90:	94ba                	add	s1,s1,a4
    2a92:	fef4ede3          	bltu	s1,a5,2a8c <sbrkmuch+0x50>
  *lastaddr = 99;
    2a96:	064007b7          	lui	a5,0x6400
    2a9a:	06300713          	li	a4,99
    2a9e:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2aa2:	4501                	li	a0,0
    2aa4:	00003097          	auipc	ra,0x3
    2aa8:	1d2080e7          	jalr	466(ra) # 5c76 <sbrk>
    2aac:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2aae:	757d                	lui	a0,0xfffff
    2ab0:	00003097          	auipc	ra,0x3
    2ab4:	1c6080e7          	jalr	454(ra) # 5c76 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ab8:	57fd                	li	a5,-1
    2aba:	0af50363          	beq	a0,a5,2b60 <sbrkmuch+0x124>
  c = sbrk(0);
    2abe:	4501                	li	a0,0
    2ac0:	00003097          	auipc	ra,0x3
    2ac4:	1b6080e7          	jalr	438(ra) # 5c76 <sbrk>
  if(c != a - PGSIZE){
    2ac8:	77fd                	lui	a5,0xfffff
    2aca:	97a6                	add	a5,a5,s1
    2acc:	0af51863          	bne	a0,a5,2b7c <sbrkmuch+0x140>
  a = sbrk(0);
    2ad0:	4501                	li	a0,0
    2ad2:	00003097          	auipc	ra,0x3
    2ad6:	1a4080e7          	jalr	420(ra) # 5c76 <sbrk>
    2ada:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2adc:	6505                	lui	a0,0x1
    2ade:	00003097          	auipc	ra,0x3
    2ae2:	198080e7          	jalr	408(ra) # 5c76 <sbrk>
    2ae6:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2ae8:	0aa49a63          	bne	s1,a0,2b9c <sbrkmuch+0x160>
    2aec:	4501                	li	a0,0
    2aee:	00003097          	auipc	ra,0x3
    2af2:	188080e7          	jalr	392(ra) # 5c76 <sbrk>
    2af6:	6785                	lui	a5,0x1
    2af8:	97a6                	add	a5,a5,s1
    2afa:	0af51163          	bne	a0,a5,2b9c <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2afe:	064007b7          	lui	a5,0x6400
    2b02:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2b06:	06300793          	li	a5,99
    2b0a:	0af70963          	beq	a4,a5,2bbc <sbrkmuch+0x180>
  a = sbrk(0);
    2b0e:	4501                	li	a0,0
    2b10:	00003097          	auipc	ra,0x3
    2b14:	166080e7          	jalr	358(ra) # 5c76 <sbrk>
    2b18:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b1a:	4501                	li	a0,0
    2b1c:	00003097          	auipc	ra,0x3
    2b20:	15a080e7          	jalr	346(ra) # 5c76 <sbrk>
    2b24:	40a9053b          	subw	a0,s2,a0
    2b28:	00003097          	auipc	ra,0x3
    2b2c:	14e080e7          	jalr	334(ra) # 5c76 <sbrk>
  if(c != a){
    2b30:	0aa49463          	bne	s1,a0,2bd8 <sbrkmuch+0x19c>
}
    2b34:	70a2                	ld	ra,40(sp)
    2b36:	7402                	ld	s0,32(sp)
    2b38:	64e2                	ld	s1,24(sp)
    2b3a:	6942                	ld	s2,16(sp)
    2b3c:	69a2                	ld	s3,8(sp)
    2b3e:	6a02                	ld	s4,0(sp)
    2b40:	6145                	addi	sp,sp,48
    2b42:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b44:	85ce                	mv	a1,s3
    2b46:	00004517          	auipc	a0,0x4
    2b4a:	45a50513          	addi	a0,a0,1114 # 6fa0 <malloc+0xf80>
    2b4e:	00003097          	auipc	ra,0x3
    2b52:	41a080e7          	jalr	1050(ra) # 5f68 <printf>
    exit(1);
    2b56:	4505                	li	a0,1
    2b58:	00003097          	auipc	ra,0x3
    2b5c:	096080e7          	jalr	150(ra) # 5bee <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b60:	85ce                	mv	a1,s3
    2b62:	00004517          	auipc	a0,0x4
    2b66:	48650513          	addi	a0,a0,1158 # 6fe8 <malloc+0xfc8>
    2b6a:	00003097          	auipc	ra,0x3
    2b6e:	3fe080e7          	jalr	1022(ra) # 5f68 <printf>
    exit(1);
    2b72:	4505                	li	a0,1
    2b74:	00003097          	auipc	ra,0x3
    2b78:	07a080e7          	jalr	122(ra) # 5bee <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b7c:	86aa                	mv	a3,a0
    2b7e:	8626                	mv	a2,s1
    2b80:	85ce                	mv	a1,s3
    2b82:	00004517          	auipc	a0,0x4
    2b86:	48650513          	addi	a0,a0,1158 # 7008 <malloc+0xfe8>
    2b8a:	00003097          	auipc	ra,0x3
    2b8e:	3de080e7          	jalr	990(ra) # 5f68 <printf>
    exit(1);
    2b92:	4505                	li	a0,1
    2b94:	00003097          	auipc	ra,0x3
    2b98:	05a080e7          	jalr	90(ra) # 5bee <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b9c:	86d2                	mv	a3,s4
    2b9e:	8626                	mv	a2,s1
    2ba0:	85ce                	mv	a1,s3
    2ba2:	00004517          	auipc	a0,0x4
    2ba6:	4a650513          	addi	a0,a0,1190 # 7048 <malloc+0x1028>
    2baa:	00003097          	auipc	ra,0x3
    2bae:	3be080e7          	jalr	958(ra) # 5f68 <printf>
    exit(1);
    2bb2:	4505                	li	a0,1
    2bb4:	00003097          	auipc	ra,0x3
    2bb8:	03a080e7          	jalr	58(ra) # 5bee <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bbc:	85ce                	mv	a1,s3
    2bbe:	00004517          	auipc	a0,0x4
    2bc2:	4ba50513          	addi	a0,a0,1210 # 7078 <malloc+0x1058>
    2bc6:	00003097          	auipc	ra,0x3
    2bca:	3a2080e7          	jalr	930(ra) # 5f68 <printf>
    exit(1);
    2bce:	4505                	li	a0,1
    2bd0:	00003097          	auipc	ra,0x3
    2bd4:	01e080e7          	jalr	30(ra) # 5bee <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bd8:	86aa                	mv	a3,a0
    2bda:	8626                	mv	a2,s1
    2bdc:	85ce                	mv	a1,s3
    2bde:	00004517          	auipc	a0,0x4
    2be2:	4d250513          	addi	a0,a0,1234 # 70b0 <malloc+0x1090>
    2be6:	00003097          	auipc	ra,0x3
    2bea:	382080e7          	jalr	898(ra) # 5f68 <printf>
    exit(1);
    2bee:	4505                	li	a0,1
    2bf0:	00003097          	auipc	ra,0x3
    2bf4:	ffe080e7          	jalr	-2(ra) # 5bee <exit>

0000000000002bf8 <sbrkarg>:
{
    2bf8:	7179                	addi	sp,sp,-48
    2bfa:	f406                	sd	ra,40(sp)
    2bfc:	f022                	sd	s0,32(sp)
    2bfe:	ec26                	sd	s1,24(sp)
    2c00:	e84a                	sd	s2,16(sp)
    2c02:	e44e                	sd	s3,8(sp)
    2c04:	1800                	addi	s0,sp,48
    2c06:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c08:	6505                	lui	a0,0x1
    2c0a:	00003097          	auipc	ra,0x3
    2c0e:	06c080e7          	jalr	108(ra) # 5c76 <sbrk>
    2c12:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c14:	20100593          	li	a1,513
    2c18:	00004517          	auipc	a0,0x4
    2c1c:	4c050513          	addi	a0,a0,1216 # 70d8 <malloc+0x10b8>
    2c20:	00003097          	auipc	ra,0x3
    2c24:	00e080e7          	jalr	14(ra) # 5c2e <open>
    2c28:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c2a:	00004517          	auipc	a0,0x4
    2c2e:	4ae50513          	addi	a0,a0,1198 # 70d8 <malloc+0x10b8>
    2c32:	00003097          	auipc	ra,0x3
    2c36:	00c080e7          	jalr	12(ra) # 5c3e <unlink>
  if(fd < 0)  {
    2c3a:	0404c163          	bltz	s1,2c7c <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c3e:	6605                	lui	a2,0x1
    2c40:	85ca                	mv	a1,s2
    2c42:	8526                	mv	a0,s1
    2c44:	00003097          	auipc	ra,0x3
    2c48:	fca080e7          	jalr	-54(ra) # 5c0e <write>
    2c4c:	04054663          	bltz	a0,2c98 <sbrkarg+0xa0>
  close(fd);
    2c50:	8526                	mv	a0,s1
    2c52:	00003097          	auipc	ra,0x3
    2c56:	fc4080e7          	jalr	-60(ra) # 5c16 <close>
  a = sbrk(PGSIZE);
    2c5a:	6505                	lui	a0,0x1
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	01a080e7          	jalr	26(ra) # 5c76 <sbrk>
  if(pipe((int *) a) != 0){
    2c64:	00003097          	auipc	ra,0x3
    2c68:	f9a080e7          	jalr	-102(ra) # 5bfe <pipe>
    2c6c:	e521                	bnez	a0,2cb4 <sbrkarg+0xbc>
}
    2c6e:	70a2                	ld	ra,40(sp)
    2c70:	7402                	ld	s0,32(sp)
    2c72:	64e2                	ld	s1,24(sp)
    2c74:	6942                	ld	s2,16(sp)
    2c76:	69a2                	ld	s3,8(sp)
    2c78:	6145                	addi	sp,sp,48
    2c7a:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c7c:	85ce                	mv	a1,s3
    2c7e:	00004517          	auipc	a0,0x4
    2c82:	46250513          	addi	a0,a0,1122 # 70e0 <malloc+0x10c0>
    2c86:	00003097          	auipc	ra,0x3
    2c8a:	2e2080e7          	jalr	738(ra) # 5f68 <printf>
    exit(1);
    2c8e:	4505                	li	a0,1
    2c90:	00003097          	auipc	ra,0x3
    2c94:	f5e080e7          	jalr	-162(ra) # 5bee <exit>
    printf("%s: write sbrk failed\n", s);
    2c98:	85ce                	mv	a1,s3
    2c9a:	00004517          	auipc	a0,0x4
    2c9e:	45e50513          	addi	a0,a0,1118 # 70f8 <malloc+0x10d8>
    2ca2:	00003097          	auipc	ra,0x3
    2ca6:	2c6080e7          	jalr	710(ra) # 5f68 <printf>
    exit(1);
    2caa:	4505                	li	a0,1
    2cac:	00003097          	auipc	ra,0x3
    2cb0:	f42080e7          	jalr	-190(ra) # 5bee <exit>
    printf("%s: pipe() failed\n", s);
    2cb4:	85ce                	mv	a1,s3
    2cb6:	00004517          	auipc	a0,0x4
    2cba:	e2250513          	addi	a0,a0,-478 # 6ad8 <malloc+0xab8>
    2cbe:	00003097          	auipc	ra,0x3
    2cc2:	2aa080e7          	jalr	682(ra) # 5f68 <printf>
    exit(1);
    2cc6:	4505                	li	a0,1
    2cc8:	00003097          	auipc	ra,0x3
    2ccc:	f26080e7          	jalr	-218(ra) # 5bee <exit>

0000000000002cd0 <argptest>:
{
    2cd0:	1101                	addi	sp,sp,-32
    2cd2:	ec06                	sd	ra,24(sp)
    2cd4:	e822                	sd	s0,16(sp)
    2cd6:	e426                	sd	s1,8(sp)
    2cd8:	e04a                	sd	s2,0(sp)
    2cda:	1000                	addi	s0,sp,32
    2cdc:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cde:	4581                	li	a1,0
    2ce0:	00004517          	auipc	a0,0x4
    2ce4:	43050513          	addi	a0,a0,1072 # 7110 <malloc+0x10f0>
    2ce8:	00003097          	auipc	ra,0x3
    2cec:	f46080e7          	jalr	-186(ra) # 5c2e <open>
  if (fd < 0) {
    2cf0:	02054b63          	bltz	a0,2d26 <argptest+0x56>
    2cf4:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cf6:	4501                	li	a0,0
    2cf8:	00003097          	auipc	ra,0x3
    2cfc:	f7e080e7          	jalr	-130(ra) # 5c76 <sbrk>
    2d00:	567d                	li	a2,-1
    2d02:	fff50593          	addi	a1,a0,-1
    2d06:	8526                	mv	a0,s1
    2d08:	00003097          	auipc	ra,0x3
    2d0c:	efe080e7          	jalr	-258(ra) # 5c06 <read>
  close(fd);
    2d10:	8526                	mv	a0,s1
    2d12:	00003097          	auipc	ra,0x3
    2d16:	f04080e7          	jalr	-252(ra) # 5c16 <close>
}
    2d1a:	60e2                	ld	ra,24(sp)
    2d1c:	6442                	ld	s0,16(sp)
    2d1e:	64a2                	ld	s1,8(sp)
    2d20:	6902                	ld	s2,0(sp)
    2d22:	6105                	addi	sp,sp,32
    2d24:	8082                	ret
    printf("%s: open failed\n", s);
    2d26:	85ca                	mv	a1,s2
    2d28:	00004517          	auipc	a0,0x4
    2d2c:	cc050513          	addi	a0,a0,-832 # 69e8 <malloc+0x9c8>
    2d30:	00003097          	auipc	ra,0x3
    2d34:	238080e7          	jalr	568(ra) # 5f68 <printf>
    exit(1);
    2d38:	4505                	li	a0,1
    2d3a:	00003097          	auipc	ra,0x3
    2d3e:	eb4080e7          	jalr	-332(ra) # 5bee <exit>

0000000000002d42 <sbrkbugs>:
{
    2d42:	1141                	addi	sp,sp,-16
    2d44:	e406                	sd	ra,8(sp)
    2d46:	e022                	sd	s0,0(sp)
    2d48:	0800                	addi	s0,sp,16
  int pid = fork();
    2d4a:	00003097          	auipc	ra,0x3
    2d4e:	e9c080e7          	jalr	-356(ra) # 5be6 <fork>
  if(pid < 0){
    2d52:	02054263          	bltz	a0,2d76 <sbrkbugs+0x34>
  if(pid == 0){
    2d56:	ed0d                	bnez	a0,2d90 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d58:	00003097          	auipc	ra,0x3
    2d5c:	f1e080e7          	jalr	-226(ra) # 5c76 <sbrk>
    sbrk(-sz);
    2d60:	40a0053b          	negw	a0,a0
    2d64:	00003097          	auipc	ra,0x3
    2d68:	f12080e7          	jalr	-238(ra) # 5c76 <sbrk>
    exit(0);
    2d6c:	4501                	li	a0,0
    2d6e:	00003097          	auipc	ra,0x3
    2d72:	e80080e7          	jalr	-384(ra) # 5bee <exit>
    printf("fork failed\n");
    2d76:	00004517          	auipc	a0,0x4
    2d7a:	06250513          	addi	a0,a0,98 # 6dd8 <malloc+0xdb8>
    2d7e:	00003097          	auipc	ra,0x3
    2d82:	1ea080e7          	jalr	490(ra) # 5f68 <printf>
    exit(1);
    2d86:	4505                	li	a0,1
    2d88:	00003097          	auipc	ra,0x3
    2d8c:	e66080e7          	jalr	-410(ra) # 5bee <exit>
  wait(0);
    2d90:	4501                	li	a0,0
    2d92:	00003097          	auipc	ra,0x3
    2d96:	e64080e7          	jalr	-412(ra) # 5bf6 <wait>
  pid = fork();
    2d9a:	00003097          	auipc	ra,0x3
    2d9e:	e4c080e7          	jalr	-436(ra) # 5be6 <fork>
  if(pid < 0){
    2da2:	02054563          	bltz	a0,2dcc <sbrkbugs+0x8a>
  if(pid == 0){
    2da6:	e121                	bnez	a0,2de6 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2da8:	00003097          	auipc	ra,0x3
    2dac:	ece080e7          	jalr	-306(ra) # 5c76 <sbrk>
    sbrk(-(sz - 3500));
    2db0:	6785                	lui	a5,0x1
    2db2:	dac7879b          	addiw	a5,a5,-596 # dac <unlinkread+0x66>
    2db6:	40a7853b          	subw	a0,a5,a0
    2dba:	00003097          	auipc	ra,0x3
    2dbe:	ebc080e7          	jalr	-324(ra) # 5c76 <sbrk>
    exit(0);
    2dc2:	4501                	li	a0,0
    2dc4:	00003097          	auipc	ra,0x3
    2dc8:	e2a080e7          	jalr	-470(ra) # 5bee <exit>
    printf("fork failed\n");
    2dcc:	00004517          	auipc	a0,0x4
    2dd0:	00c50513          	addi	a0,a0,12 # 6dd8 <malloc+0xdb8>
    2dd4:	00003097          	auipc	ra,0x3
    2dd8:	194080e7          	jalr	404(ra) # 5f68 <printf>
    exit(1);
    2ddc:	4505                	li	a0,1
    2dde:	00003097          	auipc	ra,0x3
    2de2:	e10080e7          	jalr	-496(ra) # 5bee <exit>
  wait(0);
    2de6:	4501                	li	a0,0
    2de8:	00003097          	auipc	ra,0x3
    2dec:	e0e080e7          	jalr	-498(ra) # 5bf6 <wait>
  pid = fork();
    2df0:	00003097          	auipc	ra,0x3
    2df4:	df6080e7          	jalr	-522(ra) # 5be6 <fork>
  if(pid < 0){
    2df8:	02054a63          	bltz	a0,2e2c <sbrkbugs+0xea>
  if(pid == 0){
    2dfc:	e529                	bnez	a0,2e46 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2dfe:	00003097          	auipc	ra,0x3
    2e02:	e78080e7          	jalr	-392(ra) # 5c76 <sbrk>
    2e06:	67ad                	lui	a5,0xb
    2e08:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    2e0c:	40a7853b          	subw	a0,a5,a0
    2e10:	00003097          	auipc	ra,0x3
    2e14:	e66080e7          	jalr	-410(ra) # 5c76 <sbrk>
    sbrk(-10);
    2e18:	5559                	li	a0,-10
    2e1a:	00003097          	auipc	ra,0x3
    2e1e:	e5c080e7          	jalr	-420(ra) # 5c76 <sbrk>
    exit(0);
    2e22:	4501                	li	a0,0
    2e24:	00003097          	auipc	ra,0x3
    2e28:	dca080e7          	jalr	-566(ra) # 5bee <exit>
    printf("fork failed\n");
    2e2c:	00004517          	auipc	a0,0x4
    2e30:	fac50513          	addi	a0,a0,-84 # 6dd8 <malloc+0xdb8>
    2e34:	00003097          	auipc	ra,0x3
    2e38:	134080e7          	jalr	308(ra) # 5f68 <printf>
    exit(1);
    2e3c:	4505                	li	a0,1
    2e3e:	00003097          	auipc	ra,0x3
    2e42:	db0080e7          	jalr	-592(ra) # 5bee <exit>
  wait(0);
    2e46:	4501                	li	a0,0
    2e48:	00003097          	auipc	ra,0x3
    2e4c:	dae080e7          	jalr	-594(ra) # 5bf6 <wait>
  exit(0);
    2e50:	4501                	li	a0,0
    2e52:	00003097          	auipc	ra,0x3
    2e56:	d9c080e7          	jalr	-612(ra) # 5bee <exit>

0000000000002e5a <sbrklast>:
{
    2e5a:	7179                	addi	sp,sp,-48
    2e5c:	f406                	sd	ra,40(sp)
    2e5e:	f022                	sd	s0,32(sp)
    2e60:	ec26                	sd	s1,24(sp)
    2e62:	e84a                	sd	s2,16(sp)
    2e64:	e44e                	sd	s3,8(sp)
    2e66:	e052                	sd	s4,0(sp)
    2e68:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e6a:	4501                	li	a0,0
    2e6c:	00003097          	auipc	ra,0x3
    2e70:	e0a080e7          	jalr	-502(ra) # 5c76 <sbrk>
  if((top % 4096) != 0)
    2e74:	03451793          	slli	a5,a0,0x34
    2e78:	ebd9                	bnez	a5,2f0e <sbrklast+0xb4>
  sbrk(4096);
    2e7a:	6505                	lui	a0,0x1
    2e7c:	00003097          	auipc	ra,0x3
    2e80:	dfa080e7          	jalr	-518(ra) # 5c76 <sbrk>
  sbrk(10);
    2e84:	4529                	li	a0,10
    2e86:	00003097          	auipc	ra,0x3
    2e8a:	df0080e7          	jalr	-528(ra) # 5c76 <sbrk>
  sbrk(-20);
    2e8e:	5531                	li	a0,-20
    2e90:	00003097          	auipc	ra,0x3
    2e94:	de6080e7          	jalr	-538(ra) # 5c76 <sbrk>
  top = (uint64) sbrk(0);
    2e98:	4501                	li	a0,0
    2e9a:	00003097          	auipc	ra,0x3
    2e9e:	ddc080e7          	jalr	-548(ra) # 5c76 <sbrk>
    2ea2:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2ea4:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xc4>
  p[0] = 'x';
    2ea8:	07800a13          	li	s4,120
    2eac:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2eb0:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eb4:	20200593          	li	a1,514
    2eb8:	854a                	mv	a0,s2
    2eba:	00003097          	auipc	ra,0x3
    2ebe:	d74080e7          	jalr	-652(ra) # 5c2e <open>
    2ec2:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ec4:	4605                	li	a2,1
    2ec6:	85ca                	mv	a1,s2
    2ec8:	00003097          	auipc	ra,0x3
    2ecc:	d46080e7          	jalr	-698(ra) # 5c0e <write>
  close(fd);
    2ed0:	854e                	mv	a0,s3
    2ed2:	00003097          	auipc	ra,0x3
    2ed6:	d44080e7          	jalr	-700(ra) # 5c16 <close>
  fd = open(p, O_RDWR);
    2eda:	4589                	li	a1,2
    2edc:	854a                	mv	a0,s2
    2ede:	00003097          	auipc	ra,0x3
    2ee2:	d50080e7          	jalr	-688(ra) # 5c2e <open>
  p[0] = '\0';
    2ee6:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2eea:	4605                	li	a2,1
    2eec:	85ca                	mv	a1,s2
    2eee:	00003097          	auipc	ra,0x3
    2ef2:	d18080e7          	jalr	-744(ra) # 5c06 <read>
  if(p[0] != 'x')
    2ef6:	fc04c783          	lbu	a5,-64(s1)
    2efa:	03479463          	bne	a5,s4,2f22 <sbrklast+0xc8>
}
    2efe:	70a2                	ld	ra,40(sp)
    2f00:	7402                	ld	s0,32(sp)
    2f02:	64e2                	ld	s1,24(sp)
    2f04:	6942                	ld	s2,16(sp)
    2f06:	69a2                	ld	s3,8(sp)
    2f08:	6a02                	ld	s4,0(sp)
    2f0a:	6145                	addi	sp,sp,48
    2f0c:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f0e:	0347d513          	srli	a0,a5,0x34
    2f12:	6785                	lui	a5,0x1
    2f14:	40a7853b          	subw	a0,a5,a0
    2f18:	00003097          	auipc	ra,0x3
    2f1c:	d5e080e7          	jalr	-674(ra) # 5c76 <sbrk>
    2f20:	bfa9                	j	2e7a <sbrklast+0x20>
    exit(1);
    2f22:	4505                	li	a0,1
    2f24:	00003097          	auipc	ra,0x3
    2f28:	cca080e7          	jalr	-822(ra) # 5bee <exit>

0000000000002f2c <sbrk8000>:
{
    2f2c:	1141                	addi	sp,sp,-16
    2f2e:	e406                	sd	ra,8(sp)
    2f30:	e022                	sd	s0,0(sp)
    2f32:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f34:	80000537          	lui	a0,0x80000
    2f38:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    2f3a:	00003097          	auipc	ra,0x3
    2f3e:	d3c080e7          	jalr	-708(ra) # 5c76 <sbrk>
  volatile char *top = sbrk(0);
    2f42:	4501                	li	a0,0
    2f44:	00003097          	auipc	ra,0x3
    2f48:	d32080e7          	jalr	-718(ra) # 5c76 <sbrk>
  *(top-1) = *(top-1) + 1;
    2f4c:	fff54783          	lbu	a5,-1(a0)
    2f50:	2785                	addiw	a5,a5,1 # 1001 <linktest+0x105>
    2f52:	0ff7f793          	zext.b	a5,a5
    2f56:	fef50fa3          	sb	a5,-1(a0)
}
    2f5a:	60a2                	ld	ra,8(sp)
    2f5c:	6402                	ld	s0,0(sp)
    2f5e:	0141                	addi	sp,sp,16
    2f60:	8082                	ret

0000000000002f62 <execout>:
{
    2f62:	715d                	addi	sp,sp,-80
    2f64:	e486                	sd	ra,72(sp)
    2f66:	e0a2                	sd	s0,64(sp)
    2f68:	fc26                	sd	s1,56(sp)
    2f6a:	f84a                	sd	s2,48(sp)
    2f6c:	f44e                	sd	s3,40(sp)
    2f6e:	f052                	sd	s4,32(sp)
    2f70:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f72:	4901                	li	s2,0
    2f74:	49bd                	li	s3,15
    int pid = fork();
    2f76:	00003097          	auipc	ra,0x3
    2f7a:	c70080e7          	jalr	-912(ra) # 5be6 <fork>
    2f7e:	84aa                	mv	s1,a0
    if(pid < 0){
    2f80:	02054063          	bltz	a0,2fa0 <execout+0x3e>
    } else if(pid == 0){
    2f84:	c91d                	beqz	a0,2fba <execout+0x58>
      wait((int*)0);
    2f86:	4501                	li	a0,0
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	c6e080e7          	jalr	-914(ra) # 5bf6 <wait>
  for(int avail = 0; avail < 15; avail++){
    2f90:	2905                	addiw	s2,s2,1
    2f92:	ff3912e3          	bne	s2,s3,2f76 <execout+0x14>
  exit(0);
    2f96:	4501                	li	a0,0
    2f98:	00003097          	auipc	ra,0x3
    2f9c:	c56080e7          	jalr	-938(ra) # 5bee <exit>
      printf("fork failed\n");
    2fa0:	00004517          	auipc	a0,0x4
    2fa4:	e3850513          	addi	a0,a0,-456 # 6dd8 <malloc+0xdb8>
    2fa8:	00003097          	auipc	ra,0x3
    2fac:	fc0080e7          	jalr	-64(ra) # 5f68 <printf>
      exit(1);
    2fb0:	4505                	li	a0,1
    2fb2:	00003097          	auipc	ra,0x3
    2fb6:	c3c080e7          	jalr	-964(ra) # 5bee <exit>
        if(a == 0xffffffffffffffffLL)
    2fba:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fbc:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fbe:	6505                	lui	a0,0x1
    2fc0:	00003097          	auipc	ra,0x3
    2fc4:	cb6080e7          	jalr	-842(ra) # 5c76 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fc8:	01350763          	beq	a0,s3,2fd6 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fcc:	6785                	lui	a5,0x1
    2fce:	97aa                	add	a5,a5,a0
    2fd0:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0x103>
      while(1){
    2fd4:	b7ed                	j	2fbe <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fd6:	01205a63          	blez	s2,2fea <execout+0x88>
        sbrk(-4096);
    2fda:	757d                	lui	a0,0xfffff
    2fdc:	00003097          	auipc	ra,0x3
    2fe0:	c9a080e7          	jalr	-870(ra) # 5c76 <sbrk>
      for(int i = 0; i < avail; i++)
    2fe4:	2485                	addiw	s1,s1,1
    2fe6:	ff249ae3          	bne	s1,s2,2fda <execout+0x78>
      close(1);
    2fea:	4505                	li	a0,1
    2fec:	00003097          	auipc	ra,0x3
    2ff0:	c2a080e7          	jalr	-982(ra) # 5c16 <close>
      char *args[] = { "echo", "x", 0 };
    2ff4:	00003517          	auipc	a0,0x3
    2ff8:	15450513          	addi	a0,a0,340 # 6148 <malloc+0x128>
    2ffc:	faa43c23          	sd	a0,-72(s0)
    3000:	00003797          	auipc	a5,0x3
    3004:	1b878793          	addi	a5,a5,440 # 61b8 <malloc+0x198>
    3008:	fcf43023          	sd	a5,-64(s0)
    300c:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3010:	fb840593          	addi	a1,s0,-72
    3014:	00003097          	auipc	ra,0x3
    3018:	c12080e7          	jalr	-1006(ra) # 5c26 <exec>
      exit(0);
    301c:	4501                	li	a0,0
    301e:	00003097          	auipc	ra,0x3
    3022:	bd0080e7          	jalr	-1072(ra) # 5bee <exit>

0000000000003026 <fourteen>:
{
    3026:	1101                	addi	sp,sp,-32
    3028:	ec06                	sd	ra,24(sp)
    302a:	e822                	sd	s0,16(sp)
    302c:	e426                	sd	s1,8(sp)
    302e:	1000                	addi	s0,sp,32
    3030:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    3032:	00004517          	auipc	a0,0x4
    3036:	2b650513          	addi	a0,a0,694 # 72e8 <malloc+0x12c8>
    303a:	00003097          	auipc	ra,0x3
    303e:	c1c080e7          	jalr	-996(ra) # 5c56 <mkdir>
    3042:	e165                	bnez	a0,3122 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    3044:	00004517          	auipc	a0,0x4
    3048:	0fc50513          	addi	a0,a0,252 # 7140 <malloc+0x1120>
    304c:	00003097          	auipc	ra,0x3
    3050:	c0a080e7          	jalr	-1014(ra) # 5c56 <mkdir>
    3054:	e56d                	bnez	a0,313e <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3056:	20000593          	li	a1,512
    305a:	00004517          	auipc	a0,0x4
    305e:	13e50513          	addi	a0,a0,318 # 7198 <malloc+0x1178>
    3062:	00003097          	auipc	ra,0x3
    3066:	bcc080e7          	jalr	-1076(ra) # 5c2e <open>
  if(fd < 0){
    306a:	0e054863          	bltz	a0,315a <fourteen+0x134>
  close(fd);
    306e:	00003097          	auipc	ra,0x3
    3072:	ba8080e7          	jalr	-1112(ra) # 5c16 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3076:	4581                	li	a1,0
    3078:	00004517          	auipc	a0,0x4
    307c:	19850513          	addi	a0,a0,408 # 7210 <malloc+0x11f0>
    3080:	00003097          	auipc	ra,0x3
    3084:	bae080e7          	jalr	-1106(ra) # 5c2e <open>
  if(fd < 0){
    3088:	0e054763          	bltz	a0,3176 <fourteen+0x150>
  close(fd);
    308c:	00003097          	auipc	ra,0x3
    3090:	b8a080e7          	jalr	-1142(ra) # 5c16 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    3094:	00004517          	auipc	a0,0x4
    3098:	1ec50513          	addi	a0,a0,492 # 7280 <malloc+0x1260>
    309c:	00003097          	auipc	ra,0x3
    30a0:	bba080e7          	jalr	-1094(ra) # 5c56 <mkdir>
    30a4:	c57d                	beqz	a0,3192 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    30a6:	00004517          	auipc	a0,0x4
    30aa:	23250513          	addi	a0,a0,562 # 72d8 <malloc+0x12b8>
    30ae:	00003097          	auipc	ra,0x3
    30b2:	ba8080e7          	jalr	-1112(ra) # 5c56 <mkdir>
    30b6:	cd65                	beqz	a0,31ae <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30b8:	00004517          	auipc	a0,0x4
    30bc:	22050513          	addi	a0,a0,544 # 72d8 <malloc+0x12b8>
    30c0:	00003097          	auipc	ra,0x3
    30c4:	b7e080e7          	jalr	-1154(ra) # 5c3e <unlink>
  unlink("12345678901234/12345678901234");
    30c8:	00004517          	auipc	a0,0x4
    30cc:	1b850513          	addi	a0,a0,440 # 7280 <malloc+0x1260>
    30d0:	00003097          	auipc	ra,0x3
    30d4:	b6e080e7          	jalr	-1170(ra) # 5c3e <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30d8:	00004517          	auipc	a0,0x4
    30dc:	13850513          	addi	a0,a0,312 # 7210 <malloc+0x11f0>
    30e0:	00003097          	auipc	ra,0x3
    30e4:	b5e080e7          	jalr	-1186(ra) # 5c3e <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30e8:	00004517          	auipc	a0,0x4
    30ec:	0b050513          	addi	a0,a0,176 # 7198 <malloc+0x1178>
    30f0:	00003097          	auipc	ra,0x3
    30f4:	b4e080e7          	jalr	-1202(ra) # 5c3e <unlink>
  unlink("12345678901234/123456789012345");
    30f8:	00004517          	auipc	a0,0x4
    30fc:	04850513          	addi	a0,a0,72 # 7140 <malloc+0x1120>
    3100:	00003097          	auipc	ra,0x3
    3104:	b3e080e7          	jalr	-1218(ra) # 5c3e <unlink>
  unlink("12345678901234");
    3108:	00004517          	auipc	a0,0x4
    310c:	1e050513          	addi	a0,a0,480 # 72e8 <malloc+0x12c8>
    3110:	00003097          	auipc	ra,0x3
    3114:	b2e080e7          	jalr	-1234(ra) # 5c3e <unlink>
}
    3118:	60e2                	ld	ra,24(sp)
    311a:	6442                	ld	s0,16(sp)
    311c:	64a2                	ld	s1,8(sp)
    311e:	6105                	addi	sp,sp,32
    3120:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3122:	85a6                	mv	a1,s1
    3124:	00004517          	auipc	a0,0x4
    3128:	ff450513          	addi	a0,a0,-12 # 7118 <malloc+0x10f8>
    312c:	00003097          	auipc	ra,0x3
    3130:	e3c080e7          	jalr	-452(ra) # 5f68 <printf>
    exit(1);
    3134:	4505                	li	a0,1
    3136:	00003097          	auipc	ra,0x3
    313a:	ab8080e7          	jalr	-1352(ra) # 5bee <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    313e:	85a6                	mv	a1,s1
    3140:	00004517          	auipc	a0,0x4
    3144:	02050513          	addi	a0,a0,32 # 7160 <malloc+0x1140>
    3148:	00003097          	auipc	ra,0x3
    314c:	e20080e7          	jalr	-480(ra) # 5f68 <printf>
    exit(1);
    3150:	4505                	li	a0,1
    3152:	00003097          	auipc	ra,0x3
    3156:	a9c080e7          	jalr	-1380(ra) # 5bee <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    315a:	85a6                	mv	a1,s1
    315c:	00004517          	auipc	a0,0x4
    3160:	06c50513          	addi	a0,a0,108 # 71c8 <malloc+0x11a8>
    3164:	00003097          	auipc	ra,0x3
    3168:	e04080e7          	jalr	-508(ra) # 5f68 <printf>
    exit(1);
    316c:	4505                	li	a0,1
    316e:	00003097          	auipc	ra,0x3
    3172:	a80080e7          	jalr	-1408(ra) # 5bee <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3176:	85a6                	mv	a1,s1
    3178:	00004517          	auipc	a0,0x4
    317c:	0c850513          	addi	a0,a0,200 # 7240 <malloc+0x1220>
    3180:	00003097          	auipc	ra,0x3
    3184:	de8080e7          	jalr	-536(ra) # 5f68 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	00003097          	auipc	ra,0x3
    318e:	a64080e7          	jalr	-1436(ra) # 5bee <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3192:	85a6                	mv	a1,s1
    3194:	00004517          	auipc	a0,0x4
    3198:	10c50513          	addi	a0,a0,268 # 72a0 <malloc+0x1280>
    319c:	00003097          	auipc	ra,0x3
    31a0:	dcc080e7          	jalr	-564(ra) # 5f68 <printf>
    exit(1);
    31a4:	4505                	li	a0,1
    31a6:	00003097          	auipc	ra,0x3
    31aa:	a48080e7          	jalr	-1464(ra) # 5bee <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31ae:	85a6                	mv	a1,s1
    31b0:	00004517          	auipc	a0,0x4
    31b4:	14850513          	addi	a0,a0,328 # 72f8 <malloc+0x12d8>
    31b8:	00003097          	auipc	ra,0x3
    31bc:	db0080e7          	jalr	-592(ra) # 5f68 <printf>
    exit(1);
    31c0:	4505                	li	a0,1
    31c2:	00003097          	auipc	ra,0x3
    31c6:	a2c080e7          	jalr	-1492(ra) # 5bee <exit>

00000000000031ca <diskfull>:
{
    31ca:	b8010113          	addi	sp,sp,-1152
    31ce:	46113c23          	sd	ra,1144(sp)
    31d2:	46813823          	sd	s0,1136(sp)
    31d6:	46913423          	sd	s1,1128(sp)
    31da:	47213023          	sd	s2,1120(sp)
    31de:	45313c23          	sd	s3,1112(sp)
    31e2:	45413823          	sd	s4,1104(sp)
    31e6:	45513423          	sd	s5,1096(sp)
    31ea:	45613023          	sd	s6,1088(sp)
    31ee:	43713c23          	sd	s7,1080(sp)
    31f2:	43813823          	sd	s8,1072(sp)
    31f6:	43913423          	sd	s9,1064(sp)
    31fa:	48010413          	addi	s0,sp,1152
    31fe:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    3200:	00004517          	auipc	a0,0x4
    3204:	13050513          	addi	a0,a0,304 # 7330 <malloc+0x1310>
    3208:	00003097          	auipc	ra,0x3
    320c:	a36080e7          	jalr	-1482(ra) # 5c3e <unlink>
    3210:	03000993          	li	s3,48
    name[0] = 'b';
    3214:	06200b13          	li	s6,98
    name[1] = 'i';
    3218:	06900a93          	li	s5,105
    name[2] = 'g';
    321c:	06700a13          	li	s4,103
    3220:	10c00b93          	li	s7,268
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    3224:	07f00c13          	li	s8,127
    3228:	a269                	j	33b2 <diskfull+0x1e8>
      printf("%s: could not create file %s\n", s, name);
    322a:	b8040613          	addi	a2,s0,-1152
    322e:	85e6                	mv	a1,s9
    3230:	00004517          	auipc	a0,0x4
    3234:	11050513          	addi	a0,a0,272 # 7340 <malloc+0x1320>
    3238:	00003097          	auipc	ra,0x3
    323c:	d30080e7          	jalr	-720(ra) # 5f68 <printf>
      break;
    3240:	a819                	j	3256 <diskfull+0x8c>
        close(fd);
    3242:	854a                	mv	a0,s2
    3244:	00003097          	auipc	ra,0x3
    3248:	9d2080e7          	jalr	-1582(ra) # 5c16 <close>
    close(fd);
    324c:	854a                	mv	a0,s2
    324e:	00003097          	auipc	ra,0x3
    3252:	9c8080e7          	jalr	-1592(ra) # 5c16 <close>
  for(int i = 0; i < nzz; i++){
    3256:	4481                	li	s1,0
    name[0] = 'z';
    3258:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    325c:	08000993          	li	s3,128
    name[0] = 'z';
    3260:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    3264:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    3268:	41f4d71b          	sraiw	a4,s1,0x1f
    326c:	01b7571b          	srliw	a4,a4,0x1b
    3270:	009707bb          	addw	a5,a4,s1
    3274:	4057d69b          	sraiw	a3,a5,0x5
    3278:	0306869b          	addiw	a3,a3,48
    327c:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    3280:	8bfd                	andi	a5,a5,31
    3282:	9f99                	subw	a5,a5,a4
    3284:	0307879b          	addiw	a5,a5,48
    3288:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    328c:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    3290:	ba040513          	addi	a0,s0,-1120
    3294:	00003097          	auipc	ra,0x3
    3298:	9aa080e7          	jalr	-1622(ra) # 5c3e <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    329c:	60200593          	li	a1,1538
    32a0:	ba040513          	addi	a0,s0,-1120
    32a4:	00003097          	auipc	ra,0x3
    32a8:	98a080e7          	jalr	-1654(ra) # 5c2e <open>
    if(fd < 0)
    32ac:	00054963          	bltz	a0,32be <diskfull+0xf4>
    close(fd);
    32b0:	00003097          	auipc	ra,0x3
    32b4:	966080e7          	jalr	-1690(ra) # 5c16 <close>
  for(int i = 0; i < nzz; i++){
    32b8:	2485                	addiw	s1,s1,1
    32ba:	fb3493e3          	bne	s1,s3,3260 <diskfull+0x96>
  if(mkdir("diskfulldir") == 0)
    32be:	00004517          	auipc	a0,0x4
    32c2:	07250513          	addi	a0,a0,114 # 7330 <malloc+0x1310>
    32c6:	00003097          	auipc	ra,0x3
    32ca:	990080e7          	jalr	-1648(ra) # 5c56 <mkdir>
    32ce:	12050e63          	beqz	a0,340a <diskfull+0x240>
  unlink("diskfulldir");
    32d2:	00004517          	auipc	a0,0x4
    32d6:	05e50513          	addi	a0,a0,94 # 7330 <malloc+0x1310>
    32da:	00003097          	auipc	ra,0x3
    32de:	964080e7          	jalr	-1692(ra) # 5c3e <unlink>
  for(int i = 0; i < nzz; i++){
    32e2:	4481                	li	s1,0
    name[0] = 'z';
    32e4:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32e8:	08000993          	li	s3,128
    name[0] = 'z';
    32ec:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    32f0:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    32f4:	41f4d71b          	sraiw	a4,s1,0x1f
    32f8:	01b7571b          	srliw	a4,a4,0x1b
    32fc:	009707bb          	addw	a5,a4,s1
    3300:	4057d69b          	sraiw	a3,a5,0x5
    3304:	0306869b          	addiw	a3,a3,48
    3308:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    330c:	8bfd                	andi	a5,a5,31
    330e:	9f99                	subw	a5,a5,a4
    3310:	0307879b          	addiw	a5,a5,48
    3314:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    3318:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    331c:	ba040513          	addi	a0,s0,-1120
    3320:	00003097          	auipc	ra,0x3
    3324:	91e080e7          	jalr	-1762(ra) # 5c3e <unlink>
  for(int i = 0; i < nzz; i++){
    3328:	2485                	addiw	s1,s1,1
    332a:	fd3491e3          	bne	s1,s3,32ec <diskfull+0x122>
    332e:	03000493          	li	s1,48
    name[0] = 'b';
    3332:	06200a93          	li	s5,98
    name[1] = 'i';
    3336:	06900a13          	li	s4,105
    name[2] = 'g';
    333a:	06700993          	li	s3,103
  for(int i = 0; '0' + i < 0177; i++){
    333e:	07f00913          	li	s2,127
    name[0] = 'b';
    3342:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    3346:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    334a:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    334e:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    3352:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    3356:	ba040513          	addi	a0,s0,-1120
    335a:	00003097          	auipc	ra,0x3
    335e:	8e4080e7          	jalr	-1820(ra) # 5c3e <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    3362:	2485                	addiw	s1,s1,1
    3364:	0ff4f493          	zext.b	s1,s1
    3368:	fd249de3          	bne	s1,s2,3342 <diskfull+0x178>
}
    336c:	47813083          	ld	ra,1144(sp)
    3370:	47013403          	ld	s0,1136(sp)
    3374:	46813483          	ld	s1,1128(sp)
    3378:	46013903          	ld	s2,1120(sp)
    337c:	45813983          	ld	s3,1112(sp)
    3380:	45013a03          	ld	s4,1104(sp)
    3384:	44813a83          	ld	s5,1096(sp)
    3388:	44013b03          	ld	s6,1088(sp)
    338c:	43813b83          	ld	s7,1080(sp)
    3390:	43013c03          	ld	s8,1072(sp)
    3394:	42813c83          	ld	s9,1064(sp)
    3398:	48010113          	addi	sp,sp,1152
    339c:	8082                	ret
    close(fd);
    339e:	854a                	mv	a0,s2
    33a0:	00003097          	auipc	ra,0x3
    33a4:	876080e7          	jalr	-1930(ra) # 5c16 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    33a8:	2985                	addiw	s3,s3,1
    33aa:	0ff9f993          	zext.b	s3,s3
    33ae:	eb8984e3          	beq	s3,s8,3256 <diskfull+0x8c>
    name[0] = 'b';
    33b2:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    33b6:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    33ba:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    33be:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    33c2:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    33c6:	b8040513          	addi	a0,s0,-1152
    33ca:	00003097          	auipc	ra,0x3
    33ce:	874080e7          	jalr	-1932(ra) # 5c3e <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33d2:	60200593          	li	a1,1538
    33d6:	b8040513          	addi	a0,s0,-1152
    33da:	00003097          	auipc	ra,0x3
    33de:	854080e7          	jalr	-1964(ra) # 5c2e <open>
    33e2:	892a                	mv	s2,a0
    if(fd < 0){
    33e4:	e40543e3          	bltz	a0,322a <diskfull+0x60>
    33e8:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33ea:	40000613          	li	a2,1024
    33ee:	ba040593          	addi	a1,s0,-1120
    33f2:	854a                	mv	a0,s2
    33f4:	00003097          	auipc	ra,0x3
    33f8:	81a080e7          	jalr	-2022(ra) # 5c0e <write>
    33fc:	40000793          	li	a5,1024
    3400:	e4f511e3          	bne	a0,a5,3242 <diskfull+0x78>
    for(int i = 0; i < MAXFILE; i++){
    3404:	34fd                	addiw	s1,s1,-1
    3406:	f0f5                	bnez	s1,33ea <diskfull+0x220>
    3408:	bf59                	j	339e <diskfull+0x1d4>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    340a:	00004517          	auipc	a0,0x4
    340e:	f5650513          	addi	a0,a0,-170 # 7360 <malloc+0x1340>
    3412:	00003097          	auipc	ra,0x3
    3416:	b56080e7          	jalr	-1194(ra) # 5f68 <printf>
    341a:	bd65                	j	32d2 <diskfull+0x108>

000000000000341c <iputtest>:
{
    341c:	1101                	addi	sp,sp,-32
    341e:	ec06                	sd	ra,24(sp)
    3420:	e822                	sd	s0,16(sp)
    3422:	e426                	sd	s1,8(sp)
    3424:	1000                	addi	s0,sp,32
    3426:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    3428:	00004517          	auipc	a0,0x4
    342c:	f6850513          	addi	a0,a0,-152 # 7390 <malloc+0x1370>
    3430:	00003097          	auipc	ra,0x3
    3434:	826080e7          	jalr	-2010(ra) # 5c56 <mkdir>
    3438:	04054563          	bltz	a0,3482 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    343c:	00004517          	auipc	a0,0x4
    3440:	f5450513          	addi	a0,a0,-172 # 7390 <malloc+0x1370>
    3444:	00003097          	auipc	ra,0x3
    3448:	81a080e7          	jalr	-2022(ra) # 5c5e <chdir>
    344c:	04054963          	bltz	a0,349e <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    3450:	00004517          	auipc	a0,0x4
    3454:	f8050513          	addi	a0,a0,-128 # 73d0 <malloc+0x13b0>
    3458:	00002097          	auipc	ra,0x2
    345c:	7e6080e7          	jalr	2022(ra) # 5c3e <unlink>
    3460:	04054d63          	bltz	a0,34ba <iputtest+0x9e>
  if(chdir("/") < 0){
    3464:	00004517          	auipc	a0,0x4
    3468:	f9c50513          	addi	a0,a0,-100 # 7400 <malloc+0x13e0>
    346c:	00002097          	auipc	ra,0x2
    3470:	7f2080e7          	jalr	2034(ra) # 5c5e <chdir>
    3474:	06054163          	bltz	a0,34d6 <iputtest+0xba>
}
    3478:	60e2                	ld	ra,24(sp)
    347a:	6442                	ld	s0,16(sp)
    347c:	64a2                	ld	s1,8(sp)
    347e:	6105                	addi	sp,sp,32
    3480:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3482:	85a6                	mv	a1,s1
    3484:	00004517          	auipc	a0,0x4
    3488:	f1450513          	addi	a0,a0,-236 # 7398 <malloc+0x1378>
    348c:	00003097          	auipc	ra,0x3
    3490:	adc080e7          	jalr	-1316(ra) # 5f68 <printf>
    exit(1);
    3494:	4505                	li	a0,1
    3496:	00002097          	auipc	ra,0x2
    349a:	758080e7          	jalr	1880(ra) # 5bee <exit>
    printf("%s: chdir iputdir failed\n", s);
    349e:	85a6                	mv	a1,s1
    34a0:	00004517          	auipc	a0,0x4
    34a4:	f1050513          	addi	a0,a0,-240 # 73b0 <malloc+0x1390>
    34a8:	00003097          	auipc	ra,0x3
    34ac:	ac0080e7          	jalr	-1344(ra) # 5f68 <printf>
    exit(1);
    34b0:	4505                	li	a0,1
    34b2:	00002097          	auipc	ra,0x2
    34b6:	73c080e7          	jalr	1852(ra) # 5bee <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34ba:	85a6                	mv	a1,s1
    34bc:	00004517          	auipc	a0,0x4
    34c0:	f2450513          	addi	a0,a0,-220 # 73e0 <malloc+0x13c0>
    34c4:	00003097          	auipc	ra,0x3
    34c8:	aa4080e7          	jalr	-1372(ra) # 5f68 <printf>
    exit(1);
    34cc:	4505                	li	a0,1
    34ce:	00002097          	auipc	ra,0x2
    34d2:	720080e7          	jalr	1824(ra) # 5bee <exit>
    printf("%s: chdir / failed\n", s);
    34d6:	85a6                	mv	a1,s1
    34d8:	00004517          	auipc	a0,0x4
    34dc:	f3050513          	addi	a0,a0,-208 # 7408 <malloc+0x13e8>
    34e0:	00003097          	auipc	ra,0x3
    34e4:	a88080e7          	jalr	-1400(ra) # 5f68 <printf>
    exit(1);
    34e8:	4505                	li	a0,1
    34ea:	00002097          	auipc	ra,0x2
    34ee:	704080e7          	jalr	1796(ra) # 5bee <exit>

00000000000034f2 <exitiputtest>:
{
    34f2:	7179                	addi	sp,sp,-48
    34f4:	f406                	sd	ra,40(sp)
    34f6:	f022                	sd	s0,32(sp)
    34f8:	ec26                	sd	s1,24(sp)
    34fa:	1800                	addi	s0,sp,48
    34fc:	84aa                	mv	s1,a0
  pid = fork();
    34fe:	00002097          	auipc	ra,0x2
    3502:	6e8080e7          	jalr	1768(ra) # 5be6 <fork>
  if(pid < 0){
    3506:	04054663          	bltz	a0,3552 <exitiputtest+0x60>
  if(pid == 0){
    350a:	ed45                	bnez	a0,35c2 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    350c:	00004517          	auipc	a0,0x4
    3510:	e8450513          	addi	a0,a0,-380 # 7390 <malloc+0x1370>
    3514:	00002097          	auipc	ra,0x2
    3518:	742080e7          	jalr	1858(ra) # 5c56 <mkdir>
    351c:	04054963          	bltz	a0,356e <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    3520:	00004517          	auipc	a0,0x4
    3524:	e7050513          	addi	a0,a0,-400 # 7390 <malloc+0x1370>
    3528:	00002097          	auipc	ra,0x2
    352c:	736080e7          	jalr	1846(ra) # 5c5e <chdir>
    3530:	04054d63          	bltz	a0,358a <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3534:	00004517          	auipc	a0,0x4
    3538:	e9c50513          	addi	a0,a0,-356 # 73d0 <malloc+0x13b0>
    353c:	00002097          	auipc	ra,0x2
    3540:	702080e7          	jalr	1794(ra) # 5c3e <unlink>
    3544:	06054163          	bltz	a0,35a6 <exitiputtest+0xb4>
    exit(0);
    3548:	4501                	li	a0,0
    354a:	00002097          	auipc	ra,0x2
    354e:	6a4080e7          	jalr	1700(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    3552:	85a6                	mv	a1,s1
    3554:	00003517          	auipc	a0,0x3
    3558:	47c50513          	addi	a0,a0,1148 # 69d0 <malloc+0x9b0>
    355c:	00003097          	auipc	ra,0x3
    3560:	a0c080e7          	jalr	-1524(ra) # 5f68 <printf>
    exit(1);
    3564:	4505                	li	a0,1
    3566:	00002097          	auipc	ra,0x2
    356a:	688080e7          	jalr	1672(ra) # 5bee <exit>
      printf("%s: mkdir failed\n", s);
    356e:	85a6                	mv	a1,s1
    3570:	00004517          	auipc	a0,0x4
    3574:	e2850513          	addi	a0,a0,-472 # 7398 <malloc+0x1378>
    3578:	00003097          	auipc	ra,0x3
    357c:	9f0080e7          	jalr	-1552(ra) # 5f68 <printf>
      exit(1);
    3580:	4505                	li	a0,1
    3582:	00002097          	auipc	ra,0x2
    3586:	66c080e7          	jalr	1644(ra) # 5bee <exit>
      printf("%s: child chdir failed\n", s);
    358a:	85a6                	mv	a1,s1
    358c:	00004517          	auipc	a0,0x4
    3590:	e9450513          	addi	a0,a0,-364 # 7420 <malloc+0x1400>
    3594:	00003097          	auipc	ra,0x3
    3598:	9d4080e7          	jalr	-1580(ra) # 5f68 <printf>
      exit(1);
    359c:	4505                	li	a0,1
    359e:	00002097          	auipc	ra,0x2
    35a2:	650080e7          	jalr	1616(ra) # 5bee <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    35a6:	85a6                	mv	a1,s1
    35a8:	00004517          	auipc	a0,0x4
    35ac:	e3850513          	addi	a0,a0,-456 # 73e0 <malloc+0x13c0>
    35b0:	00003097          	auipc	ra,0x3
    35b4:	9b8080e7          	jalr	-1608(ra) # 5f68 <printf>
      exit(1);
    35b8:	4505                	li	a0,1
    35ba:	00002097          	auipc	ra,0x2
    35be:	634080e7          	jalr	1588(ra) # 5bee <exit>
  wait(&xstatus);
    35c2:	fdc40513          	addi	a0,s0,-36
    35c6:	00002097          	auipc	ra,0x2
    35ca:	630080e7          	jalr	1584(ra) # 5bf6 <wait>
  exit(xstatus);
    35ce:	fdc42503          	lw	a0,-36(s0)
    35d2:	00002097          	auipc	ra,0x2
    35d6:	61c080e7          	jalr	1564(ra) # 5bee <exit>

00000000000035da <dirtest>:
{
    35da:	1101                	addi	sp,sp,-32
    35dc:	ec06                	sd	ra,24(sp)
    35de:	e822                	sd	s0,16(sp)
    35e0:	e426                	sd	s1,8(sp)
    35e2:	1000                	addi	s0,sp,32
    35e4:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35e6:	00004517          	auipc	a0,0x4
    35ea:	e5250513          	addi	a0,a0,-430 # 7438 <malloc+0x1418>
    35ee:	00002097          	auipc	ra,0x2
    35f2:	668080e7          	jalr	1640(ra) # 5c56 <mkdir>
    35f6:	04054563          	bltz	a0,3640 <dirtest+0x66>
  if(chdir("dir0") < 0){
    35fa:	00004517          	auipc	a0,0x4
    35fe:	e3e50513          	addi	a0,a0,-450 # 7438 <malloc+0x1418>
    3602:	00002097          	auipc	ra,0x2
    3606:	65c080e7          	jalr	1628(ra) # 5c5e <chdir>
    360a:	04054963          	bltz	a0,365c <dirtest+0x82>
  if(chdir("..") < 0){
    360e:	00004517          	auipc	a0,0x4
    3612:	e4a50513          	addi	a0,a0,-438 # 7458 <malloc+0x1438>
    3616:	00002097          	auipc	ra,0x2
    361a:	648080e7          	jalr	1608(ra) # 5c5e <chdir>
    361e:	04054d63          	bltz	a0,3678 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3622:	00004517          	auipc	a0,0x4
    3626:	e1650513          	addi	a0,a0,-490 # 7438 <malloc+0x1418>
    362a:	00002097          	auipc	ra,0x2
    362e:	614080e7          	jalr	1556(ra) # 5c3e <unlink>
    3632:	06054163          	bltz	a0,3694 <dirtest+0xba>
}
    3636:	60e2                	ld	ra,24(sp)
    3638:	6442                	ld	s0,16(sp)
    363a:	64a2                	ld	s1,8(sp)
    363c:	6105                	addi	sp,sp,32
    363e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3640:	85a6                	mv	a1,s1
    3642:	00004517          	auipc	a0,0x4
    3646:	d5650513          	addi	a0,a0,-682 # 7398 <malloc+0x1378>
    364a:	00003097          	auipc	ra,0x3
    364e:	91e080e7          	jalr	-1762(ra) # 5f68 <printf>
    exit(1);
    3652:	4505                	li	a0,1
    3654:	00002097          	auipc	ra,0x2
    3658:	59a080e7          	jalr	1434(ra) # 5bee <exit>
    printf("%s: chdir dir0 failed\n", s);
    365c:	85a6                	mv	a1,s1
    365e:	00004517          	auipc	a0,0x4
    3662:	de250513          	addi	a0,a0,-542 # 7440 <malloc+0x1420>
    3666:	00003097          	auipc	ra,0x3
    366a:	902080e7          	jalr	-1790(ra) # 5f68 <printf>
    exit(1);
    366e:	4505                	li	a0,1
    3670:	00002097          	auipc	ra,0x2
    3674:	57e080e7          	jalr	1406(ra) # 5bee <exit>
    printf("%s: chdir .. failed\n", s);
    3678:	85a6                	mv	a1,s1
    367a:	00004517          	auipc	a0,0x4
    367e:	de650513          	addi	a0,a0,-538 # 7460 <malloc+0x1440>
    3682:	00003097          	auipc	ra,0x3
    3686:	8e6080e7          	jalr	-1818(ra) # 5f68 <printf>
    exit(1);
    368a:	4505                	li	a0,1
    368c:	00002097          	auipc	ra,0x2
    3690:	562080e7          	jalr	1378(ra) # 5bee <exit>
    printf("%s: unlink dir0 failed\n", s);
    3694:	85a6                	mv	a1,s1
    3696:	00004517          	auipc	a0,0x4
    369a:	de250513          	addi	a0,a0,-542 # 7478 <malloc+0x1458>
    369e:	00003097          	auipc	ra,0x3
    36a2:	8ca080e7          	jalr	-1846(ra) # 5f68 <printf>
    exit(1);
    36a6:	4505                	li	a0,1
    36a8:	00002097          	auipc	ra,0x2
    36ac:	546080e7          	jalr	1350(ra) # 5bee <exit>

00000000000036b0 <subdir>:
{
    36b0:	1101                	addi	sp,sp,-32
    36b2:	ec06                	sd	ra,24(sp)
    36b4:	e822                	sd	s0,16(sp)
    36b6:	e426                	sd	s1,8(sp)
    36b8:	e04a                	sd	s2,0(sp)
    36ba:	1000                	addi	s0,sp,32
    36bc:	892a                	mv	s2,a0
  unlink("ff");
    36be:	00004517          	auipc	a0,0x4
    36c2:	f0250513          	addi	a0,a0,-254 # 75c0 <malloc+0x15a0>
    36c6:	00002097          	auipc	ra,0x2
    36ca:	578080e7          	jalr	1400(ra) # 5c3e <unlink>
  if(mkdir("dd") != 0){
    36ce:	00004517          	auipc	a0,0x4
    36d2:	dc250513          	addi	a0,a0,-574 # 7490 <malloc+0x1470>
    36d6:	00002097          	auipc	ra,0x2
    36da:	580080e7          	jalr	1408(ra) # 5c56 <mkdir>
    36de:	38051663          	bnez	a0,3a6a <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36e2:	20200593          	li	a1,514
    36e6:	00004517          	auipc	a0,0x4
    36ea:	dca50513          	addi	a0,a0,-566 # 74b0 <malloc+0x1490>
    36ee:	00002097          	auipc	ra,0x2
    36f2:	540080e7          	jalr	1344(ra) # 5c2e <open>
    36f6:	84aa                	mv	s1,a0
  if(fd < 0){
    36f8:	38054763          	bltz	a0,3a86 <subdir+0x3d6>
  write(fd, "ff", 2);
    36fc:	4609                	li	a2,2
    36fe:	00004597          	auipc	a1,0x4
    3702:	ec258593          	addi	a1,a1,-318 # 75c0 <malloc+0x15a0>
    3706:	00002097          	auipc	ra,0x2
    370a:	508080e7          	jalr	1288(ra) # 5c0e <write>
  close(fd);
    370e:	8526                	mv	a0,s1
    3710:	00002097          	auipc	ra,0x2
    3714:	506080e7          	jalr	1286(ra) # 5c16 <close>
  if(unlink("dd") >= 0){
    3718:	00004517          	auipc	a0,0x4
    371c:	d7850513          	addi	a0,a0,-648 # 7490 <malloc+0x1470>
    3720:	00002097          	auipc	ra,0x2
    3724:	51e080e7          	jalr	1310(ra) # 5c3e <unlink>
    3728:	36055d63          	bgez	a0,3aa2 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    372c:	00004517          	auipc	a0,0x4
    3730:	ddc50513          	addi	a0,a0,-548 # 7508 <malloc+0x14e8>
    3734:	00002097          	auipc	ra,0x2
    3738:	522080e7          	jalr	1314(ra) # 5c56 <mkdir>
    373c:	38051163          	bnez	a0,3abe <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3740:	20200593          	li	a1,514
    3744:	00004517          	auipc	a0,0x4
    3748:	dec50513          	addi	a0,a0,-532 # 7530 <malloc+0x1510>
    374c:	00002097          	auipc	ra,0x2
    3750:	4e2080e7          	jalr	1250(ra) # 5c2e <open>
    3754:	84aa                	mv	s1,a0
  if(fd < 0){
    3756:	38054263          	bltz	a0,3ada <subdir+0x42a>
  write(fd, "FF", 2);
    375a:	4609                	li	a2,2
    375c:	00004597          	auipc	a1,0x4
    3760:	e0458593          	addi	a1,a1,-508 # 7560 <malloc+0x1540>
    3764:	00002097          	auipc	ra,0x2
    3768:	4aa080e7          	jalr	1194(ra) # 5c0e <write>
  close(fd);
    376c:	8526                	mv	a0,s1
    376e:	00002097          	auipc	ra,0x2
    3772:	4a8080e7          	jalr	1192(ra) # 5c16 <close>
  fd = open("dd/dd/../ff", 0);
    3776:	4581                	li	a1,0
    3778:	00004517          	auipc	a0,0x4
    377c:	df050513          	addi	a0,a0,-528 # 7568 <malloc+0x1548>
    3780:	00002097          	auipc	ra,0x2
    3784:	4ae080e7          	jalr	1198(ra) # 5c2e <open>
    3788:	84aa                	mv	s1,a0
  if(fd < 0){
    378a:	36054663          	bltz	a0,3af6 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    378e:	660d                	lui	a2,0x3
    3790:	00009597          	auipc	a1,0x9
    3794:	4e858593          	addi	a1,a1,1256 # cc78 <buf>
    3798:	00002097          	auipc	ra,0x2
    379c:	46e080e7          	jalr	1134(ra) # 5c06 <read>
  if(cc != 2 || buf[0] != 'f'){
    37a0:	4789                	li	a5,2
    37a2:	36f51863          	bne	a0,a5,3b12 <subdir+0x462>
    37a6:	00009717          	auipc	a4,0x9
    37aa:	4d274703          	lbu	a4,1234(a4) # cc78 <buf>
    37ae:	06600793          	li	a5,102
    37b2:	36f71063          	bne	a4,a5,3b12 <subdir+0x462>
  close(fd);
    37b6:	8526                	mv	a0,s1
    37b8:	00002097          	auipc	ra,0x2
    37bc:	45e080e7          	jalr	1118(ra) # 5c16 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37c0:	00004597          	auipc	a1,0x4
    37c4:	df858593          	addi	a1,a1,-520 # 75b8 <malloc+0x1598>
    37c8:	00004517          	auipc	a0,0x4
    37cc:	d6850513          	addi	a0,a0,-664 # 7530 <malloc+0x1510>
    37d0:	00002097          	auipc	ra,0x2
    37d4:	47e080e7          	jalr	1150(ra) # 5c4e <link>
    37d8:	34051b63          	bnez	a0,3b2e <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37dc:	00004517          	auipc	a0,0x4
    37e0:	d5450513          	addi	a0,a0,-684 # 7530 <malloc+0x1510>
    37e4:	00002097          	auipc	ra,0x2
    37e8:	45a080e7          	jalr	1114(ra) # 5c3e <unlink>
    37ec:	34051f63          	bnez	a0,3b4a <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37f0:	4581                	li	a1,0
    37f2:	00004517          	auipc	a0,0x4
    37f6:	d3e50513          	addi	a0,a0,-706 # 7530 <malloc+0x1510>
    37fa:	00002097          	auipc	ra,0x2
    37fe:	434080e7          	jalr	1076(ra) # 5c2e <open>
    3802:	36055263          	bgez	a0,3b66 <subdir+0x4b6>
  if(chdir("dd") != 0){
    3806:	00004517          	auipc	a0,0x4
    380a:	c8a50513          	addi	a0,a0,-886 # 7490 <malloc+0x1470>
    380e:	00002097          	auipc	ra,0x2
    3812:	450080e7          	jalr	1104(ra) # 5c5e <chdir>
    3816:	36051663          	bnez	a0,3b82 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    381a:	00004517          	auipc	a0,0x4
    381e:	e3650513          	addi	a0,a0,-458 # 7650 <malloc+0x1630>
    3822:	00002097          	auipc	ra,0x2
    3826:	43c080e7          	jalr	1084(ra) # 5c5e <chdir>
    382a:	36051a63          	bnez	a0,3b9e <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    382e:	00004517          	auipc	a0,0x4
    3832:	e5250513          	addi	a0,a0,-430 # 7680 <malloc+0x1660>
    3836:	00002097          	auipc	ra,0x2
    383a:	428080e7          	jalr	1064(ra) # 5c5e <chdir>
    383e:	36051e63          	bnez	a0,3bba <subdir+0x50a>
  if(chdir("./..") != 0){
    3842:	00004517          	auipc	a0,0x4
    3846:	e6e50513          	addi	a0,a0,-402 # 76b0 <malloc+0x1690>
    384a:	00002097          	auipc	ra,0x2
    384e:	414080e7          	jalr	1044(ra) # 5c5e <chdir>
    3852:	38051263          	bnez	a0,3bd6 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3856:	4581                	li	a1,0
    3858:	00004517          	auipc	a0,0x4
    385c:	d6050513          	addi	a0,a0,-672 # 75b8 <malloc+0x1598>
    3860:	00002097          	auipc	ra,0x2
    3864:	3ce080e7          	jalr	974(ra) # 5c2e <open>
    3868:	84aa                	mv	s1,a0
  if(fd < 0){
    386a:	38054463          	bltz	a0,3bf2 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    386e:	660d                	lui	a2,0x3
    3870:	00009597          	auipc	a1,0x9
    3874:	40858593          	addi	a1,a1,1032 # cc78 <buf>
    3878:	00002097          	auipc	ra,0x2
    387c:	38e080e7          	jalr	910(ra) # 5c06 <read>
    3880:	4789                	li	a5,2
    3882:	38f51663          	bne	a0,a5,3c0e <subdir+0x55e>
  close(fd);
    3886:	8526                	mv	a0,s1
    3888:	00002097          	auipc	ra,0x2
    388c:	38e080e7          	jalr	910(ra) # 5c16 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3890:	4581                	li	a1,0
    3892:	00004517          	auipc	a0,0x4
    3896:	c9e50513          	addi	a0,a0,-866 # 7530 <malloc+0x1510>
    389a:	00002097          	auipc	ra,0x2
    389e:	394080e7          	jalr	916(ra) # 5c2e <open>
    38a2:	38055463          	bgez	a0,3c2a <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    38a6:	20200593          	li	a1,514
    38aa:	00004517          	auipc	a0,0x4
    38ae:	e9650513          	addi	a0,a0,-362 # 7740 <malloc+0x1720>
    38b2:	00002097          	auipc	ra,0x2
    38b6:	37c080e7          	jalr	892(ra) # 5c2e <open>
    38ba:	38055663          	bgez	a0,3c46 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38be:	20200593          	li	a1,514
    38c2:	00004517          	auipc	a0,0x4
    38c6:	eae50513          	addi	a0,a0,-338 # 7770 <malloc+0x1750>
    38ca:	00002097          	auipc	ra,0x2
    38ce:	364080e7          	jalr	868(ra) # 5c2e <open>
    38d2:	38055863          	bgez	a0,3c62 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38d6:	20000593          	li	a1,512
    38da:	00004517          	auipc	a0,0x4
    38de:	bb650513          	addi	a0,a0,-1098 # 7490 <malloc+0x1470>
    38e2:	00002097          	auipc	ra,0x2
    38e6:	34c080e7          	jalr	844(ra) # 5c2e <open>
    38ea:	38055a63          	bgez	a0,3c7e <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38ee:	4589                	li	a1,2
    38f0:	00004517          	auipc	a0,0x4
    38f4:	ba050513          	addi	a0,a0,-1120 # 7490 <malloc+0x1470>
    38f8:	00002097          	auipc	ra,0x2
    38fc:	336080e7          	jalr	822(ra) # 5c2e <open>
    3900:	38055d63          	bgez	a0,3c9a <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    3904:	4585                	li	a1,1
    3906:	00004517          	auipc	a0,0x4
    390a:	b8a50513          	addi	a0,a0,-1142 # 7490 <malloc+0x1470>
    390e:	00002097          	auipc	ra,0x2
    3912:	320080e7          	jalr	800(ra) # 5c2e <open>
    3916:	3a055063          	bgez	a0,3cb6 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    391a:	00004597          	auipc	a1,0x4
    391e:	ee658593          	addi	a1,a1,-282 # 7800 <malloc+0x17e0>
    3922:	00004517          	auipc	a0,0x4
    3926:	e1e50513          	addi	a0,a0,-482 # 7740 <malloc+0x1720>
    392a:	00002097          	auipc	ra,0x2
    392e:	324080e7          	jalr	804(ra) # 5c4e <link>
    3932:	3a050063          	beqz	a0,3cd2 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3936:	00004597          	auipc	a1,0x4
    393a:	eca58593          	addi	a1,a1,-310 # 7800 <malloc+0x17e0>
    393e:	00004517          	auipc	a0,0x4
    3942:	e3250513          	addi	a0,a0,-462 # 7770 <malloc+0x1750>
    3946:	00002097          	auipc	ra,0x2
    394a:	308080e7          	jalr	776(ra) # 5c4e <link>
    394e:	3a050063          	beqz	a0,3cee <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3952:	00004597          	auipc	a1,0x4
    3956:	c6658593          	addi	a1,a1,-922 # 75b8 <malloc+0x1598>
    395a:	00004517          	auipc	a0,0x4
    395e:	b5650513          	addi	a0,a0,-1194 # 74b0 <malloc+0x1490>
    3962:	00002097          	auipc	ra,0x2
    3966:	2ec080e7          	jalr	748(ra) # 5c4e <link>
    396a:	3a050063          	beqz	a0,3d0a <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    396e:	00004517          	auipc	a0,0x4
    3972:	dd250513          	addi	a0,a0,-558 # 7740 <malloc+0x1720>
    3976:	00002097          	auipc	ra,0x2
    397a:	2e0080e7          	jalr	736(ra) # 5c56 <mkdir>
    397e:	3a050463          	beqz	a0,3d26 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3982:	00004517          	auipc	a0,0x4
    3986:	dee50513          	addi	a0,a0,-530 # 7770 <malloc+0x1750>
    398a:	00002097          	auipc	ra,0x2
    398e:	2cc080e7          	jalr	716(ra) # 5c56 <mkdir>
    3992:	3a050863          	beqz	a0,3d42 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    3996:	00004517          	auipc	a0,0x4
    399a:	c2250513          	addi	a0,a0,-990 # 75b8 <malloc+0x1598>
    399e:	00002097          	auipc	ra,0x2
    39a2:	2b8080e7          	jalr	696(ra) # 5c56 <mkdir>
    39a6:	3a050c63          	beqz	a0,3d5e <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    39aa:	00004517          	auipc	a0,0x4
    39ae:	dc650513          	addi	a0,a0,-570 # 7770 <malloc+0x1750>
    39b2:	00002097          	auipc	ra,0x2
    39b6:	28c080e7          	jalr	652(ra) # 5c3e <unlink>
    39ba:	3c050063          	beqz	a0,3d7a <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39be:	00004517          	auipc	a0,0x4
    39c2:	d8250513          	addi	a0,a0,-638 # 7740 <malloc+0x1720>
    39c6:	00002097          	auipc	ra,0x2
    39ca:	278080e7          	jalr	632(ra) # 5c3e <unlink>
    39ce:	3c050463          	beqz	a0,3d96 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39d2:	00004517          	auipc	a0,0x4
    39d6:	ade50513          	addi	a0,a0,-1314 # 74b0 <malloc+0x1490>
    39da:	00002097          	auipc	ra,0x2
    39de:	284080e7          	jalr	644(ra) # 5c5e <chdir>
    39e2:	3c050863          	beqz	a0,3db2 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39e6:	00004517          	auipc	a0,0x4
    39ea:	f6a50513          	addi	a0,a0,-150 # 7950 <malloc+0x1930>
    39ee:	00002097          	auipc	ra,0x2
    39f2:	270080e7          	jalr	624(ra) # 5c5e <chdir>
    39f6:	3c050c63          	beqz	a0,3dce <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39fa:	00004517          	auipc	a0,0x4
    39fe:	bbe50513          	addi	a0,a0,-1090 # 75b8 <malloc+0x1598>
    3a02:	00002097          	auipc	ra,0x2
    3a06:	23c080e7          	jalr	572(ra) # 5c3e <unlink>
    3a0a:	3e051063          	bnez	a0,3dea <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    3a0e:	00004517          	auipc	a0,0x4
    3a12:	aa250513          	addi	a0,a0,-1374 # 74b0 <malloc+0x1490>
    3a16:	00002097          	auipc	ra,0x2
    3a1a:	228080e7          	jalr	552(ra) # 5c3e <unlink>
    3a1e:	3e051463          	bnez	a0,3e06 <subdir+0x756>
  if(unlink("dd") == 0){
    3a22:	00004517          	auipc	a0,0x4
    3a26:	a6e50513          	addi	a0,a0,-1426 # 7490 <malloc+0x1470>
    3a2a:	00002097          	auipc	ra,0x2
    3a2e:	214080e7          	jalr	532(ra) # 5c3e <unlink>
    3a32:	3e050863          	beqz	a0,3e22 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a36:	00004517          	auipc	a0,0x4
    3a3a:	f8a50513          	addi	a0,a0,-118 # 79c0 <malloc+0x19a0>
    3a3e:	00002097          	auipc	ra,0x2
    3a42:	200080e7          	jalr	512(ra) # 5c3e <unlink>
    3a46:	3e054c63          	bltz	a0,3e3e <subdir+0x78e>
  if(unlink("dd") < 0){
    3a4a:	00004517          	auipc	a0,0x4
    3a4e:	a4650513          	addi	a0,a0,-1466 # 7490 <malloc+0x1470>
    3a52:	00002097          	auipc	ra,0x2
    3a56:	1ec080e7          	jalr	492(ra) # 5c3e <unlink>
    3a5a:	40054063          	bltz	a0,3e5a <subdir+0x7aa>
}
    3a5e:	60e2                	ld	ra,24(sp)
    3a60:	6442                	ld	s0,16(sp)
    3a62:	64a2                	ld	s1,8(sp)
    3a64:	6902                	ld	s2,0(sp)
    3a66:	6105                	addi	sp,sp,32
    3a68:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a6a:	85ca                	mv	a1,s2
    3a6c:	00004517          	auipc	a0,0x4
    3a70:	a2c50513          	addi	a0,a0,-1492 # 7498 <malloc+0x1478>
    3a74:	00002097          	auipc	ra,0x2
    3a78:	4f4080e7          	jalr	1268(ra) # 5f68 <printf>
    exit(1);
    3a7c:	4505                	li	a0,1
    3a7e:	00002097          	auipc	ra,0x2
    3a82:	170080e7          	jalr	368(ra) # 5bee <exit>
    printf("%s: create dd/ff failed\n", s);
    3a86:	85ca                	mv	a1,s2
    3a88:	00004517          	auipc	a0,0x4
    3a8c:	a3050513          	addi	a0,a0,-1488 # 74b8 <malloc+0x1498>
    3a90:	00002097          	auipc	ra,0x2
    3a94:	4d8080e7          	jalr	1240(ra) # 5f68 <printf>
    exit(1);
    3a98:	4505                	li	a0,1
    3a9a:	00002097          	auipc	ra,0x2
    3a9e:	154080e7          	jalr	340(ra) # 5bee <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3aa2:	85ca                	mv	a1,s2
    3aa4:	00004517          	auipc	a0,0x4
    3aa8:	a3450513          	addi	a0,a0,-1484 # 74d8 <malloc+0x14b8>
    3aac:	00002097          	auipc	ra,0x2
    3ab0:	4bc080e7          	jalr	1212(ra) # 5f68 <printf>
    exit(1);
    3ab4:	4505                	li	a0,1
    3ab6:	00002097          	auipc	ra,0x2
    3aba:	138080e7          	jalr	312(ra) # 5bee <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3abe:	85ca                	mv	a1,s2
    3ac0:	00004517          	auipc	a0,0x4
    3ac4:	a5050513          	addi	a0,a0,-1456 # 7510 <malloc+0x14f0>
    3ac8:	00002097          	auipc	ra,0x2
    3acc:	4a0080e7          	jalr	1184(ra) # 5f68 <printf>
    exit(1);
    3ad0:	4505                	li	a0,1
    3ad2:	00002097          	auipc	ra,0x2
    3ad6:	11c080e7          	jalr	284(ra) # 5bee <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ada:	85ca                	mv	a1,s2
    3adc:	00004517          	auipc	a0,0x4
    3ae0:	a6450513          	addi	a0,a0,-1436 # 7540 <malloc+0x1520>
    3ae4:	00002097          	auipc	ra,0x2
    3ae8:	484080e7          	jalr	1156(ra) # 5f68 <printf>
    exit(1);
    3aec:	4505                	li	a0,1
    3aee:	00002097          	auipc	ra,0x2
    3af2:	100080e7          	jalr	256(ra) # 5bee <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3af6:	85ca                	mv	a1,s2
    3af8:	00004517          	auipc	a0,0x4
    3afc:	a8050513          	addi	a0,a0,-1408 # 7578 <malloc+0x1558>
    3b00:	00002097          	auipc	ra,0x2
    3b04:	468080e7          	jalr	1128(ra) # 5f68 <printf>
    exit(1);
    3b08:	4505                	li	a0,1
    3b0a:	00002097          	auipc	ra,0x2
    3b0e:	0e4080e7          	jalr	228(ra) # 5bee <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3b12:	85ca                	mv	a1,s2
    3b14:	00004517          	auipc	a0,0x4
    3b18:	a8450513          	addi	a0,a0,-1404 # 7598 <malloc+0x1578>
    3b1c:	00002097          	auipc	ra,0x2
    3b20:	44c080e7          	jalr	1100(ra) # 5f68 <printf>
    exit(1);
    3b24:	4505                	li	a0,1
    3b26:	00002097          	auipc	ra,0x2
    3b2a:	0c8080e7          	jalr	200(ra) # 5bee <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b2e:	85ca                	mv	a1,s2
    3b30:	00004517          	auipc	a0,0x4
    3b34:	a9850513          	addi	a0,a0,-1384 # 75c8 <malloc+0x15a8>
    3b38:	00002097          	auipc	ra,0x2
    3b3c:	430080e7          	jalr	1072(ra) # 5f68 <printf>
    exit(1);
    3b40:	4505                	li	a0,1
    3b42:	00002097          	auipc	ra,0x2
    3b46:	0ac080e7          	jalr	172(ra) # 5bee <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b4a:	85ca                	mv	a1,s2
    3b4c:	00004517          	auipc	a0,0x4
    3b50:	aa450513          	addi	a0,a0,-1372 # 75f0 <malloc+0x15d0>
    3b54:	00002097          	auipc	ra,0x2
    3b58:	414080e7          	jalr	1044(ra) # 5f68 <printf>
    exit(1);
    3b5c:	4505                	li	a0,1
    3b5e:	00002097          	auipc	ra,0x2
    3b62:	090080e7          	jalr	144(ra) # 5bee <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b66:	85ca                	mv	a1,s2
    3b68:	00004517          	auipc	a0,0x4
    3b6c:	aa850513          	addi	a0,a0,-1368 # 7610 <malloc+0x15f0>
    3b70:	00002097          	auipc	ra,0x2
    3b74:	3f8080e7          	jalr	1016(ra) # 5f68 <printf>
    exit(1);
    3b78:	4505                	li	a0,1
    3b7a:	00002097          	auipc	ra,0x2
    3b7e:	074080e7          	jalr	116(ra) # 5bee <exit>
    printf("%s: chdir dd failed\n", s);
    3b82:	85ca                	mv	a1,s2
    3b84:	00004517          	auipc	a0,0x4
    3b88:	ab450513          	addi	a0,a0,-1356 # 7638 <malloc+0x1618>
    3b8c:	00002097          	auipc	ra,0x2
    3b90:	3dc080e7          	jalr	988(ra) # 5f68 <printf>
    exit(1);
    3b94:	4505                	li	a0,1
    3b96:	00002097          	auipc	ra,0x2
    3b9a:	058080e7          	jalr	88(ra) # 5bee <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b9e:	85ca                	mv	a1,s2
    3ba0:	00004517          	auipc	a0,0x4
    3ba4:	ac050513          	addi	a0,a0,-1344 # 7660 <malloc+0x1640>
    3ba8:	00002097          	auipc	ra,0x2
    3bac:	3c0080e7          	jalr	960(ra) # 5f68 <printf>
    exit(1);
    3bb0:	4505                	li	a0,1
    3bb2:	00002097          	auipc	ra,0x2
    3bb6:	03c080e7          	jalr	60(ra) # 5bee <exit>
    printf("chdir dd/../../dd failed\n", s);
    3bba:	85ca                	mv	a1,s2
    3bbc:	00004517          	auipc	a0,0x4
    3bc0:	ad450513          	addi	a0,a0,-1324 # 7690 <malloc+0x1670>
    3bc4:	00002097          	auipc	ra,0x2
    3bc8:	3a4080e7          	jalr	932(ra) # 5f68 <printf>
    exit(1);
    3bcc:	4505                	li	a0,1
    3bce:	00002097          	auipc	ra,0x2
    3bd2:	020080e7          	jalr	32(ra) # 5bee <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bd6:	85ca                	mv	a1,s2
    3bd8:	00004517          	auipc	a0,0x4
    3bdc:	ae050513          	addi	a0,a0,-1312 # 76b8 <malloc+0x1698>
    3be0:	00002097          	auipc	ra,0x2
    3be4:	388080e7          	jalr	904(ra) # 5f68 <printf>
    exit(1);
    3be8:	4505                	li	a0,1
    3bea:	00002097          	auipc	ra,0x2
    3bee:	004080e7          	jalr	4(ra) # 5bee <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bf2:	85ca                	mv	a1,s2
    3bf4:	00004517          	auipc	a0,0x4
    3bf8:	adc50513          	addi	a0,a0,-1316 # 76d0 <malloc+0x16b0>
    3bfc:	00002097          	auipc	ra,0x2
    3c00:	36c080e7          	jalr	876(ra) # 5f68 <printf>
    exit(1);
    3c04:	4505                	li	a0,1
    3c06:	00002097          	auipc	ra,0x2
    3c0a:	fe8080e7          	jalr	-24(ra) # 5bee <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3c0e:	85ca                	mv	a1,s2
    3c10:	00004517          	auipc	a0,0x4
    3c14:	ae050513          	addi	a0,a0,-1312 # 76f0 <malloc+0x16d0>
    3c18:	00002097          	auipc	ra,0x2
    3c1c:	350080e7          	jalr	848(ra) # 5f68 <printf>
    exit(1);
    3c20:	4505                	li	a0,1
    3c22:	00002097          	auipc	ra,0x2
    3c26:	fcc080e7          	jalr	-52(ra) # 5bee <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c2a:	85ca                	mv	a1,s2
    3c2c:	00004517          	auipc	a0,0x4
    3c30:	ae450513          	addi	a0,a0,-1308 # 7710 <malloc+0x16f0>
    3c34:	00002097          	auipc	ra,0x2
    3c38:	334080e7          	jalr	820(ra) # 5f68 <printf>
    exit(1);
    3c3c:	4505                	li	a0,1
    3c3e:	00002097          	auipc	ra,0x2
    3c42:	fb0080e7          	jalr	-80(ra) # 5bee <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c46:	85ca                	mv	a1,s2
    3c48:	00004517          	auipc	a0,0x4
    3c4c:	b0850513          	addi	a0,a0,-1272 # 7750 <malloc+0x1730>
    3c50:	00002097          	auipc	ra,0x2
    3c54:	318080e7          	jalr	792(ra) # 5f68 <printf>
    exit(1);
    3c58:	4505                	li	a0,1
    3c5a:	00002097          	auipc	ra,0x2
    3c5e:	f94080e7          	jalr	-108(ra) # 5bee <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c62:	85ca                	mv	a1,s2
    3c64:	00004517          	auipc	a0,0x4
    3c68:	b1c50513          	addi	a0,a0,-1252 # 7780 <malloc+0x1760>
    3c6c:	00002097          	auipc	ra,0x2
    3c70:	2fc080e7          	jalr	764(ra) # 5f68 <printf>
    exit(1);
    3c74:	4505                	li	a0,1
    3c76:	00002097          	auipc	ra,0x2
    3c7a:	f78080e7          	jalr	-136(ra) # 5bee <exit>
    printf("%s: create dd succeeded!\n", s);
    3c7e:	85ca                	mv	a1,s2
    3c80:	00004517          	auipc	a0,0x4
    3c84:	b2050513          	addi	a0,a0,-1248 # 77a0 <malloc+0x1780>
    3c88:	00002097          	auipc	ra,0x2
    3c8c:	2e0080e7          	jalr	736(ra) # 5f68 <printf>
    exit(1);
    3c90:	4505                	li	a0,1
    3c92:	00002097          	auipc	ra,0x2
    3c96:	f5c080e7          	jalr	-164(ra) # 5bee <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c9a:	85ca                	mv	a1,s2
    3c9c:	00004517          	auipc	a0,0x4
    3ca0:	b2450513          	addi	a0,a0,-1244 # 77c0 <malloc+0x17a0>
    3ca4:	00002097          	auipc	ra,0x2
    3ca8:	2c4080e7          	jalr	708(ra) # 5f68 <printf>
    exit(1);
    3cac:	4505                	li	a0,1
    3cae:	00002097          	auipc	ra,0x2
    3cb2:	f40080e7          	jalr	-192(ra) # 5bee <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3cb6:	85ca                	mv	a1,s2
    3cb8:	00004517          	auipc	a0,0x4
    3cbc:	b2850513          	addi	a0,a0,-1240 # 77e0 <malloc+0x17c0>
    3cc0:	00002097          	auipc	ra,0x2
    3cc4:	2a8080e7          	jalr	680(ra) # 5f68 <printf>
    exit(1);
    3cc8:	4505                	li	a0,1
    3cca:	00002097          	auipc	ra,0x2
    3cce:	f24080e7          	jalr	-220(ra) # 5bee <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cd2:	85ca                	mv	a1,s2
    3cd4:	00004517          	auipc	a0,0x4
    3cd8:	b3c50513          	addi	a0,a0,-1220 # 7810 <malloc+0x17f0>
    3cdc:	00002097          	auipc	ra,0x2
    3ce0:	28c080e7          	jalr	652(ra) # 5f68 <printf>
    exit(1);
    3ce4:	4505                	li	a0,1
    3ce6:	00002097          	auipc	ra,0x2
    3cea:	f08080e7          	jalr	-248(ra) # 5bee <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cee:	85ca                	mv	a1,s2
    3cf0:	00004517          	auipc	a0,0x4
    3cf4:	b4850513          	addi	a0,a0,-1208 # 7838 <malloc+0x1818>
    3cf8:	00002097          	auipc	ra,0x2
    3cfc:	270080e7          	jalr	624(ra) # 5f68 <printf>
    exit(1);
    3d00:	4505                	li	a0,1
    3d02:	00002097          	auipc	ra,0x2
    3d06:	eec080e7          	jalr	-276(ra) # 5bee <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3d0a:	85ca                	mv	a1,s2
    3d0c:	00004517          	auipc	a0,0x4
    3d10:	b5450513          	addi	a0,a0,-1196 # 7860 <malloc+0x1840>
    3d14:	00002097          	auipc	ra,0x2
    3d18:	254080e7          	jalr	596(ra) # 5f68 <printf>
    exit(1);
    3d1c:	4505                	li	a0,1
    3d1e:	00002097          	auipc	ra,0x2
    3d22:	ed0080e7          	jalr	-304(ra) # 5bee <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d26:	85ca                	mv	a1,s2
    3d28:	00004517          	auipc	a0,0x4
    3d2c:	b6050513          	addi	a0,a0,-1184 # 7888 <malloc+0x1868>
    3d30:	00002097          	auipc	ra,0x2
    3d34:	238080e7          	jalr	568(ra) # 5f68 <printf>
    exit(1);
    3d38:	4505                	li	a0,1
    3d3a:	00002097          	auipc	ra,0x2
    3d3e:	eb4080e7          	jalr	-332(ra) # 5bee <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d42:	85ca                	mv	a1,s2
    3d44:	00004517          	auipc	a0,0x4
    3d48:	b6450513          	addi	a0,a0,-1180 # 78a8 <malloc+0x1888>
    3d4c:	00002097          	auipc	ra,0x2
    3d50:	21c080e7          	jalr	540(ra) # 5f68 <printf>
    exit(1);
    3d54:	4505                	li	a0,1
    3d56:	00002097          	auipc	ra,0x2
    3d5a:	e98080e7          	jalr	-360(ra) # 5bee <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d5e:	85ca                	mv	a1,s2
    3d60:	00004517          	auipc	a0,0x4
    3d64:	b6850513          	addi	a0,a0,-1176 # 78c8 <malloc+0x18a8>
    3d68:	00002097          	auipc	ra,0x2
    3d6c:	200080e7          	jalr	512(ra) # 5f68 <printf>
    exit(1);
    3d70:	4505                	li	a0,1
    3d72:	00002097          	auipc	ra,0x2
    3d76:	e7c080e7          	jalr	-388(ra) # 5bee <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d7a:	85ca                	mv	a1,s2
    3d7c:	00004517          	auipc	a0,0x4
    3d80:	b7450513          	addi	a0,a0,-1164 # 78f0 <malloc+0x18d0>
    3d84:	00002097          	auipc	ra,0x2
    3d88:	1e4080e7          	jalr	484(ra) # 5f68 <printf>
    exit(1);
    3d8c:	4505                	li	a0,1
    3d8e:	00002097          	auipc	ra,0x2
    3d92:	e60080e7          	jalr	-416(ra) # 5bee <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d96:	85ca                	mv	a1,s2
    3d98:	00004517          	auipc	a0,0x4
    3d9c:	b7850513          	addi	a0,a0,-1160 # 7910 <malloc+0x18f0>
    3da0:	00002097          	auipc	ra,0x2
    3da4:	1c8080e7          	jalr	456(ra) # 5f68 <printf>
    exit(1);
    3da8:	4505                	li	a0,1
    3daa:	00002097          	auipc	ra,0x2
    3dae:	e44080e7          	jalr	-444(ra) # 5bee <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3db2:	85ca                	mv	a1,s2
    3db4:	00004517          	auipc	a0,0x4
    3db8:	b7c50513          	addi	a0,a0,-1156 # 7930 <malloc+0x1910>
    3dbc:	00002097          	auipc	ra,0x2
    3dc0:	1ac080e7          	jalr	428(ra) # 5f68 <printf>
    exit(1);
    3dc4:	4505                	li	a0,1
    3dc6:	00002097          	auipc	ra,0x2
    3dca:	e28080e7          	jalr	-472(ra) # 5bee <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3dce:	85ca                	mv	a1,s2
    3dd0:	00004517          	auipc	a0,0x4
    3dd4:	b8850513          	addi	a0,a0,-1144 # 7958 <malloc+0x1938>
    3dd8:	00002097          	auipc	ra,0x2
    3ddc:	190080e7          	jalr	400(ra) # 5f68 <printf>
    exit(1);
    3de0:	4505                	li	a0,1
    3de2:	00002097          	auipc	ra,0x2
    3de6:	e0c080e7          	jalr	-500(ra) # 5bee <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3dea:	85ca                	mv	a1,s2
    3dec:	00004517          	auipc	a0,0x4
    3df0:	80450513          	addi	a0,a0,-2044 # 75f0 <malloc+0x15d0>
    3df4:	00002097          	auipc	ra,0x2
    3df8:	174080e7          	jalr	372(ra) # 5f68 <printf>
    exit(1);
    3dfc:	4505                	li	a0,1
    3dfe:	00002097          	auipc	ra,0x2
    3e02:	df0080e7          	jalr	-528(ra) # 5bee <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3e06:	85ca                	mv	a1,s2
    3e08:	00004517          	auipc	a0,0x4
    3e0c:	b7050513          	addi	a0,a0,-1168 # 7978 <malloc+0x1958>
    3e10:	00002097          	auipc	ra,0x2
    3e14:	158080e7          	jalr	344(ra) # 5f68 <printf>
    exit(1);
    3e18:	4505                	li	a0,1
    3e1a:	00002097          	auipc	ra,0x2
    3e1e:	dd4080e7          	jalr	-556(ra) # 5bee <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e22:	85ca                	mv	a1,s2
    3e24:	00004517          	auipc	a0,0x4
    3e28:	b7450513          	addi	a0,a0,-1164 # 7998 <malloc+0x1978>
    3e2c:	00002097          	auipc	ra,0x2
    3e30:	13c080e7          	jalr	316(ra) # 5f68 <printf>
    exit(1);
    3e34:	4505                	li	a0,1
    3e36:	00002097          	auipc	ra,0x2
    3e3a:	db8080e7          	jalr	-584(ra) # 5bee <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e3e:	85ca                	mv	a1,s2
    3e40:	00004517          	auipc	a0,0x4
    3e44:	b8850513          	addi	a0,a0,-1144 # 79c8 <malloc+0x19a8>
    3e48:	00002097          	auipc	ra,0x2
    3e4c:	120080e7          	jalr	288(ra) # 5f68 <printf>
    exit(1);
    3e50:	4505                	li	a0,1
    3e52:	00002097          	auipc	ra,0x2
    3e56:	d9c080e7          	jalr	-612(ra) # 5bee <exit>
    printf("%s: unlink dd failed\n", s);
    3e5a:	85ca                	mv	a1,s2
    3e5c:	00004517          	auipc	a0,0x4
    3e60:	b8c50513          	addi	a0,a0,-1140 # 79e8 <malloc+0x19c8>
    3e64:	00002097          	auipc	ra,0x2
    3e68:	104080e7          	jalr	260(ra) # 5f68 <printf>
    exit(1);
    3e6c:	4505                	li	a0,1
    3e6e:	00002097          	auipc	ra,0x2
    3e72:	d80080e7          	jalr	-640(ra) # 5bee <exit>

0000000000003e76 <rmdot>:
{
    3e76:	1101                	addi	sp,sp,-32
    3e78:	ec06                	sd	ra,24(sp)
    3e7a:	e822                	sd	s0,16(sp)
    3e7c:	e426                	sd	s1,8(sp)
    3e7e:	1000                	addi	s0,sp,32
    3e80:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e82:	00004517          	auipc	a0,0x4
    3e86:	b7e50513          	addi	a0,a0,-1154 # 7a00 <malloc+0x19e0>
    3e8a:	00002097          	auipc	ra,0x2
    3e8e:	dcc080e7          	jalr	-564(ra) # 5c56 <mkdir>
    3e92:	e549                	bnez	a0,3f1c <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e94:	00004517          	auipc	a0,0x4
    3e98:	b6c50513          	addi	a0,a0,-1172 # 7a00 <malloc+0x19e0>
    3e9c:	00002097          	auipc	ra,0x2
    3ea0:	dc2080e7          	jalr	-574(ra) # 5c5e <chdir>
    3ea4:	e951                	bnez	a0,3f38 <rmdot+0xc2>
  if(unlink(".") == 0){
    3ea6:	00003517          	auipc	a0,0x3
    3eaa:	98a50513          	addi	a0,a0,-1654 # 6830 <malloc+0x810>
    3eae:	00002097          	auipc	ra,0x2
    3eb2:	d90080e7          	jalr	-624(ra) # 5c3e <unlink>
    3eb6:	cd59                	beqz	a0,3f54 <rmdot+0xde>
  if(unlink("..") == 0){
    3eb8:	00003517          	auipc	a0,0x3
    3ebc:	5a050513          	addi	a0,a0,1440 # 7458 <malloc+0x1438>
    3ec0:	00002097          	auipc	ra,0x2
    3ec4:	d7e080e7          	jalr	-642(ra) # 5c3e <unlink>
    3ec8:	c545                	beqz	a0,3f70 <rmdot+0xfa>
  if(chdir("/") != 0){
    3eca:	00003517          	auipc	a0,0x3
    3ece:	53650513          	addi	a0,a0,1334 # 7400 <malloc+0x13e0>
    3ed2:	00002097          	auipc	ra,0x2
    3ed6:	d8c080e7          	jalr	-628(ra) # 5c5e <chdir>
    3eda:	e94d                	bnez	a0,3f8c <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3edc:	00004517          	auipc	a0,0x4
    3ee0:	b8c50513          	addi	a0,a0,-1140 # 7a68 <malloc+0x1a48>
    3ee4:	00002097          	auipc	ra,0x2
    3ee8:	d5a080e7          	jalr	-678(ra) # 5c3e <unlink>
    3eec:	cd55                	beqz	a0,3fa8 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3eee:	00004517          	auipc	a0,0x4
    3ef2:	ba250513          	addi	a0,a0,-1118 # 7a90 <malloc+0x1a70>
    3ef6:	00002097          	auipc	ra,0x2
    3efa:	d48080e7          	jalr	-696(ra) # 5c3e <unlink>
    3efe:	c179                	beqz	a0,3fc4 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3f00:	00004517          	auipc	a0,0x4
    3f04:	b0050513          	addi	a0,a0,-1280 # 7a00 <malloc+0x19e0>
    3f08:	00002097          	auipc	ra,0x2
    3f0c:	d36080e7          	jalr	-714(ra) # 5c3e <unlink>
    3f10:	e961                	bnez	a0,3fe0 <rmdot+0x16a>
}
    3f12:	60e2                	ld	ra,24(sp)
    3f14:	6442                	ld	s0,16(sp)
    3f16:	64a2                	ld	s1,8(sp)
    3f18:	6105                	addi	sp,sp,32
    3f1a:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f1c:	85a6                	mv	a1,s1
    3f1e:	00004517          	auipc	a0,0x4
    3f22:	aea50513          	addi	a0,a0,-1302 # 7a08 <malloc+0x19e8>
    3f26:	00002097          	auipc	ra,0x2
    3f2a:	042080e7          	jalr	66(ra) # 5f68 <printf>
    exit(1);
    3f2e:	4505                	li	a0,1
    3f30:	00002097          	auipc	ra,0x2
    3f34:	cbe080e7          	jalr	-834(ra) # 5bee <exit>
    printf("%s: chdir dots failed\n", s);
    3f38:	85a6                	mv	a1,s1
    3f3a:	00004517          	auipc	a0,0x4
    3f3e:	ae650513          	addi	a0,a0,-1306 # 7a20 <malloc+0x1a00>
    3f42:	00002097          	auipc	ra,0x2
    3f46:	026080e7          	jalr	38(ra) # 5f68 <printf>
    exit(1);
    3f4a:	4505                	li	a0,1
    3f4c:	00002097          	auipc	ra,0x2
    3f50:	ca2080e7          	jalr	-862(ra) # 5bee <exit>
    printf("%s: rm . worked!\n", s);
    3f54:	85a6                	mv	a1,s1
    3f56:	00004517          	auipc	a0,0x4
    3f5a:	ae250513          	addi	a0,a0,-1310 # 7a38 <malloc+0x1a18>
    3f5e:	00002097          	auipc	ra,0x2
    3f62:	00a080e7          	jalr	10(ra) # 5f68 <printf>
    exit(1);
    3f66:	4505                	li	a0,1
    3f68:	00002097          	auipc	ra,0x2
    3f6c:	c86080e7          	jalr	-890(ra) # 5bee <exit>
    printf("%s: rm .. worked!\n", s);
    3f70:	85a6                	mv	a1,s1
    3f72:	00004517          	auipc	a0,0x4
    3f76:	ade50513          	addi	a0,a0,-1314 # 7a50 <malloc+0x1a30>
    3f7a:	00002097          	auipc	ra,0x2
    3f7e:	fee080e7          	jalr	-18(ra) # 5f68 <printf>
    exit(1);
    3f82:	4505                	li	a0,1
    3f84:	00002097          	auipc	ra,0x2
    3f88:	c6a080e7          	jalr	-918(ra) # 5bee <exit>
    printf("%s: chdir / failed\n", s);
    3f8c:	85a6                	mv	a1,s1
    3f8e:	00003517          	auipc	a0,0x3
    3f92:	47a50513          	addi	a0,a0,1146 # 7408 <malloc+0x13e8>
    3f96:	00002097          	auipc	ra,0x2
    3f9a:	fd2080e7          	jalr	-46(ra) # 5f68 <printf>
    exit(1);
    3f9e:	4505                	li	a0,1
    3fa0:	00002097          	auipc	ra,0x2
    3fa4:	c4e080e7          	jalr	-946(ra) # 5bee <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3fa8:	85a6                	mv	a1,s1
    3faa:	00004517          	auipc	a0,0x4
    3fae:	ac650513          	addi	a0,a0,-1338 # 7a70 <malloc+0x1a50>
    3fb2:	00002097          	auipc	ra,0x2
    3fb6:	fb6080e7          	jalr	-74(ra) # 5f68 <printf>
    exit(1);
    3fba:	4505                	li	a0,1
    3fbc:	00002097          	auipc	ra,0x2
    3fc0:	c32080e7          	jalr	-974(ra) # 5bee <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3fc4:	85a6                	mv	a1,s1
    3fc6:	00004517          	auipc	a0,0x4
    3fca:	ad250513          	addi	a0,a0,-1326 # 7a98 <malloc+0x1a78>
    3fce:	00002097          	auipc	ra,0x2
    3fd2:	f9a080e7          	jalr	-102(ra) # 5f68 <printf>
    exit(1);
    3fd6:	4505                	li	a0,1
    3fd8:	00002097          	auipc	ra,0x2
    3fdc:	c16080e7          	jalr	-1002(ra) # 5bee <exit>
    printf("%s: unlink dots failed!\n", s);
    3fe0:	85a6                	mv	a1,s1
    3fe2:	00004517          	auipc	a0,0x4
    3fe6:	ad650513          	addi	a0,a0,-1322 # 7ab8 <malloc+0x1a98>
    3fea:	00002097          	auipc	ra,0x2
    3fee:	f7e080e7          	jalr	-130(ra) # 5f68 <printf>
    exit(1);
    3ff2:	4505                	li	a0,1
    3ff4:	00002097          	auipc	ra,0x2
    3ff8:	bfa080e7          	jalr	-1030(ra) # 5bee <exit>

0000000000003ffc <dirfile>:
{
    3ffc:	1101                	addi	sp,sp,-32
    3ffe:	ec06                	sd	ra,24(sp)
    4000:	e822                	sd	s0,16(sp)
    4002:	e426                	sd	s1,8(sp)
    4004:	e04a                	sd	s2,0(sp)
    4006:	1000                	addi	s0,sp,32
    4008:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    400a:	20000593          	li	a1,512
    400e:	00004517          	auipc	a0,0x4
    4012:	aca50513          	addi	a0,a0,-1334 # 7ad8 <malloc+0x1ab8>
    4016:	00002097          	auipc	ra,0x2
    401a:	c18080e7          	jalr	-1000(ra) # 5c2e <open>
  if(fd < 0){
    401e:	0e054d63          	bltz	a0,4118 <dirfile+0x11c>
  close(fd);
    4022:	00002097          	auipc	ra,0x2
    4026:	bf4080e7          	jalr	-1036(ra) # 5c16 <close>
  if(chdir("dirfile") == 0){
    402a:	00004517          	auipc	a0,0x4
    402e:	aae50513          	addi	a0,a0,-1362 # 7ad8 <malloc+0x1ab8>
    4032:	00002097          	auipc	ra,0x2
    4036:	c2c080e7          	jalr	-980(ra) # 5c5e <chdir>
    403a:	cd6d                	beqz	a0,4134 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    403c:	4581                	li	a1,0
    403e:	00004517          	auipc	a0,0x4
    4042:	ae250513          	addi	a0,a0,-1310 # 7b20 <malloc+0x1b00>
    4046:	00002097          	auipc	ra,0x2
    404a:	be8080e7          	jalr	-1048(ra) # 5c2e <open>
  if(fd >= 0){
    404e:	10055163          	bgez	a0,4150 <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4052:	20000593          	li	a1,512
    4056:	00004517          	auipc	a0,0x4
    405a:	aca50513          	addi	a0,a0,-1334 # 7b20 <malloc+0x1b00>
    405e:	00002097          	auipc	ra,0x2
    4062:	bd0080e7          	jalr	-1072(ra) # 5c2e <open>
  if(fd >= 0){
    4066:	10055363          	bgez	a0,416c <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    406a:	00004517          	auipc	a0,0x4
    406e:	ab650513          	addi	a0,a0,-1354 # 7b20 <malloc+0x1b00>
    4072:	00002097          	auipc	ra,0x2
    4076:	be4080e7          	jalr	-1052(ra) # 5c56 <mkdir>
    407a:	10050763          	beqz	a0,4188 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    407e:	00004517          	auipc	a0,0x4
    4082:	aa250513          	addi	a0,a0,-1374 # 7b20 <malloc+0x1b00>
    4086:	00002097          	auipc	ra,0x2
    408a:	bb8080e7          	jalr	-1096(ra) # 5c3e <unlink>
    408e:	10050b63          	beqz	a0,41a4 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4092:	00004597          	auipc	a1,0x4
    4096:	a8e58593          	addi	a1,a1,-1394 # 7b20 <malloc+0x1b00>
    409a:	00002517          	auipc	a0,0x2
    409e:	28650513          	addi	a0,a0,646 # 6320 <malloc+0x300>
    40a2:	00002097          	auipc	ra,0x2
    40a6:	bac080e7          	jalr	-1108(ra) # 5c4e <link>
    40aa:	10050b63          	beqz	a0,41c0 <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    40ae:	00004517          	auipc	a0,0x4
    40b2:	a2a50513          	addi	a0,a0,-1494 # 7ad8 <malloc+0x1ab8>
    40b6:	00002097          	auipc	ra,0x2
    40ba:	b88080e7          	jalr	-1144(ra) # 5c3e <unlink>
    40be:	10051f63          	bnez	a0,41dc <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40c2:	4589                	li	a1,2
    40c4:	00002517          	auipc	a0,0x2
    40c8:	76c50513          	addi	a0,a0,1900 # 6830 <malloc+0x810>
    40cc:	00002097          	auipc	ra,0x2
    40d0:	b62080e7          	jalr	-1182(ra) # 5c2e <open>
  if(fd >= 0){
    40d4:	12055263          	bgez	a0,41f8 <dirfile+0x1fc>
  fd = open(".", 0);
    40d8:	4581                	li	a1,0
    40da:	00002517          	auipc	a0,0x2
    40de:	75650513          	addi	a0,a0,1878 # 6830 <malloc+0x810>
    40e2:	00002097          	auipc	ra,0x2
    40e6:	b4c080e7          	jalr	-1204(ra) # 5c2e <open>
    40ea:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40ec:	4605                	li	a2,1
    40ee:	00002597          	auipc	a1,0x2
    40f2:	0ca58593          	addi	a1,a1,202 # 61b8 <malloc+0x198>
    40f6:	00002097          	auipc	ra,0x2
    40fa:	b18080e7          	jalr	-1256(ra) # 5c0e <write>
    40fe:	10a04b63          	bgtz	a0,4214 <dirfile+0x218>
  close(fd);
    4102:	8526                	mv	a0,s1
    4104:	00002097          	auipc	ra,0x2
    4108:	b12080e7          	jalr	-1262(ra) # 5c16 <close>
}
    410c:	60e2                	ld	ra,24(sp)
    410e:	6442                	ld	s0,16(sp)
    4110:	64a2                	ld	s1,8(sp)
    4112:	6902                	ld	s2,0(sp)
    4114:	6105                	addi	sp,sp,32
    4116:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    4118:	85ca                	mv	a1,s2
    411a:	00004517          	auipc	a0,0x4
    411e:	9c650513          	addi	a0,a0,-1594 # 7ae0 <malloc+0x1ac0>
    4122:	00002097          	auipc	ra,0x2
    4126:	e46080e7          	jalr	-442(ra) # 5f68 <printf>
    exit(1);
    412a:	4505                	li	a0,1
    412c:	00002097          	auipc	ra,0x2
    4130:	ac2080e7          	jalr	-1342(ra) # 5bee <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    4134:	85ca                	mv	a1,s2
    4136:	00004517          	auipc	a0,0x4
    413a:	9ca50513          	addi	a0,a0,-1590 # 7b00 <malloc+0x1ae0>
    413e:	00002097          	auipc	ra,0x2
    4142:	e2a080e7          	jalr	-470(ra) # 5f68 <printf>
    exit(1);
    4146:	4505                	li	a0,1
    4148:	00002097          	auipc	ra,0x2
    414c:	aa6080e7          	jalr	-1370(ra) # 5bee <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4150:	85ca                	mv	a1,s2
    4152:	00004517          	auipc	a0,0x4
    4156:	9de50513          	addi	a0,a0,-1570 # 7b30 <malloc+0x1b10>
    415a:	00002097          	auipc	ra,0x2
    415e:	e0e080e7          	jalr	-498(ra) # 5f68 <printf>
    exit(1);
    4162:	4505                	li	a0,1
    4164:	00002097          	auipc	ra,0x2
    4168:	a8a080e7          	jalr	-1398(ra) # 5bee <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    416c:	85ca                	mv	a1,s2
    416e:	00004517          	auipc	a0,0x4
    4172:	9c250513          	addi	a0,a0,-1598 # 7b30 <malloc+0x1b10>
    4176:	00002097          	auipc	ra,0x2
    417a:	df2080e7          	jalr	-526(ra) # 5f68 <printf>
    exit(1);
    417e:	4505                	li	a0,1
    4180:	00002097          	auipc	ra,0x2
    4184:	a6e080e7          	jalr	-1426(ra) # 5bee <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4188:	85ca                	mv	a1,s2
    418a:	00004517          	auipc	a0,0x4
    418e:	9ce50513          	addi	a0,a0,-1586 # 7b58 <malloc+0x1b38>
    4192:	00002097          	auipc	ra,0x2
    4196:	dd6080e7          	jalr	-554(ra) # 5f68 <printf>
    exit(1);
    419a:	4505                	li	a0,1
    419c:	00002097          	auipc	ra,0x2
    41a0:	a52080e7          	jalr	-1454(ra) # 5bee <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    41a4:	85ca                	mv	a1,s2
    41a6:	00004517          	auipc	a0,0x4
    41aa:	9da50513          	addi	a0,a0,-1574 # 7b80 <malloc+0x1b60>
    41ae:	00002097          	auipc	ra,0x2
    41b2:	dba080e7          	jalr	-582(ra) # 5f68 <printf>
    exit(1);
    41b6:	4505                	li	a0,1
    41b8:	00002097          	auipc	ra,0x2
    41bc:	a36080e7          	jalr	-1482(ra) # 5bee <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41c0:	85ca                	mv	a1,s2
    41c2:	00004517          	auipc	a0,0x4
    41c6:	9e650513          	addi	a0,a0,-1562 # 7ba8 <malloc+0x1b88>
    41ca:	00002097          	auipc	ra,0x2
    41ce:	d9e080e7          	jalr	-610(ra) # 5f68 <printf>
    exit(1);
    41d2:	4505                	li	a0,1
    41d4:	00002097          	auipc	ra,0x2
    41d8:	a1a080e7          	jalr	-1510(ra) # 5bee <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41dc:	85ca                	mv	a1,s2
    41de:	00004517          	auipc	a0,0x4
    41e2:	9f250513          	addi	a0,a0,-1550 # 7bd0 <malloc+0x1bb0>
    41e6:	00002097          	auipc	ra,0x2
    41ea:	d82080e7          	jalr	-638(ra) # 5f68 <printf>
    exit(1);
    41ee:	4505                	li	a0,1
    41f0:	00002097          	auipc	ra,0x2
    41f4:	9fe080e7          	jalr	-1538(ra) # 5bee <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41f8:	85ca                	mv	a1,s2
    41fa:	00004517          	auipc	a0,0x4
    41fe:	9f650513          	addi	a0,a0,-1546 # 7bf0 <malloc+0x1bd0>
    4202:	00002097          	auipc	ra,0x2
    4206:	d66080e7          	jalr	-666(ra) # 5f68 <printf>
    exit(1);
    420a:	4505                	li	a0,1
    420c:	00002097          	auipc	ra,0x2
    4210:	9e2080e7          	jalr	-1566(ra) # 5bee <exit>
    printf("%s: write . succeeded!\n", s);
    4214:	85ca                	mv	a1,s2
    4216:	00004517          	auipc	a0,0x4
    421a:	a0250513          	addi	a0,a0,-1534 # 7c18 <malloc+0x1bf8>
    421e:	00002097          	auipc	ra,0x2
    4222:	d4a080e7          	jalr	-694(ra) # 5f68 <printf>
    exit(1);
    4226:	4505                	li	a0,1
    4228:	00002097          	auipc	ra,0x2
    422c:	9c6080e7          	jalr	-1594(ra) # 5bee <exit>

0000000000004230 <iref>:
{
    4230:	7139                	addi	sp,sp,-64
    4232:	fc06                	sd	ra,56(sp)
    4234:	f822                	sd	s0,48(sp)
    4236:	f426                	sd	s1,40(sp)
    4238:	f04a                	sd	s2,32(sp)
    423a:	ec4e                	sd	s3,24(sp)
    423c:	e852                	sd	s4,16(sp)
    423e:	e456                	sd	s5,8(sp)
    4240:	e05a                	sd	s6,0(sp)
    4242:	0080                	addi	s0,sp,64
    4244:	8b2a                	mv	s6,a0
    4246:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    424a:	00004a17          	auipc	s4,0x4
    424e:	9e6a0a13          	addi	s4,s4,-1562 # 7c30 <malloc+0x1c10>
    mkdir("");
    4252:	00003497          	auipc	s1,0x3
    4256:	4e648493          	addi	s1,s1,1254 # 7738 <malloc+0x1718>
    link("README", "");
    425a:	00002a97          	auipc	s5,0x2
    425e:	0c6a8a93          	addi	s5,s5,198 # 6320 <malloc+0x300>
    fd = open("xx", O_CREATE);
    4262:	00004997          	auipc	s3,0x4
    4266:	8c698993          	addi	s3,s3,-1850 # 7b28 <malloc+0x1b08>
    426a:	a891                	j	42be <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    426c:	85da                	mv	a1,s6
    426e:	00004517          	auipc	a0,0x4
    4272:	9ca50513          	addi	a0,a0,-1590 # 7c38 <malloc+0x1c18>
    4276:	00002097          	auipc	ra,0x2
    427a:	cf2080e7          	jalr	-782(ra) # 5f68 <printf>
      exit(1);
    427e:	4505                	li	a0,1
    4280:	00002097          	auipc	ra,0x2
    4284:	96e080e7          	jalr	-1682(ra) # 5bee <exit>
      printf("%s: chdir irefd failed\n", s);
    4288:	85da                	mv	a1,s6
    428a:	00004517          	auipc	a0,0x4
    428e:	9c650513          	addi	a0,a0,-1594 # 7c50 <malloc+0x1c30>
    4292:	00002097          	auipc	ra,0x2
    4296:	cd6080e7          	jalr	-810(ra) # 5f68 <printf>
      exit(1);
    429a:	4505                	li	a0,1
    429c:	00002097          	auipc	ra,0x2
    42a0:	952080e7          	jalr	-1710(ra) # 5bee <exit>
      close(fd);
    42a4:	00002097          	auipc	ra,0x2
    42a8:	972080e7          	jalr	-1678(ra) # 5c16 <close>
    42ac:	a889                	j	42fe <iref+0xce>
    unlink("xx");
    42ae:	854e                	mv	a0,s3
    42b0:	00002097          	auipc	ra,0x2
    42b4:	98e080e7          	jalr	-1650(ra) # 5c3e <unlink>
  for(i = 0; i < NINODE + 1; i++){
    42b8:	397d                	addiw	s2,s2,-1
    42ba:	06090063          	beqz	s2,431a <iref+0xea>
    if(mkdir("irefd") != 0){
    42be:	8552                	mv	a0,s4
    42c0:	00002097          	auipc	ra,0x2
    42c4:	996080e7          	jalr	-1642(ra) # 5c56 <mkdir>
    42c8:	f155                	bnez	a0,426c <iref+0x3c>
    if(chdir("irefd") != 0){
    42ca:	8552                	mv	a0,s4
    42cc:	00002097          	auipc	ra,0x2
    42d0:	992080e7          	jalr	-1646(ra) # 5c5e <chdir>
    42d4:	f955                	bnez	a0,4288 <iref+0x58>
    mkdir("");
    42d6:	8526                	mv	a0,s1
    42d8:	00002097          	auipc	ra,0x2
    42dc:	97e080e7          	jalr	-1666(ra) # 5c56 <mkdir>
    link("README", "");
    42e0:	85a6                	mv	a1,s1
    42e2:	8556                	mv	a0,s5
    42e4:	00002097          	auipc	ra,0x2
    42e8:	96a080e7          	jalr	-1686(ra) # 5c4e <link>
    fd = open("", O_CREATE);
    42ec:	20000593          	li	a1,512
    42f0:	8526                	mv	a0,s1
    42f2:	00002097          	auipc	ra,0x2
    42f6:	93c080e7          	jalr	-1732(ra) # 5c2e <open>
    if(fd >= 0)
    42fa:	fa0555e3          	bgez	a0,42a4 <iref+0x74>
    fd = open("xx", O_CREATE);
    42fe:	20000593          	li	a1,512
    4302:	854e                	mv	a0,s3
    4304:	00002097          	auipc	ra,0x2
    4308:	92a080e7          	jalr	-1750(ra) # 5c2e <open>
    if(fd >= 0)
    430c:	fa0541e3          	bltz	a0,42ae <iref+0x7e>
      close(fd);
    4310:	00002097          	auipc	ra,0x2
    4314:	906080e7          	jalr	-1786(ra) # 5c16 <close>
    4318:	bf59                	j	42ae <iref+0x7e>
    431a:	03300493          	li	s1,51
    chdir("..");
    431e:	00003997          	auipc	s3,0x3
    4322:	13a98993          	addi	s3,s3,314 # 7458 <malloc+0x1438>
    unlink("irefd");
    4326:	00004917          	auipc	s2,0x4
    432a:	90a90913          	addi	s2,s2,-1782 # 7c30 <malloc+0x1c10>
    chdir("..");
    432e:	854e                	mv	a0,s3
    4330:	00002097          	auipc	ra,0x2
    4334:	92e080e7          	jalr	-1746(ra) # 5c5e <chdir>
    unlink("irefd");
    4338:	854a                	mv	a0,s2
    433a:	00002097          	auipc	ra,0x2
    433e:	904080e7          	jalr	-1788(ra) # 5c3e <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4342:	34fd                	addiw	s1,s1,-1
    4344:	f4ed                	bnez	s1,432e <iref+0xfe>
  chdir("/");
    4346:	00003517          	auipc	a0,0x3
    434a:	0ba50513          	addi	a0,a0,186 # 7400 <malloc+0x13e0>
    434e:	00002097          	auipc	ra,0x2
    4352:	910080e7          	jalr	-1776(ra) # 5c5e <chdir>
}
    4356:	70e2                	ld	ra,56(sp)
    4358:	7442                	ld	s0,48(sp)
    435a:	74a2                	ld	s1,40(sp)
    435c:	7902                	ld	s2,32(sp)
    435e:	69e2                	ld	s3,24(sp)
    4360:	6a42                	ld	s4,16(sp)
    4362:	6aa2                	ld	s5,8(sp)
    4364:	6b02                	ld	s6,0(sp)
    4366:	6121                	addi	sp,sp,64
    4368:	8082                	ret

000000000000436a <openiputtest>:
{
    436a:	7179                	addi	sp,sp,-48
    436c:	f406                	sd	ra,40(sp)
    436e:	f022                	sd	s0,32(sp)
    4370:	ec26                	sd	s1,24(sp)
    4372:	1800                	addi	s0,sp,48
    4374:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    4376:	00004517          	auipc	a0,0x4
    437a:	8f250513          	addi	a0,a0,-1806 # 7c68 <malloc+0x1c48>
    437e:	00002097          	auipc	ra,0x2
    4382:	8d8080e7          	jalr	-1832(ra) # 5c56 <mkdir>
    4386:	04054263          	bltz	a0,43ca <openiputtest+0x60>
  pid = fork();
    438a:	00002097          	auipc	ra,0x2
    438e:	85c080e7          	jalr	-1956(ra) # 5be6 <fork>
  if(pid < 0){
    4392:	04054a63          	bltz	a0,43e6 <openiputtest+0x7c>
  if(pid == 0){
    4396:	e93d                	bnez	a0,440c <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    4398:	4589                	li	a1,2
    439a:	00004517          	auipc	a0,0x4
    439e:	8ce50513          	addi	a0,a0,-1842 # 7c68 <malloc+0x1c48>
    43a2:	00002097          	auipc	ra,0x2
    43a6:	88c080e7          	jalr	-1908(ra) # 5c2e <open>
    if(fd >= 0){
    43aa:	04054c63          	bltz	a0,4402 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    43ae:	85a6                	mv	a1,s1
    43b0:	00004517          	auipc	a0,0x4
    43b4:	8d850513          	addi	a0,a0,-1832 # 7c88 <malloc+0x1c68>
    43b8:	00002097          	auipc	ra,0x2
    43bc:	bb0080e7          	jalr	-1104(ra) # 5f68 <printf>
      exit(1);
    43c0:	4505                	li	a0,1
    43c2:	00002097          	auipc	ra,0x2
    43c6:	82c080e7          	jalr	-2004(ra) # 5bee <exit>
    printf("%s: mkdir oidir failed\n", s);
    43ca:	85a6                	mv	a1,s1
    43cc:	00004517          	auipc	a0,0x4
    43d0:	8a450513          	addi	a0,a0,-1884 # 7c70 <malloc+0x1c50>
    43d4:	00002097          	auipc	ra,0x2
    43d8:	b94080e7          	jalr	-1132(ra) # 5f68 <printf>
    exit(1);
    43dc:	4505                	li	a0,1
    43de:	00002097          	auipc	ra,0x2
    43e2:	810080e7          	jalr	-2032(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    43e6:	85a6                	mv	a1,s1
    43e8:	00002517          	auipc	a0,0x2
    43ec:	5e850513          	addi	a0,a0,1512 # 69d0 <malloc+0x9b0>
    43f0:	00002097          	auipc	ra,0x2
    43f4:	b78080e7          	jalr	-1160(ra) # 5f68 <printf>
    exit(1);
    43f8:	4505                	li	a0,1
    43fa:	00001097          	auipc	ra,0x1
    43fe:	7f4080e7          	jalr	2036(ra) # 5bee <exit>
    exit(0);
    4402:	4501                	li	a0,0
    4404:	00001097          	auipc	ra,0x1
    4408:	7ea080e7          	jalr	2026(ra) # 5bee <exit>
  sleep(1);
    440c:	4505                	li	a0,1
    440e:	00002097          	auipc	ra,0x2
    4412:	870080e7          	jalr	-1936(ra) # 5c7e <sleep>
  if(unlink("oidir") != 0){
    4416:	00004517          	auipc	a0,0x4
    441a:	85250513          	addi	a0,a0,-1966 # 7c68 <malloc+0x1c48>
    441e:	00002097          	auipc	ra,0x2
    4422:	820080e7          	jalr	-2016(ra) # 5c3e <unlink>
    4426:	cd19                	beqz	a0,4444 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    4428:	85a6                	mv	a1,s1
    442a:	00002517          	auipc	a0,0x2
    442e:	79650513          	addi	a0,a0,1942 # 6bc0 <malloc+0xba0>
    4432:	00002097          	auipc	ra,0x2
    4436:	b36080e7          	jalr	-1226(ra) # 5f68 <printf>
    exit(1);
    443a:	4505                	li	a0,1
    443c:	00001097          	auipc	ra,0x1
    4440:	7b2080e7          	jalr	1970(ra) # 5bee <exit>
  wait(&xstatus);
    4444:	fdc40513          	addi	a0,s0,-36
    4448:	00001097          	auipc	ra,0x1
    444c:	7ae080e7          	jalr	1966(ra) # 5bf6 <wait>
  exit(xstatus);
    4450:	fdc42503          	lw	a0,-36(s0)
    4454:	00001097          	auipc	ra,0x1
    4458:	79a080e7          	jalr	1946(ra) # 5bee <exit>

000000000000445c <forkforkfork>:
{
    445c:	1101                	addi	sp,sp,-32
    445e:	ec06                	sd	ra,24(sp)
    4460:	e822                	sd	s0,16(sp)
    4462:	e426                	sd	s1,8(sp)
    4464:	1000                	addi	s0,sp,32
    4466:	84aa                	mv	s1,a0
  unlink("stopforking");
    4468:	00004517          	auipc	a0,0x4
    446c:	84850513          	addi	a0,a0,-1976 # 7cb0 <malloc+0x1c90>
    4470:	00001097          	auipc	ra,0x1
    4474:	7ce080e7          	jalr	1998(ra) # 5c3e <unlink>
  int pid = fork();
    4478:	00001097          	auipc	ra,0x1
    447c:	76e080e7          	jalr	1902(ra) # 5be6 <fork>
  if(pid < 0){
    4480:	04054563          	bltz	a0,44ca <forkforkfork+0x6e>
  if(pid == 0){
    4484:	c12d                	beqz	a0,44e6 <forkforkfork+0x8a>
  sleep(20); // two seconds
    4486:	4551                	li	a0,20
    4488:	00001097          	auipc	ra,0x1
    448c:	7f6080e7          	jalr	2038(ra) # 5c7e <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4490:	20200593          	li	a1,514
    4494:	00004517          	auipc	a0,0x4
    4498:	81c50513          	addi	a0,a0,-2020 # 7cb0 <malloc+0x1c90>
    449c:	00001097          	auipc	ra,0x1
    44a0:	792080e7          	jalr	1938(ra) # 5c2e <open>
    44a4:	00001097          	auipc	ra,0x1
    44a8:	772080e7          	jalr	1906(ra) # 5c16 <close>
  wait(0);
    44ac:	4501                	li	a0,0
    44ae:	00001097          	auipc	ra,0x1
    44b2:	748080e7          	jalr	1864(ra) # 5bf6 <wait>
  sleep(10); // one second
    44b6:	4529                	li	a0,10
    44b8:	00001097          	auipc	ra,0x1
    44bc:	7c6080e7          	jalr	1990(ra) # 5c7e <sleep>
}
    44c0:	60e2                	ld	ra,24(sp)
    44c2:	6442                	ld	s0,16(sp)
    44c4:	64a2                	ld	s1,8(sp)
    44c6:	6105                	addi	sp,sp,32
    44c8:	8082                	ret
    printf("%s: fork failed", s);
    44ca:	85a6                	mv	a1,s1
    44cc:	00002517          	auipc	a0,0x2
    44d0:	6c450513          	addi	a0,a0,1732 # 6b90 <malloc+0xb70>
    44d4:	00002097          	auipc	ra,0x2
    44d8:	a94080e7          	jalr	-1388(ra) # 5f68 <printf>
    exit(1);
    44dc:	4505                	li	a0,1
    44de:	00001097          	auipc	ra,0x1
    44e2:	710080e7          	jalr	1808(ra) # 5bee <exit>
      int fd = open("stopforking", 0);
    44e6:	00003497          	auipc	s1,0x3
    44ea:	7ca48493          	addi	s1,s1,1994 # 7cb0 <malloc+0x1c90>
    44ee:	4581                	li	a1,0
    44f0:	8526                	mv	a0,s1
    44f2:	00001097          	auipc	ra,0x1
    44f6:	73c080e7          	jalr	1852(ra) # 5c2e <open>
      if(fd >= 0){
    44fa:	02055463          	bgez	a0,4522 <forkforkfork+0xc6>
      if(fork() < 0){
    44fe:	00001097          	auipc	ra,0x1
    4502:	6e8080e7          	jalr	1768(ra) # 5be6 <fork>
    4506:	fe0554e3          	bgez	a0,44ee <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    450a:	20200593          	li	a1,514
    450e:	8526                	mv	a0,s1
    4510:	00001097          	auipc	ra,0x1
    4514:	71e080e7          	jalr	1822(ra) # 5c2e <open>
    4518:	00001097          	auipc	ra,0x1
    451c:	6fe080e7          	jalr	1790(ra) # 5c16 <close>
    4520:	b7f9                	j	44ee <forkforkfork+0x92>
        exit(0);
    4522:	4501                	li	a0,0
    4524:	00001097          	auipc	ra,0x1
    4528:	6ca080e7          	jalr	1738(ra) # 5bee <exit>

000000000000452c <killstatus>:
{
    452c:	7139                	addi	sp,sp,-64
    452e:	fc06                	sd	ra,56(sp)
    4530:	f822                	sd	s0,48(sp)
    4532:	f426                	sd	s1,40(sp)
    4534:	f04a                	sd	s2,32(sp)
    4536:	ec4e                	sd	s3,24(sp)
    4538:	e852                	sd	s4,16(sp)
    453a:	0080                	addi	s0,sp,64
    453c:	8a2a                	mv	s4,a0
    453e:	06400913          	li	s2,100
    if(xst != -1) {
    4542:	59fd                	li	s3,-1
    int pid1 = fork();
    4544:	00001097          	auipc	ra,0x1
    4548:	6a2080e7          	jalr	1698(ra) # 5be6 <fork>
    454c:	84aa                	mv	s1,a0
    if(pid1 < 0){
    454e:	02054f63          	bltz	a0,458c <killstatus+0x60>
    if(pid1 == 0){
    4552:	c939                	beqz	a0,45a8 <killstatus+0x7c>
    sleep(1);
    4554:	4505                	li	a0,1
    4556:	00001097          	auipc	ra,0x1
    455a:	728080e7          	jalr	1832(ra) # 5c7e <sleep>
    kill(pid1);
    455e:	8526                	mv	a0,s1
    4560:	00001097          	auipc	ra,0x1
    4564:	6be080e7          	jalr	1726(ra) # 5c1e <kill>
    wait(&xst);
    4568:	fcc40513          	addi	a0,s0,-52
    456c:	00001097          	auipc	ra,0x1
    4570:	68a080e7          	jalr	1674(ra) # 5bf6 <wait>
    if(xst != -1) {
    4574:	fcc42783          	lw	a5,-52(s0)
    4578:	03379d63          	bne	a5,s3,45b2 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    457c:	397d                	addiw	s2,s2,-1
    457e:	fc0913e3          	bnez	s2,4544 <killstatus+0x18>
  exit(0);
    4582:	4501                	li	a0,0
    4584:	00001097          	auipc	ra,0x1
    4588:	66a080e7          	jalr	1642(ra) # 5bee <exit>
      printf("%s: fork failed\n", s);
    458c:	85d2                	mv	a1,s4
    458e:	00002517          	auipc	a0,0x2
    4592:	44250513          	addi	a0,a0,1090 # 69d0 <malloc+0x9b0>
    4596:	00002097          	auipc	ra,0x2
    459a:	9d2080e7          	jalr	-1582(ra) # 5f68 <printf>
      exit(1);
    459e:	4505                	li	a0,1
    45a0:	00001097          	auipc	ra,0x1
    45a4:	64e080e7          	jalr	1614(ra) # 5bee <exit>
        getpid();
    45a8:	00001097          	auipc	ra,0x1
    45ac:	6c6080e7          	jalr	1734(ra) # 5c6e <getpid>
      while(1) {
    45b0:	bfe5                	j	45a8 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    45b2:	85d2                	mv	a1,s4
    45b4:	00003517          	auipc	a0,0x3
    45b8:	70c50513          	addi	a0,a0,1804 # 7cc0 <malloc+0x1ca0>
    45bc:	00002097          	auipc	ra,0x2
    45c0:	9ac080e7          	jalr	-1620(ra) # 5f68 <printf>
       exit(1);
    45c4:	4505                	li	a0,1
    45c6:	00001097          	auipc	ra,0x1
    45ca:	628080e7          	jalr	1576(ra) # 5bee <exit>

00000000000045ce <preempt>:
{
    45ce:	7139                	addi	sp,sp,-64
    45d0:	fc06                	sd	ra,56(sp)
    45d2:	f822                	sd	s0,48(sp)
    45d4:	f426                	sd	s1,40(sp)
    45d6:	f04a                	sd	s2,32(sp)
    45d8:	ec4e                	sd	s3,24(sp)
    45da:	e852                	sd	s4,16(sp)
    45dc:	0080                	addi	s0,sp,64
    45de:	892a                	mv	s2,a0
  pid1 = fork();
    45e0:	00001097          	auipc	ra,0x1
    45e4:	606080e7          	jalr	1542(ra) # 5be6 <fork>
  if(pid1 < 0) {
    45e8:	00054563          	bltz	a0,45f2 <preempt+0x24>
    45ec:	84aa                	mv	s1,a0
  if(pid1 == 0)
    45ee:	e105                	bnez	a0,460e <preempt+0x40>
    for(;;)
    45f0:	a001                	j	45f0 <preempt+0x22>
    printf("%s: fork failed", s);
    45f2:	85ca                	mv	a1,s2
    45f4:	00002517          	auipc	a0,0x2
    45f8:	59c50513          	addi	a0,a0,1436 # 6b90 <malloc+0xb70>
    45fc:	00002097          	auipc	ra,0x2
    4600:	96c080e7          	jalr	-1684(ra) # 5f68 <printf>
    exit(1);
    4604:	4505                	li	a0,1
    4606:	00001097          	auipc	ra,0x1
    460a:	5e8080e7          	jalr	1512(ra) # 5bee <exit>
  pid2 = fork();
    460e:	00001097          	auipc	ra,0x1
    4612:	5d8080e7          	jalr	1496(ra) # 5be6 <fork>
    4616:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4618:	00054463          	bltz	a0,4620 <preempt+0x52>
  if(pid2 == 0)
    461c:	e105                	bnez	a0,463c <preempt+0x6e>
    for(;;)
    461e:	a001                	j	461e <preempt+0x50>
    printf("%s: fork failed\n", s);
    4620:	85ca                	mv	a1,s2
    4622:	00002517          	auipc	a0,0x2
    4626:	3ae50513          	addi	a0,a0,942 # 69d0 <malloc+0x9b0>
    462a:	00002097          	auipc	ra,0x2
    462e:	93e080e7          	jalr	-1730(ra) # 5f68 <printf>
    exit(1);
    4632:	4505                	li	a0,1
    4634:	00001097          	auipc	ra,0x1
    4638:	5ba080e7          	jalr	1466(ra) # 5bee <exit>
  pipe(pfds);
    463c:	fc840513          	addi	a0,s0,-56
    4640:	00001097          	auipc	ra,0x1
    4644:	5be080e7          	jalr	1470(ra) # 5bfe <pipe>
  pid3 = fork();
    4648:	00001097          	auipc	ra,0x1
    464c:	59e080e7          	jalr	1438(ra) # 5be6 <fork>
    4650:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    4652:	02054e63          	bltz	a0,468e <preempt+0xc0>
  if(pid3 == 0){
    4656:	e525                	bnez	a0,46be <preempt+0xf0>
    close(pfds[0]);
    4658:	fc842503          	lw	a0,-56(s0)
    465c:	00001097          	auipc	ra,0x1
    4660:	5ba080e7          	jalr	1466(ra) # 5c16 <close>
    if(write(pfds[1], "x", 1) != 1)
    4664:	4605                	li	a2,1
    4666:	00002597          	auipc	a1,0x2
    466a:	b5258593          	addi	a1,a1,-1198 # 61b8 <malloc+0x198>
    466e:	fcc42503          	lw	a0,-52(s0)
    4672:	00001097          	auipc	ra,0x1
    4676:	59c080e7          	jalr	1436(ra) # 5c0e <write>
    467a:	4785                	li	a5,1
    467c:	02f51763          	bne	a0,a5,46aa <preempt+0xdc>
    close(pfds[1]);
    4680:	fcc42503          	lw	a0,-52(s0)
    4684:	00001097          	auipc	ra,0x1
    4688:	592080e7          	jalr	1426(ra) # 5c16 <close>
    for(;;)
    468c:	a001                	j	468c <preempt+0xbe>
     printf("%s: fork failed\n", s);
    468e:	85ca                	mv	a1,s2
    4690:	00002517          	auipc	a0,0x2
    4694:	34050513          	addi	a0,a0,832 # 69d0 <malloc+0x9b0>
    4698:	00002097          	auipc	ra,0x2
    469c:	8d0080e7          	jalr	-1840(ra) # 5f68 <printf>
     exit(1);
    46a0:	4505                	li	a0,1
    46a2:	00001097          	auipc	ra,0x1
    46a6:	54c080e7          	jalr	1356(ra) # 5bee <exit>
      printf("%s: preempt write error", s);
    46aa:	85ca                	mv	a1,s2
    46ac:	00003517          	auipc	a0,0x3
    46b0:	63450513          	addi	a0,a0,1588 # 7ce0 <malloc+0x1cc0>
    46b4:	00002097          	auipc	ra,0x2
    46b8:	8b4080e7          	jalr	-1868(ra) # 5f68 <printf>
    46bc:	b7d1                	j	4680 <preempt+0xb2>
  close(pfds[1]);
    46be:	fcc42503          	lw	a0,-52(s0)
    46c2:	00001097          	auipc	ra,0x1
    46c6:	554080e7          	jalr	1364(ra) # 5c16 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46ca:	660d                	lui	a2,0x3
    46cc:	00008597          	auipc	a1,0x8
    46d0:	5ac58593          	addi	a1,a1,1452 # cc78 <buf>
    46d4:	fc842503          	lw	a0,-56(s0)
    46d8:	00001097          	auipc	ra,0x1
    46dc:	52e080e7          	jalr	1326(ra) # 5c06 <read>
    46e0:	4785                	li	a5,1
    46e2:	02f50363          	beq	a0,a5,4708 <preempt+0x13a>
    printf("%s: preempt read error", s);
    46e6:	85ca                	mv	a1,s2
    46e8:	00003517          	auipc	a0,0x3
    46ec:	61050513          	addi	a0,a0,1552 # 7cf8 <malloc+0x1cd8>
    46f0:	00002097          	auipc	ra,0x2
    46f4:	878080e7          	jalr	-1928(ra) # 5f68 <printf>
}
    46f8:	70e2                	ld	ra,56(sp)
    46fa:	7442                	ld	s0,48(sp)
    46fc:	74a2                	ld	s1,40(sp)
    46fe:	7902                	ld	s2,32(sp)
    4700:	69e2                	ld	s3,24(sp)
    4702:	6a42                	ld	s4,16(sp)
    4704:	6121                	addi	sp,sp,64
    4706:	8082                	ret
  close(pfds[0]);
    4708:	fc842503          	lw	a0,-56(s0)
    470c:	00001097          	auipc	ra,0x1
    4710:	50a080e7          	jalr	1290(ra) # 5c16 <close>
  printf("kill... ");
    4714:	00003517          	auipc	a0,0x3
    4718:	5fc50513          	addi	a0,a0,1532 # 7d10 <malloc+0x1cf0>
    471c:	00002097          	auipc	ra,0x2
    4720:	84c080e7          	jalr	-1972(ra) # 5f68 <printf>
  kill(pid1);
    4724:	8526                	mv	a0,s1
    4726:	00001097          	auipc	ra,0x1
    472a:	4f8080e7          	jalr	1272(ra) # 5c1e <kill>
  kill(pid2);
    472e:	854e                	mv	a0,s3
    4730:	00001097          	auipc	ra,0x1
    4734:	4ee080e7          	jalr	1262(ra) # 5c1e <kill>
  kill(pid3);
    4738:	8552                	mv	a0,s4
    473a:	00001097          	auipc	ra,0x1
    473e:	4e4080e7          	jalr	1252(ra) # 5c1e <kill>
  printf("wait... ");
    4742:	00003517          	auipc	a0,0x3
    4746:	5de50513          	addi	a0,a0,1502 # 7d20 <malloc+0x1d00>
    474a:	00002097          	auipc	ra,0x2
    474e:	81e080e7          	jalr	-2018(ra) # 5f68 <printf>
  wait(0);
    4752:	4501                	li	a0,0
    4754:	00001097          	auipc	ra,0x1
    4758:	4a2080e7          	jalr	1186(ra) # 5bf6 <wait>
  wait(0);
    475c:	4501                	li	a0,0
    475e:	00001097          	auipc	ra,0x1
    4762:	498080e7          	jalr	1176(ra) # 5bf6 <wait>
  wait(0);
    4766:	4501                	li	a0,0
    4768:	00001097          	auipc	ra,0x1
    476c:	48e080e7          	jalr	1166(ra) # 5bf6 <wait>
    4770:	b761                	j	46f8 <preempt+0x12a>

0000000000004772 <reparent>:
{
    4772:	7179                	addi	sp,sp,-48
    4774:	f406                	sd	ra,40(sp)
    4776:	f022                	sd	s0,32(sp)
    4778:	ec26                	sd	s1,24(sp)
    477a:	e84a                	sd	s2,16(sp)
    477c:	e44e                	sd	s3,8(sp)
    477e:	e052                	sd	s4,0(sp)
    4780:	1800                	addi	s0,sp,48
    4782:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4784:	00001097          	auipc	ra,0x1
    4788:	4ea080e7          	jalr	1258(ra) # 5c6e <getpid>
    478c:	8a2a                	mv	s4,a0
    478e:	0c800913          	li	s2,200
    int pid = fork();
    4792:	00001097          	auipc	ra,0x1
    4796:	454080e7          	jalr	1108(ra) # 5be6 <fork>
    479a:	84aa                	mv	s1,a0
    if(pid < 0){
    479c:	02054263          	bltz	a0,47c0 <reparent+0x4e>
    if(pid){
    47a0:	cd21                	beqz	a0,47f8 <reparent+0x86>
      if(wait(0) != pid){
    47a2:	4501                	li	a0,0
    47a4:	00001097          	auipc	ra,0x1
    47a8:	452080e7          	jalr	1106(ra) # 5bf6 <wait>
    47ac:	02951863          	bne	a0,s1,47dc <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    47b0:	397d                	addiw	s2,s2,-1
    47b2:	fe0910e3          	bnez	s2,4792 <reparent+0x20>
  exit(0);
    47b6:	4501                	li	a0,0
    47b8:	00001097          	auipc	ra,0x1
    47bc:	436080e7          	jalr	1078(ra) # 5bee <exit>
      printf("%s: fork failed\n", s);
    47c0:	85ce                	mv	a1,s3
    47c2:	00002517          	auipc	a0,0x2
    47c6:	20e50513          	addi	a0,a0,526 # 69d0 <malloc+0x9b0>
    47ca:	00001097          	auipc	ra,0x1
    47ce:	79e080e7          	jalr	1950(ra) # 5f68 <printf>
      exit(1);
    47d2:	4505                	li	a0,1
    47d4:	00001097          	auipc	ra,0x1
    47d8:	41a080e7          	jalr	1050(ra) # 5bee <exit>
        printf("%s: wait wrong pid\n", s);
    47dc:	85ce                	mv	a1,s3
    47de:	00002517          	auipc	a0,0x2
    47e2:	37a50513          	addi	a0,a0,890 # 6b58 <malloc+0xb38>
    47e6:	00001097          	auipc	ra,0x1
    47ea:	782080e7          	jalr	1922(ra) # 5f68 <printf>
        exit(1);
    47ee:	4505                	li	a0,1
    47f0:	00001097          	auipc	ra,0x1
    47f4:	3fe080e7          	jalr	1022(ra) # 5bee <exit>
      int pid2 = fork();
    47f8:	00001097          	auipc	ra,0x1
    47fc:	3ee080e7          	jalr	1006(ra) # 5be6 <fork>
      if(pid2 < 0){
    4800:	00054763          	bltz	a0,480e <reparent+0x9c>
      exit(0);
    4804:	4501                	li	a0,0
    4806:	00001097          	auipc	ra,0x1
    480a:	3e8080e7          	jalr	1000(ra) # 5bee <exit>
        kill(master_pid);
    480e:	8552                	mv	a0,s4
    4810:	00001097          	auipc	ra,0x1
    4814:	40e080e7          	jalr	1038(ra) # 5c1e <kill>
        exit(1);
    4818:	4505                	li	a0,1
    481a:	00001097          	auipc	ra,0x1
    481e:	3d4080e7          	jalr	980(ra) # 5bee <exit>

0000000000004822 <sbrkfail>:
{
    4822:	7119                	addi	sp,sp,-128
    4824:	fc86                	sd	ra,120(sp)
    4826:	f8a2                	sd	s0,112(sp)
    4828:	f4a6                	sd	s1,104(sp)
    482a:	f0ca                	sd	s2,96(sp)
    482c:	ecce                	sd	s3,88(sp)
    482e:	e8d2                	sd	s4,80(sp)
    4830:	e4d6                	sd	s5,72(sp)
    4832:	0100                	addi	s0,sp,128
    4834:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4836:	fb040513          	addi	a0,s0,-80
    483a:	00001097          	auipc	ra,0x1
    483e:	3c4080e7          	jalr	964(ra) # 5bfe <pipe>
    4842:	e901                	bnez	a0,4852 <sbrkfail+0x30>
    4844:	f8040493          	addi	s1,s0,-128
    4848:	fa840993          	addi	s3,s0,-88
    484c:	8926                	mv	s2,s1
    if(pids[i] != -1)
    484e:	5a7d                	li	s4,-1
    4850:	a085                	j	48b0 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    4852:	85d6                	mv	a1,s5
    4854:	00002517          	auipc	a0,0x2
    4858:	28450513          	addi	a0,a0,644 # 6ad8 <malloc+0xab8>
    485c:	00001097          	auipc	ra,0x1
    4860:	70c080e7          	jalr	1804(ra) # 5f68 <printf>
    exit(1);
    4864:	4505                	li	a0,1
    4866:	00001097          	auipc	ra,0x1
    486a:	388080e7          	jalr	904(ra) # 5bee <exit>
      sbrk(BIG - (uint64)sbrk(0));
    486e:	00001097          	auipc	ra,0x1
    4872:	408080e7          	jalr	1032(ra) # 5c76 <sbrk>
    4876:	064007b7          	lui	a5,0x6400
    487a:	40a7853b          	subw	a0,a5,a0
    487e:	00001097          	auipc	ra,0x1
    4882:	3f8080e7          	jalr	1016(ra) # 5c76 <sbrk>
      write(fds[1], "x", 1);
    4886:	4605                	li	a2,1
    4888:	00002597          	auipc	a1,0x2
    488c:	93058593          	addi	a1,a1,-1744 # 61b8 <malloc+0x198>
    4890:	fb442503          	lw	a0,-76(s0)
    4894:	00001097          	auipc	ra,0x1
    4898:	37a080e7          	jalr	890(ra) # 5c0e <write>
      for(;;) sleep(1000);
    489c:	3e800513          	li	a0,1000
    48a0:	00001097          	auipc	ra,0x1
    48a4:	3de080e7          	jalr	990(ra) # 5c7e <sleep>
    48a8:	bfd5                	j	489c <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48aa:	0911                	addi	s2,s2,4
    48ac:	03390563          	beq	s2,s3,48d6 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    48b0:	00001097          	auipc	ra,0x1
    48b4:	336080e7          	jalr	822(ra) # 5be6 <fork>
    48b8:	00a92023          	sw	a0,0(s2)
    48bc:	d94d                	beqz	a0,486e <sbrkfail+0x4c>
    if(pids[i] != -1)
    48be:	ff4506e3          	beq	a0,s4,48aa <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    48c2:	4605                	li	a2,1
    48c4:	faf40593          	addi	a1,s0,-81
    48c8:	fb042503          	lw	a0,-80(s0)
    48cc:	00001097          	auipc	ra,0x1
    48d0:	33a080e7          	jalr	826(ra) # 5c06 <read>
    48d4:	bfd9                	j	48aa <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48d6:	6505                	lui	a0,0x1
    48d8:	00001097          	auipc	ra,0x1
    48dc:	39e080e7          	jalr	926(ra) # 5c76 <sbrk>
    48e0:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    48e2:	597d                	li	s2,-1
    48e4:	a021                	j	48ec <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48e6:	0491                	addi	s1,s1,4
    48e8:	01348f63          	beq	s1,s3,4906 <sbrkfail+0xe4>
    if(pids[i] == -1)
    48ec:	4088                	lw	a0,0(s1)
    48ee:	ff250ce3          	beq	a0,s2,48e6 <sbrkfail+0xc4>
    kill(pids[i]);
    48f2:	00001097          	auipc	ra,0x1
    48f6:	32c080e7          	jalr	812(ra) # 5c1e <kill>
    wait(0);
    48fa:	4501                	li	a0,0
    48fc:	00001097          	auipc	ra,0x1
    4900:	2fa080e7          	jalr	762(ra) # 5bf6 <wait>
    4904:	b7cd                	j	48e6 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    4906:	57fd                	li	a5,-1
    4908:	04fa0163          	beq	s4,a5,494a <sbrkfail+0x128>
  pid = fork();
    490c:	00001097          	auipc	ra,0x1
    4910:	2da080e7          	jalr	730(ra) # 5be6 <fork>
    4914:	84aa                	mv	s1,a0
  if(pid < 0){
    4916:	04054863          	bltz	a0,4966 <sbrkfail+0x144>
  if(pid == 0){
    491a:	c525                	beqz	a0,4982 <sbrkfail+0x160>
  wait(&xstatus);
    491c:	fbc40513          	addi	a0,s0,-68
    4920:	00001097          	auipc	ra,0x1
    4924:	2d6080e7          	jalr	726(ra) # 5bf6 <wait>
  if(xstatus != -1 && xstatus != 2)
    4928:	fbc42783          	lw	a5,-68(s0)
    492c:	577d                	li	a4,-1
    492e:	00e78563          	beq	a5,a4,4938 <sbrkfail+0x116>
    4932:	4709                	li	a4,2
    4934:	08e79d63          	bne	a5,a4,49ce <sbrkfail+0x1ac>
}
    4938:	70e6                	ld	ra,120(sp)
    493a:	7446                	ld	s0,112(sp)
    493c:	74a6                	ld	s1,104(sp)
    493e:	7906                	ld	s2,96(sp)
    4940:	69e6                	ld	s3,88(sp)
    4942:	6a46                	ld	s4,80(sp)
    4944:	6aa6                	ld	s5,72(sp)
    4946:	6109                	addi	sp,sp,128
    4948:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    494a:	85d6                	mv	a1,s5
    494c:	00003517          	auipc	a0,0x3
    4950:	3e450513          	addi	a0,a0,996 # 7d30 <malloc+0x1d10>
    4954:	00001097          	auipc	ra,0x1
    4958:	614080e7          	jalr	1556(ra) # 5f68 <printf>
    exit(1);
    495c:	4505                	li	a0,1
    495e:	00001097          	auipc	ra,0x1
    4962:	290080e7          	jalr	656(ra) # 5bee <exit>
    printf("%s: fork failed\n", s);
    4966:	85d6                	mv	a1,s5
    4968:	00002517          	auipc	a0,0x2
    496c:	06850513          	addi	a0,a0,104 # 69d0 <malloc+0x9b0>
    4970:	00001097          	auipc	ra,0x1
    4974:	5f8080e7          	jalr	1528(ra) # 5f68 <printf>
    exit(1);
    4978:	4505                	li	a0,1
    497a:	00001097          	auipc	ra,0x1
    497e:	274080e7          	jalr	628(ra) # 5bee <exit>
    a = sbrk(0);
    4982:	4501                	li	a0,0
    4984:	00001097          	auipc	ra,0x1
    4988:	2f2080e7          	jalr	754(ra) # 5c76 <sbrk>
    498c:	892a                	mv	s2,a0
    sbrk(10*BIG);
    498e:	3e800537          	lui	a0,0x3e800
    4992:	00001097          	auipc	ra,0x1
    4996:	2e4080e7          	jalr	740(ra) # 5c76 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    499a:	87ca                	mv	a5,s2
    499c:	3e800737          	lui	a4,0x3e800
    49a0:	993a                	add	s2,s2,a4
    49a2:	6705                	lui	a4,0x1
      n += *(a+i);
    49a4:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63f0388>
    49a8:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    49aa:	97ba                	add	a5,a5,a4
    49ac:	ff279ce3          	bne	a5,s2,49a4 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    49b0:	8626                	mv	a2,s1
    49b2:	85d6                	mv	a1,s5
    49b4:	00003517          	auipc	a0,0x3
    49b8:	39c50513          	addi	a0,a0,924 # 7d50 <malloc+0x1d30>
    49bc:	00001097          	auipc	ra,0x1
    49c0:	5ac080e7          	jalr	1452(ra) # 5f68 <printf>
    exit(1);
    49c4:	4505                	li	a0,1
    49c6:	00001097          	auipc	ra,0x1
    49ca:	228080e7          	jalr	552(ra) # 5bee <exit>
    exit(1);
    49ce:	4505                	li	a0,1
    49d0:	00001097          	auipc	ra,0x1
    49d4:	21e080e7          	jalr	542(ra) # 5bee <exit>

00000000000049d8 <mem>:
{
    49d8:	7139                	addi	sp,sp,-64
    49da:	fc06                	sd	ra,56(sp)
    49dc:	f822                	sd	s0,48(sp)
    49de:	f426                	sd	s1,40(sp)
    49e0:	f04a                	sd	s2,32(sp)
    49e2:	ec4e                	sd	s3,24(sp)
    49e4:	0080                	addi	s0,sp,64
    49e6:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49e8:	00001097          	auipc	ra,0x1
    49ec:	1fe080e7          	jalr	510(ra) # 5be6 <fork>
    m1 = 0;
    49f0:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49f2:	6909                	lui	s2,0x2
    49f4:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0xff>
  if((pid = fork()) == 0){
    49f8:	c115                	beqz	a0,4a1c <mem+0x44>
    wait(&xstatus);
    49fa:	fcc40513          	addi	a0,s0,-52
    49fe:	00001097          	auipc	ra,0x1
    4a02:	1f8080e7          	jalr	504(ra) # 5bf6 <wait>
    if(xstatus == -1){
    4a06:	fcc42503          	lw	a0,-52(s0)
    4a0a:	57fd                	li	a5,-1
    4a0c:	06f50363          	beq	a0,a5,4a72 <mem+0x9a>
    exit(xstatus);
    4a10:	00001097          	auipc	ra,0x1
    4a14:	1de080e7          	jalr	478(ra) # 5bee <exit>
      *(char**)m2 = m1;
    4a18:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a1a:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4a1c:	854a                	mv	a0,s2
    4a1e:	00001097          	auipc	ra,0x1
    4a22:	602080e7          	jalr	1538(ra) # 6020 <malloc>
    4a26:	f96d                	bnez	a0,4a18 <mem+0x40>
    while(m1){
    4a28:	c881                	beqz	s1,4a38 <mem+0x60>
      m2 = *(char**)m1;
    4a2a:	8526                	mv	a0,s1
    4a2c:	6084                	ld	s1,0(s1)
      free(m1);
    4a2e:	00001097          	auipc	ra,0x1
    4a32:	570080e7          	jalr	1392(ra) # 5f9e <free>
    while(m1){
    4a36:	f8f5                	bnez	s1,4a2a <mem+0x52>
    m1 = malloc(1024*20);
    4a38:	6515                	lui	a0,0x5
    4a3a:	00001097          	auipc	ra,0x1
    4a3e:	5e6080e7          	jalr	1510(ra) # 6020 <malloc>
    if(m1 == 0){
    4a42:	c911                	beqz	a0,4a56 <mem+0x7e>
    free(m1);
    4a44:	00001097          	auipc	ra,0x1
    4a48:	55a080e7          	jalr	1370(ra) # 5f9e <free>
    exit(0);
    4a4c:	4501                	li	a0,0
    4a4e:	00001097          	auipc	ra,0x1
    4a52:	1a0080e7          	jalr	416(ra) # 5bee <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a56:	85ce                	mv	a1,s3
    4a58:	00003517          	auipc	a0,0x3
    4a5c:	32850513          	addi	a0,a0,808 # 7d80 <malloc+0x1d60>
    4a60:	00001097          	auipc	ra,0x1
    4a64:	508080e7          	jalr	1288(ra) # 5f68 <printf>
      exit(1);
    4a68:	4505                	li	a0,1
    4a6a:	00001097          	auipc	ra,0x1
    4a6e:	184080e7          	jalr	388(ra) # 5bee <exit>
      exit(0);
    4a72:	4501                	li	a0,0
    4a74:	00001097          	auipc	ra,0x1
    4a78:	17a080e7          	jalr	378(ra) # 5bee <exit>

0000000000004a7c <sharedfd>:
{
    4a7c:	7159                	addi	sp,sp,-112
    4a7e:	f486                	sd	ra,104(sp)
    4a80:	f0a2                	sd	s0,96(sp)
    4a82:	eca6                	sd	s1,88(sp)
    4a84:	e8ca                	sd	s2,80(sp)
    4a86:	e4ce                	sd	s3,72(sp)
    4a88:	e0d2                	sd	s4,64(sp)
    4a8a:	fc56                	sd	s5,56(sp)
    4a8c:	f85a                	sd	s6,48(sp)
    4a8e:	f45e                	sd	s7,40(sp)
    4a90:	1880                	addi	s0,sp,112
    4a92:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a94:	00003517          	auipc	a0,0x3
    4a98:	30c50513          	addi	a0,a0,780 # 7da0 <malloc+0x1d80>
    4a9c:	00001097          	auipc	ra,0x1
    4aa0:	1a2080e7          	jalr	418(ra) # 5c3e <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4aa4:	20200593          	li	a1,514
    4aa8:	00003517          	auipc	a0,0x3
    4aac:	2f850513          	addi	a0,a0,760 # 7da0 <malloc+0x1d80>
    4ab0:	00001097          	auipc	ra,0x1
    4ab4:	17e080e7          	jalr	382(ra) # 5c2e <open>
  if(fd < 0){
    4ab8:	04054a63          	bltz	a0,4b0c <sharedfd+0x90>
    4abc:	892a                	mv	s2,a0
  pid = fork();
    4abe:	00001097          	auipc	ra,0x1
    4ac2:	128080e7          	jalr	296(ra) # 5be6 <fork>
    4ac6:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4ac8:	06300593          	li	a1,99
    4acc:	c119                	beqz	a0,4ad2 <sharedfd+0x56>
    4ace:	07000593          	li	a1,112
    4ad2:	4629                	li	a2,10
    4ad4:	fa040513          	addi	a0,s0,-96
    4ad8:	00001097          	auipc	ra,0x1
    4adc:	f1c080e7          	jalr	-228(ra) # 59f4 <memset>
    4ae0:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4ae4:	4629                	li	a2,10
    4ae6:	fa040593          	addi	a1,s0,-96
    4aea:	854a                	mv	a0,s2
    4aec:	00001097          	auipc	ra,0x1
    4af0:	122080e7          	jalr	290(ra) # 5c0e <write>
    4af4:	47a9                	li	a5,10
    4af6:	02f51963          	bne	a0,a5,4b28 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4afa:	34fd                	addiw	s1,s1,-1
    4afc:	f4e5                	bnez	s1,4ae4 <sharedfd+0x68>
  if(pid == 0) {
    4afe:	04099363          	bnez	s3,4b44 <sharedfd+0xc8>
    exit(0);
    4b02:	4501                	li	a0,0
    4b04:	00001097          	auipc	ra,0x1
    4b08:	0ea080e7          	jalr	234(ra) # 5bee <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4b0c:	85d2                	mv	a1,s4
    4b0e:	00003517          	auipc	a0,0x3
    4b12:	2a250513          	addi	a0,a0,674 # 7db0 <malloc+0x1d90>
    4b16:	00001097          	auipc	ra,0x1
    4b1a:	452080e7          	jalr	1106(ra) # 5f68 <printf>
    exit(1);
    4b1e:	4505                	li	a0,1
    4b20:	00001097          	auipc	ra,0x1
    4b24:	0ce080e7          	jalr	206(ra) # 5bee <exit>
      printf("%s: write sharedfd failed\n", s);
    4b28:	85d2                	mv	a1,s4
    4b2a:	00003517          	auipc	a0,0x3
    4b2e:	2ae50513          	addi	a0,a0,686 # 7dd8 <malloc+0x1db8>
    4b32:	00001097          	auipc	ra,0x1
    4b36:	436080e7          	jalr	1078(ra) # 5f68 <printf>
      exit(1);
    4b3a:	4505                	li	a0,1
    4b3c:	00001097          	auipc	ra,0x1
    4b40:	0b2080e7          	jalr	178(ra) # 5bee <exit>
    wait(&xstatus);
    4b44:	f9c40513          	addi	a0,s0,-100
    4b48:	00001097          	auipc	ra,0x1
    4b4c:	0ae080e7          	jalr	174(ra) # 5bf6 <wait>
    if(xstatus != 0)
    4b50:	f9c42983          	lw	s3,-100(s0)
    4b54:	00098763          	beqz	s3,4b62 <sharedfd+0xe6>
      exit(xstatus);
    4b58:	854e                	mv	a0,s3
    4b5a:	00001097          	auipc	ra,0x1
    4b5e:	094080e7          	jalr	148(ra) # 5bee <exit>
  close(fd);
    4b62:	854a                	mv	a0,s2
    4b64:	00001097          	auipc	ra,0x1
    4b68:	0b2080e7          	jalr	178(ra) # 5c16 <close>
  fd = open("sharedfd", 0);
    4b6c:	4581                	li	a1,0
    4b6e:	00003517          	auipc	a0,0x3
    4b72:	23250513          	addi	a0,a0,562 # 7da0 <malloc+0x1d80>
    4b76:	00001097          	auipc	ra,0x1
    4b7a:	0b8080e7          	jalr	184(ra) # 5c2e <open>
    4b7e:	8baa                	mv	s7,a0
  nc = np = 0;
    4b80:	8ace                	mv	s5,s3
  if(fd < 0){
    4b82:	02054563          	bltz	a0,4bac <sharedfd+0x130>
    4b86:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b8a:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b8e:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b92:	4629                	li	a2,10
    4b94:	fa040593          	addi	a1,s0,-96
    4b98:	855e                	mv	a0,s7
    4b9a:	00001097          	auipc	ra,0x1
    4b9e:	06c080e7          	jalr	108(ra) # 5c06 <read>
    4ba2:	02a05f63          	blez	a0,4be0 <sharedfd+0x164>
    4ba6:	fa040793          	addi	a5,s0,-96
    4baa:	a01d                	j	4bd0 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4bac:	85d2                	mv	a1,s4
    4bae:	00003517          	auipc	a0,0x3
    4bb2:	24a50513          	addi	a0,a0,586 # 7df8 <malloc+0x1dd8>
    4bb6:	00001097          	auipc	ra,0x1
    4bba:	3b2080e7          	jalr	946(ra) # 5f68 <printf>
    exit(1);
    4bbe:	4505                	li	a0,1
    4bc0:	00001097          	auipc	ra,0x1
    4bc4:	02e080e7          	jalr	46(ra) # 5bee <exit>
        nc++;
    4bc8:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bca:	0785                	addi	a5,a5,1
    4bcc:	fd2783e3          	beq	a5,s2,4b92 <sharedfd+0x116>
      if(buf[i] == 'c')
    4bd0:	0007c703          	lbu	a4,0(a5)
    4bd4:	fe970ae3          	beq	a4,s1,4bc8 <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bd8:	ff6719e3          	bne	a4,s6,4bca <sharedfd+0x14e>
        np++;
    4bdc:	2a85                	addiw	s5,s5,1
    4bde:	b7f5                	j	4bca <sharedfd+0x14e>
  close(fd);
    4be0:	855e                	mv	a0,s7
    4be2:	00001097          	auipc	ra,0x1
    4be6:	034080e7          	jalr	52(ra) # 5c16 <close>
  unlink("sharedfd");
    4bea:	00003517          	auipc	a0,0x3
    4bee:	1b650513          	addi	a0,a0,438 # 7da0 <malloc+0x1d80>
    4bf2:	00001097          	auipc	ra,0x1
    4bf6:	04c080e7          	jalr	76(ra) # 5c3e <unlink>
  if(nc == N*SZ && np == N*SZ){
    4bfa:	6789                	lui	a5,0x2
    4bfc:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xfe>
    4c00:	00f99763          	bne	s3,a5,4c0e <sharedfd+0x192>
    4c04:	6789                	lui	a5,0x2
    4c06:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xfe>
    4c0a:	02fa8063          	beq	s5,a5,4c2a <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4c0e:	85d2                	mv	a1,s4
    4c10:	00003517          	auipc	a0,0x3
    4c14:	21050513          	addi	a0,a0,528 # 7e20 <malloc+0x1e00>
    4c18:	00001097          	auipc	ra,0x1
    4c1c:	350080e7          	jalr	848(ra) # 5f68 <printf>
    exit(1);
    4c20:	4505                	li	a0,1
    4c22:	00001097          	auipc	ra,0x1
    4c26:	fcc080e7          	jalr	-52(ra) # 5bee <exit>
    exit(0);
    4c2a:	4501                	li	a0,0
    4c2c:	00001097          	auipc	ra,0x1
    4c30:	fc2080e7          	jalr	-62(ra) # 5bee <exit>

0000000000004c34 <fourfiles>:
{
    4c34:	7171                	addi	sp,sp,-176
    4c36:	f506                	sd	ra,168(sp)
    4c38:	f122                	sd	s0,160(sp)
    4c3a:	ed26                	sd	s1,152(sp)
    4c3c:	e94a                	sd	s2,144(sp)
    4c3e:	e54e                	sd	s3,136(sp)
    4c40:	e152                	sd	s4,128(sp)
    4c42:	fcd6                	sd	s5,120(sp)
    4c44:	f8da                	sd	s6,112(sp)
    4c46:	f4de                	sd	s7,104(sp)
    4c48:	f0e2                	sd	s8,96(sp)
    4c4a:	ece6                	sd	s9,88(sp)
    4c4c:	e8ea                	sd	s10,80(sp)
    4c4e:	e4ee                	sd	s11,72(sp)
    4c50:	1900                	addi	s0,sp,176
    4c52:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c56:	00003797          	auipc	a5,0x3
    4c5a:	1e278793          	addi	a5,a5,482 # 7e38 <malloc+0x1e18>
    4c5e:	f6f43823          	sd	a5,-144(s0)
    4c62:	00003797          	auipc	a5,0x3
    4c66:	1de78793          	addi	a5,a5,478 # 7e40 <malloc+0x1e20>
    4c6a:	f6f43c23          	sd	a5,-136(s0)
    4c6e:	00003797          	auipc	a5,0x3
    4c72:	1da78793          	addi	a5,a5,474 # 7e48 <malloc+0x1e28>
    4c76:	f8f43023          	sd	a5,-128(s0)
    4c7a:	00003797          	auipc	a5,0x3
    4c7e:	1d678793          	addi	a5,a5,470 # 7e50 <malloc+0x1e30>
    4c82:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c86:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c8a:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    4c8c:	4481                	li	s1,0
    4c8e:	4a11                	li	s4,4
    fname = names[pi];
    4c90:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c94:	854e                	mv	a0,s3
    4c96:	00001097          	auipc	ra,0x1
    4c9a:	fa8080e7          	jalr	-88(ra) # 5c3e <unlink>
    pid = fork();
    4c9e:	00001097          	auipc	ra,0x1
    4ca2:	f48080e7          	jalr	-184(ra) # 5be6 <fork>
    if(pid < 0){
    4ca6:	04054463          	bltz	a0,4cee <fourfiles+0xba>
    if(pid == 0){
    4caa:	c12d                	beqz	a0,4d0c <fourfiles+0xd8>
  for(pi = 0; pi < NCHILD; pi++){
    4cac:	2485                	addiw	s1,s1,1
    4cae:	0921                	addi	s2,s2,8
    4cb0:	ff4490e3          	bne	s1,s4,4c90 <fourfiles+0x5c>
    4cb4:	4491                	li	s1,4
    wait(&xstatus);
    4cb6:	f6c40513          	addi	a0,s0,-148
    4cba:	00001097          	auipc	ra,0x1
    4cbe:	f3c080e7          	jalr	-196(ra) # 5bf6 <wait>
    if(xstatus != 0)
    4cc2:	f6c42b03          	lw	s6,-148(s0)
    4cc6:	0c0b1e63          	bnez	s6,4da2 <fourfiles+0x16e>
  for(pi = 0; pi < NCHILD; pi++){
    4cca:	34fd                	addiw	s1,s1,-1
    4ccc:	f4ed                	bnez	s1,4cb6 <fourfiles+0x82>
    4cce:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cd2:	00008a17          	auipc	s4,0x8
    4cd6:	fa6a0a13          	addi	s4,s4,-90 # cc78 <buf>
    4cda:	00008a97          	auipc	s5,0x8
    4cde:	f9fa8a93          	addi	s5,s5,-97 # cc79 <buf+0x1>
    if(total != N*SZ){
    4ce2:	6d85                	lui	s11,0x1
    4ce4:	770d8d93          	addi	s11,s11,1904 # 1770 <exectest+0x28>
  for(i = 0; i < NCHILD; i++){
    4ce8:	03400d13          	li	s10,52
    4cec:	aa1d                	j	4e22 <fourfiles+0x1ee>
      printf("fork failed\n", s);
    4cee:	f5843583          	ld	a1,-168(s0)
    4cf2:	00002517          	auipc	a0,0x2
    4cf6:	0e650513          	addi	a0,a0,230 # 6dd8 <malloc+0xdb8>
    4cfa:	00001097          	auipc	ra,0x1
    4cfe:	26e080e7          	jalr	622(ra) # 5f68 <printf>
      exit(1);
    4d02:	4505                	li	a0,1
    4d04:	00001097          	auipc	ra,0x1
    4d08:	eea080e7          	jalr	-278(ra) # 5bee <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4d0c:	20200593          	li	a1,514
    4d10:	854e                	mv	a0,s3
    4d12:	00001097          	auipc	ra,0x1
    4d16:	f1c080e7          	jalr	-228(ra) # 5c2e <open>
    4d1a:	892a                	mv	s2,a0
      if(fd < 0){
    4d1c:	04054763          	bltz	a0,4d6a <fourfiles+0x136>
      memset(buf, '0'+pi, SZ);
    4d20:	1f400613          	li	a2,500
    4d24:	0304859b          	addiw	a1,s1,48
    4d28:	00008517          	auipc	a0,0x8
    4d2c:	f5050513          	addi	a0,a0,-176 # cc78 <buf>
    4d30:	00001097          	auipc	ra,0x1
    4d34:	cc4080e7          	jalr	-828(ra) # 59f4 <memset>
    4d38:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d3a:	00008997          	auipc	s3,0x8
    4d3e:	f3e98993          	addi	s3,s3,-194 # cc78 <buf>
    4d42:	1f400613          	li	a2,500
    4d46:	85ce                	mv	a1,s3
    4d48:	854a                	mv	a0,s2
    4d4a:	00001097          	auipc	ra,0x1
    4d4e:	ec4080e7          	jalr	-316(ra) # 5c0e <write>
    4d52:	85aa                	mv	a1,a0
    4d54:	1f400793          	li	a5,500
    4d58:	02f51863          	bne	a0,a5,4d88 <fourfiles+0x154>
      for(i = 0; i < N; i++){
    4d5c:	34fd                	addiw	s1,s1,-1
    4d5e:	f0f5                	bnez	s1,4d42 <fourfiles+0x10e>
      exit(0);
    4d60:	4501                	li	a0,0
    4d62:	00001097          	auipc	ra,0x1
    4d66:	e8c080e7          	jalr	-372(ra) # 5bee <exit>
        printf("create failed\n", s);
    4d6a:	f5843583          	ld	a1,-168(s0)
    4d6e:	00003517          	auipc	a0,0x3
    4d72:	0ea50513          	addi	a0,a0,234 # 7e58 <malloc+0x1e38>
    4d76:	00001097          	auipc	ra,0x1
    4d7a:	1f2080e7          	jalr	498(ra) # 5f68 <printf>
        exit(1);
    4d7e:	4505                	li	a0,1
    4d80:	00001097          	auipc	ra,0x1
    4d84:	e6e080e7          	jalr	-402(ra) # 5bee <exit>
          printf("write failed %d\n", n);
    4d88:	00003517          	auipc	a0,0x3
    4d8c:	0e050513          	addi	a0,a0,224 # 7e68 <malloc+0x1e48>
    4d90:	00001097          	auipc	ra,0x1
    4d94:	1d8080e7          	jalr	472(ra) # 5f68 <printf>
          exit(1);
    4d98:	4505                	li	a0,1
    4d9a:	00001097          	auipc	ra,0x1
    4d9e:	e54080e7          	jalr	-428(ra) # 5bee <exit>
      exit(xstatus);
    4da2:	855a                	mv	a0,s6
    4da4:	00001097          	auipc	ra,0x1
    4da8:	e4a080e7          	jalr	-438(ra) # 5bee <exit>
          printf("wrong char\n", s);
    4dac:	f5843583          	ld	a1,-168(s0)
    4db0:	00003517          	auipc	a0,0x3
    4db4:	0d050513          	addi	a0,a0,208 # 7e80 <malloc+0x1e60>
    4db8:	00001097          	auipc	ra,0x1
    4dbc:	1b0080e7          	jalr	432(ra) # 5f68 <printf>
          exit(1);
    4dc0:	4505                	li	a0,1
    4dc2:	00001097          	auipc	ra,0x1
    4dc6:	e2c080e7          	jalr	-468(ra) # 5bee <exit>
      total += n;
    4dca:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4dce:	660d                	lui	a2,0x3
    4dd0:	85d2                	mv	a1,s4
    4dd2:	854e                	mv	a0,s3
    4dd4:	00001097          	auipc	ra,0x1
    4dd8:	e32080e7          	jalr	-462(ra) # 5c06 <read>
    4ddc:	02a05363          	blez	a0,4e02 <fourfiles+0x1ce>
    4de0:	00008797          	auipc	a5,0x8
    4de4:	e9878793          	addi	a5,a5,-360 # cc78 <buf>
    4de8:	fff5069b          	addiw	a3,a0,-1
    4dec:	1682                	slli	a3,a3,0x20
    4dee:	9281                	srli	a3,a3,0x20
    4df0:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    4df2:	0007c703          	lbu	a4,0(a5)
    4df6:	fa971be3          	bne	a4,s1,4dac <fourfiles+0x178>
      for(j = 0; j < n; j++){
    4dfa:	0785                	addi	a5,a5,1
    4dfc:	fed79be3          	bne	a5,a3,4df2 <fourfiles+0x1be>
    4e00:	b7e9                	j	4dca <fourfiles+0x196>
    close(fd);
    4e02:	854e                	mv	a0,s3
    4e04:	00001097          	auipc	ra,0x1
    4e08:	e12080e7          	jalr	-494(ra) # 5c16 <close>
    if(total != N*SZ){
    4e0c:	03b91863          	bne	s2,s11,4e3c <fourfiles+0x208>
    unlink(fname);
    4e10:	8566                	mv	a0,s9
    4e12:	00001097          	auipc	ra,0x1
    4e16:	e2c080e7          	jalr	-468(ra) # 5c3e <unlink>
  for(i = 0; i < NCHILD; i++){
    4e1a:	0c21                	addi	s8,s8,8
    4e1c:	2b85                	addiw	s7,s7,1
    4e1e:	03ab8d63          	beq	s7,s10,4e58 <fourfiles+0x224>
    fname = names[i];
    4e22:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    4e26:	4581                	li	a1,0
    4e28:	8566                	mv	a0,s9
    4e2a:	00001097          	auipc	ra,0x1
    4e2e:	e04080e7          	jalr	-508(ra) # 5c2e <open>
    4e32:	89aa                	mv	s3,a0
    total = 0;
    4e34:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    4e36:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e3a:	bf51                	j	4dce <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    4e3c:	85ca                	mv	a1,s2
    4e3e:	00003517          	auipc	a0,0x3
    4e42:	05250513          	addi	a0,a0,82 # 7e90 <malloc+0x1e70>
    4e46:	00001097          	auipc	ra,0x1
    4e4a:	122080e7          	jalr	290(ra) # 5f68 <printf>
      exit(1);
    4e4e:	4505                	li	a0,1
    4e50:	00001097          	auipc	ra,0x1
    4e54:	d9e080e7          	jalr	-610(ra) # 5bee <exit>
}
    4e58:	70aa                	ld	ra,168(sp)
    4e5a:	740a                	ld	s0,160(sp)
    4e5c:	64ea                	ld	s1,152(sp)
    4e5e:	694a                	ld	s2,144(sp)
    4e60:	69aa                	ld	s3,136(sp)
    4e62:	6a0a                	ld	s4,128(sp)
    4e64:	7ae6                	ld	s5,120(sp)
    4e66:	7b46                	ld	s6,112(sp)
    4e68:	7ba6                	ld	s7,104(sp)
    4e6a:	7c06                	ld	s8,96(sp)
    4e6c:	6ce6                	ld	s9,88(sp)
    4e6e:	6d46                	ld	s10,80(sp)
    4e70:	6da6                	ld	s11,72(sp)
    4e72:	614d                	addi	sp,sp,176
    4e74:	8082                	ret

0000000000004e76 <concreate>:
{
    4e76:	7135                	addi	sp,sp,-160
    4e78:	ed06                	sd	ra,152(sp)
    4e7a:	e922                	sd	s0,144(sp)
    4e7c:	e526                	sd	s1,136(sp)
    4e7e:	e14a                	sd	s2,128(sp)
    4e80:	fcce                	sd	s3,120(sp)
    4e82:	f8d2                	sd	s4,112(sp)
    4e84:	f4d6                	sd	s5,104(sp)
    4e86:	f0da                	sd	s6,96(sp)
    4e88:	ecde                	sd	s7,88(sp)
    4e8a:	1100                	addi	s0,sp,160
    4e8c:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e8e:	04300793          	li	a5,67
    4e92:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e96:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e9a:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e9c:	4b0d                	li	s6,3
    4e9e:	4a85                	li	s5,1
      link("C0", file);
    4ea0:	00003b97          	auipc	s7,0x3
    4ea4:	008b8b93          	addi	s7,s7,8 # 7ea8 <malloc+0x1e88>
  for(i = 0; i < N; i++){
    4ea8:	02800a13          	li	s4,40
    4eac:	acc9                	j	517e <concreate+0x308>
      link("C0", file);
    4eae:	fa840593          	addi	a1,s0,-88
    4eb2:	855e                	mv	a0,s7
    4eb4:	00001097          	auipc	ra,0x1
    4eb8:	d9a080e7          	jalr	-614(ra) # 5c4e <link>
    if(pid == 0) {
    4ebc:	a465                	j	5164 <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4ebe:	4795                	li	a5,5
    4ec0:	02f9693b          	remw	s2,s2,a5
    4ec4:	4785                	li	a5,1
    4ec6:	02f90b63          	beq	s2,a5,4efc <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4eca:	20200593          	li	a1,514
    4ece:	fa840513          	addi	a0,s0,-88
    4ed2:	00001097          	auipc	ra,0x1
    4ed6:	d5c080e7          	jalr	-676(ra) # 5c2e <open>
      if(fd < 0){
    4eda:	26055c63          	bgez	a0,5152 <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4ede:	fa840593          	addi	a1,s0,-88
    4ee2:	00003517          	auipc	a0,0x3
    4ee6:	fce50513          	addi	a0,a0,-50 # 7eb0 <malloc+0x1e90>
    4eea:	00001097          	auipc	ra,0x1
    4eee:	07e080e7          	jalr	126(ra) # 5f68 <printf>
        exit(1);
    4ef2:	4505                	li	a0,1
    4ef4:	00001097          	auipc	ra,0x1
    4ef8:	cfa080e7          	jalr	-774(ra) # 5bee <exit>
      link("C0", file);
    4efc:	fa840593          	addi	a1,s0,-88
    4f00:	00003517          	auipc	a0,0x3
    4f04:	fa850513          	addi	a0,a0,-88 # 7ea8 <malloc+0x1e88>
    4f08:	00001097          	auipc	ra,0x1
    4f0c:	d46080e7          	jalr	-698(ra) # 5c4e <link>
      exit(0);
    4f10:	4501                	li	a0,0
    4f12:	00001097          	auipc	ra,0x1
    4f16:	cdc080e7          	jalr	-804(ra) # 5bee <exit>
        exit(1);
    4f1a:	4505                	li	a0,1
    4f1c:	00001097          	auipc	ra,0x1
    4f20:	cd2080e7          	jalr	-814(ra) # 5bee <exit>
  memset(fa, 0, sizeof(fa));
    4f24:	02800613          	li	a2,40
    4f28:	4581                	li	a1,0
    4f2a:	f8040513          	addi	a0,s0,-128
    4f2e:	00001097          	auipc	ra,0x1
    4f32:	ac6080e7          	jalr	-1338(ra) # 59f4 <memset>
  fd = open(".", 0);
    4f36:	4581                	li	a1,0
    4f38:	00002517          	auipc	a0,0x2
    4f3c:	8f850513          	addi	a0,a0,-1800 # 6830 <malloc+0x810>
    4f40:	00001097          	auipc	ra,0x1
    4f44:	cee080e7          	jalr	-786(ra) # 5c2e <open>
    4f48:	892a                	mv	s2,a0
  n = 0;
    4f4a:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f4c:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f50:	02700b13          	li	s6,39
      fa[i] = 1;
    4f54:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f56:	4641                	li	a2,16
    4f58:	f7040593          	addi	a1,s0,-144
    4f5c:	854a                	mv	a0,s2
    4f5e:	00001097          	auipc	ra,0x1
    4f62:	ca8080e7          	jalr	-856(ra) # 5c06 <read>
    4f66:	08a05263          	blez	a0,4fea <concreate+0x174>
    if(de.inum == 0)
    4f6a:	f7045783          	lhu	a5,-144(s0)
    4f6e:	d7e5                	beqz	a5,4f56 <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f70:	f7244783          	lbu	a5,-142(s0)
    4f74:	ff4791e3          	bne	a5,s4,4f56 <concreate+0xe0>
    4f78:	f7444783          	lbu	a5,-140(s0)
    4f7c:	ffe9                	bnez	a5,4f56 <concreate+0xe0>
      i = de.name[1] - '0';
    4f7e:	f7344783          	lbu	a5,-141(s0)
    4f82:	fd07879b          	addiw	a5,a5,-48
    4f86:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4f8a:	02eb6063          	bltu	s6,a4,4faa <concreate+0x134>
      if(fa[i]){
    4f8e:	fb070793          	addi	a5,a4,-80 # fb0 <linktest+0xb4>
    4f92:	97a2                	add	a5,a5,s0
    4f94:	fd07c783          	lbu	a5,-48(a5)
    4f98:	eb8d                	bnez	a5,4fca <concreate+0x154>
      fa[i] = 1;
    4f9a:	fb070793          	addi	a5,a4,-80
    4f9e:	00878733          	add	a4,a5,s0
    4fa2:	fd770823          	sb	s7,-48(a4)
      n++;
    4fa6:	2a85                	addiw	s5,s5,1
    4fa8:	b77d                	j	4f56 <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4faa:	f7240613          	addi	a2,s0,-142
    4fae:	85ce                	mv	a1,s3
    4fb0:	00003517          	auipc	a0,0x3
    4fb4:	f2050513          	addi	a0,a0,-224 # 7ed0 <malloc+0x1eb0>
    4fb8:	00001097          	auipc	ra,0x1
    4fbc:	fb0080e7          	jalr	-80(ra) # 5f68 <printf>
        exit(1);
    4fc0:	4505                	li	a0,1
    4fc2:	00001097          	auipc	ra,0x1
    4fc6:	c2c080e7          	jalr	-980(ra) # 5bee <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fca:	f7240613          	addi	a2,s0,-142
    4fce:	85ce                	mv	a1,s3
    4fd0:	00003517          	auipc	a0,0x3
    4fd4:	f2050513          	addi	a0,a0,-224 # 7ef0 <malloc+0x1ed0>
    4fd8:	00001097          	auipc	ra,0x1
    4fdc:	f90080e7          	jalr	-112(ra) # 5f68 <printf>
        exit(1);
    4fe0:	4505                	li	a0,1
    4fe2:	00001097          	auipc	ra,0x1
    4fe6:	c0c080e7          	jalr	-1012(ra) # 5bee <exit>
  close(fd);
    4fea:	854a                	mv	a0,s2
    4fec:	00001097          	auipc	ra,0x1
    4ff0:	c2a080e7          	jalr	-982(ra) # 5c16 <close>
  if(n != N){
    4ff4:	02800793          	li	a5,40
    4ff8:	00fa9763          	bne	s5,a5,5006 <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4ffc:	4a8d                	li	s5,3
    4ffe:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    5000:	02800a13          	li	s4,40
    5004:	a8c9                	j	50d6 <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    5006:	85ce                	mv	a1,s3
    5008:	00003517          	auipc	a0,0x3
    500c:	f1050513          	addi	a0,a0,-240 # 7f18 <malloc+0x1ef8>
    5010:	00001097          	auipc	ra,0x1
    5014:	f58080e7          	jalr	-168(ra) # 5f68 <printf>
    exit(1);
    5018:	4505                	li	a0,1
    501a:	00001097          	auipc	ra,0x1
    501e:	bd4080e7          	jalr	-1068(ra) # 5bee <exit>
      printf("%s: fork failed\n", s);
    5022:	85ce                	mv	a1,s3
    5024:	00002517          	auipc	a0,0x2
    5028:	9ac50513          	addi	a0,a0,-1620 # 69d0 <malloc+0x9b0>
    502c:	00001097          	auipc	ra,0x1
    5030:	f3c080e7          	jalr	-196(ra) # 5f68 <printf>
      exit(1);
    5034:	4505                	li	a0,1
    5036:	00001097          	auipc	ra,0x1
    503a:	bb8080e7          	jalr	-1096(ra) # 5bee <exit>
      close(open(file, 0));
    503e:	4581                	li	a1,0
    5040:	fa840513          	addi	a0,s0,-88
    5044:	00001097          	auipc	ra,0x1
    5048:	bea080e7          	jalr	-1046(ra) # 5c2e <open>
    504c:	00001097          	auipc	ra,0x1
    5050:	bca080e7          	jalr	-1078(ra) # 5c16 <close>
      close(open(file, 0));
    5054:	4581                	li	a1,0
    5056:	fa840513          	addi	a0,s0,-88
    505a:	00001097          	auipc	ra,0x1
    505e:	bd4080e7          	jalr	-1068(ra) # 5c2e <open>
    5062:	00001097          	auipc	ra,0x1
    5066:	bb4080e7          	jalr	-1100(ra) # 5c16 <close>
      close(open(file, 0));
    506a:	4581                	li	a1,0
    506c:	fa840513          	addi	a0,s0,-88
    5070:	00001097          	auipc	ra,0x1
    5074:	bbe080e7          	jalr	-1090(ra) # 5c2e <open>
    5078:	00001097          	auipc	ra,0x1
    507c:	b9e080e7          	jalr	-1122(ra) # 5c16 <close>
      close(open(file, 0));
    5080:	4581                	li	a1,0
    5082:	fa840513          	addi	a0,s0,-88
    5086:	00001097          	auipc	ra,0x1
    508a:	ba8080e7          	jalr	-1112(ra) # 5c2e <open>
    508e:	00001097          	auipc	ra,0x1
    5092:	b88080e7          	jalr	-1144(ra) # 5c16 <close>
      close(open(file, 0));
    5096:	4581                	li	a1,0
    5098:	fa840513          	addi	a0,s0,-88
    509c:	00001097          	auipc	ra,0x1
    50a0:	b92080e7          	jalr	-1134(ra) # 5c2e <open>
    50a4:	00001097          	auipc	ra,0x1
    50a8:	b72080e7          	jalr	-1166(ra) # 5c16 <close>
      close(open(file, 0));
    50ac:	4581                	li	a1,0
    50ae:	fa840513          	addi	a0,s0,-88
    50b2:	00001097          	auipc	ra,0x1
    50b6:	b7c080e7          	jalr	-1156(ra) # 5c2e <open>
    50ba:	00001097          	auipc	ra,0x1
    50be:	b5c080e7          	jalr	-1188(ra) # 5c16 <close>
    if(pid == 0)
    50c2:	08090363          	beqz	s2,5148 <concreate+0x2d2>
      wait(0);
    50c6:	4501                	li	a0,0
    50c8:	00001097          	auipc	ra,0x1
    50cc:	b2e080e7          	jalr	-1234(ra) # 5bf6 <wait>
  for(i = 0; i < N; i++){
    50d0:	2485                	addiw	s1,s1,1
    50d2:	0f448563          	beq	s1,s4,51bc <concreate+0x346>
    file[1] = '0' + i;
    50d6:	0304879b          	addiw	a5,s1,48
    50da:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50de:	00001097          	auipc	ra,0x1
    50e2:	b08080e7          	jalr	-1272(ra) # 5be6 <fork>
    50e6:	892a                	mv	s2,a0
    if(pid < 0){
    50e8:	f2054de3          	bltz	a0,5022 <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    50ec:	0354e73b          	remw	a4,s1,s5
    50f0:	00a767b3          	or	a5,a4,a0
    50f4:	2781                	sext.w	a5,a5
    50f6:	d7a1                	beqz	a5,503e <concreate+0x1c8>
    50f8:	01671363          	bne	a4,s6,50fe <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    50fc:	f129                	bnez	a0,503e <concreate+0x1c8>
      unlink(file);
    50fe:	fa840513          	addi	a0,s0,-88
    5102:	00001097          	auipc	ra,0x1
    5106:	b3c080e7          	jalr	-1220(ra) # 5c3e <unlink>
      unlink(file);
    510a:	fa840513          	addi	a0,s0,-88
    510e:	00001097          	auipc	ra,0x1
    5112:	b30080e7          	jalr	-1232(ra) # 5c3e <unlink>
      unlink(file);
    5116:	fa840513          	addi	a0,s0,-88
    511a:	00001097          	auipc	ra,0x1
    511e:	b24080e7          	jalr	-1244(ra) # 5c3e <unlink>
      unlink(file);
    5122:	fa840513          	addi	a0,s0,-88
    5126:	00001097          	auipc	ra,0x1
    512a:	b18080e7          	jalr	-1256(ra) # 5c3e <unlink>
      unlink(file);
    512e:	fa840513          	addi	a0,s0,-88
    5132:	00001097          	auipc	ra,0x1
    5136:	b0c080e7          	jalr	-1268(ra) # 5c3e <unlink>
      unlink(file);
    513a:	fa840513          	addi	a0,s0,-88
    513e:	00001097          	auipc	ra,0x1
    5142:	b00080e7          	jalr	-1280(ra) # 5c3e <unlink>
    5146:	bfb5                	j	50c2 <concreate+0x24c>
      exit(0);
    5148:	4501                	li	a0,0
    514a:	00001097          	auipc	ra,0x1
    514e:	aa4080e7          	jalr	-1372(ra) # 5bee <exit>
      close(fd);
    5152:	00001097          	auipc	ra,0x1
    5156:	ac4080e7          	jalr	-1340(ra) # 5c16 <close>
    if(pid == 0) {
    515a:	bb5d                	j	4f10 <concreate+0x9a>
      close(fd);
    515c:	00001097          	auipc	ra,0x1
    5160:	aba080e7          	jalr	-1350(ra) # 5c16 <close>
      wait(&xstatus);
    5164:	f6c40513          	addi	a0,s0,-148
    5168:	00001097          	auipc	ra,0x1
    516c:	a8e080e7          	jalr	-1394(ra) # 5bf6 <wait>
      if(xstatus != 0)
    5170:	f6c42483          	lw	s1,-148(s0)
    5174:	da0493e3          	bnez	s1,4f1a <concreate+0xa4>
  for(i = 0; i < N; i++){
    5178:	2905                	addiw	s2,s2,1
    517a:	db4905e3          	beq	s2,s4,4f24 <concreate+0xae>
    file[1] = '0' + i;
    517e:	0309079b          	addiw	a5,s2,48
    5182:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    5186:	fa840513          	addi	a0,s0,-88
    518a:	00001097          	auipc	ra,0x1
    518e:	ab4080e7          	jalr	-1356(ra) # 5c3e <unlink>
    pid = fork();
    5192:	00001097          	auipc	ra,0x1
    5196:	a54080e7          	jalr	-1452(ra) # 5be6 <fork>
    if(pid && (i % 3) == 1){
    519a:	d20502e3          	beqz	a0,4ebe <concreate+0x48>
    519e:	036967bb          	remw	a5,s2,s6
    51a2:	d15786e3          	beq	a5,s5,4eae <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    51a6:	20200593          	li	a1,514
    51aa:	fa840513          	addi	a0,s0,-88
    51ae:	00001097          	auipc	ra,0x1
    51b2:	a80080e7          	jalr	-1408(ra) # 5c2e <open>
      if(fd < 0){
    51b6:	fa0553e3          	bgez	a0,515c <concreate+0x2e6>
    51ba:	b315                	j	4ede <concreate+0x68>
}
    51bc:	60ea                	ld	ra,152(sp)
    51be:	644a                	ld	s0,144(sp)
    51c0:	64aa                	ld	s1,136(sp)
    51c2:	690a                	ld	s2,128(sp)
    51c4:	79e6                	ld	s3,120(sp)
    51c6:	7a46                	ld	s4,112(sp)
    51c8:	7aa6                	ld	s5,104(sp)
    51ca:	7b06                	ld	s6,96(sp)
    51cc:	6be6                	ld	s7,88(sp)
    51ce:	610d                	addi	sp,sp,160
    51d0:	8082                	ret

00000000000051d2 <bigfile>:
{
    51d2:	7139                	addi	sp,sp,-64
    51d4:	fc06                	sd	ra,56(sp)
    51d6:	f822                	sd	s0,48(sp)
    51d8:	f426                	sd	s1,40(sp)
    51da:	f04a                	sd	s2,32(sp)
    51dc:	ec4e                	sd	s3,24(sp)
    51de:	e852                	sd	s4,16(sp)
    51e0:	e456                	sd	s5,8(sp)
    51e2:	0080                	addi	s0,sp,64
    51e4:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51e6:	00003517          	auipc	a0,0x3
    51ea:	d6a50513          	addi	a0,a0,-662 # 7f50 <malloc+0x1f30>
    51ee:	00001097          	auipc	ra,0x1
    51f2:	a50080e7          	jalr	-1456(ra) # 5c3e <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51f6:	20200593          	li	a1,514
    51fa:	00003517          	auipc	a0,0x3
    51fe:	d5650513          	addi	a0,a0,-682 # 7f50 <malloc+0x1f30>
    5202:	00001097          	auipc	ra,0x1
    5206:	a2c080e7          	jalr	-1492(ra) # 5c2e <open>
    520a:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    520c:	4481                	li	s1,0
    memset(buf, i, SZ);
    520e:	00008917          	auipc	s2,0x8
    5212:	a6a90913          	addi	s2,s2,-1430 # cc78 <buf>
  for(i = 0; i < N; i++){
    5216:	4a51                	li	s4,20
  if(fd < 0){
    5218:	0a054063          	bltz	a0,52b8 <bigfile+0xe6>
    memset(buf, i, SZ);
    521c:	25800613          	li	a2,600
    5220:	85a6                	mv	a1,s1
    5222:	854a                	mv	a0,s2
    5224:	00000097          	auipc	ra,0x0
    5228:	7d0080e7          	jalr	2000(ra) # 59f4 <memset>
    if(write(fd, buf, SZ) != SZ){
    522c:	25800613          	li	a2,600
    5230:	85ca                	mv	a1,s2
    5232:	854e                	mv	a0,s3
    5234:	00001097          	auipc	ra,0x1
    5238:	9da080e7          	jalr	-1574(ra) # 5c0e <write>
    523c:	25800793          	li	a5,600
    5240:	08f51a63          	bne	a0,a5,52d4 <bigfile+0x102>
  for(i = 0; i < N; i++){
    5244:	2485                	addiw	s1,s1,1
    5246:	fd449be3          	bne	s1,s4,521c <bigfile+0x4a>
  close(fd);
    524a:	854e                	mv	a0,s3
    524c:	00001097          	auipc	ra,0x1
    5250:	9ca080e7          	jalr	-1590(ra) # 5c16 <close>
  fd = open("bigfile.dat", 0);
    5254:	4581                	li	a1,0
    5256:	00003517          	auipc	a0,0x3
    525a:	cfa50513          	addi	a0,a0,-774 # 7f50 <malloc+0x1f30>
    525e:	00001097          	auipc	ra,0x1
    5262:	9d0080e7          	jalr	-1584(ra) # 5c2e <open>
    5266:	8a2a                	mv	s4,a0
  total = 0;
    5268:	4981                	li	s3,0
  for(i = 0; ; i++){
    526a:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    526c:	00008917          	auipc	s2,0x8
    5270:	a0c90913          	addi	s2,s2,-1524 # cc78 <buf>
  if(fd < 0){
    5274:	06054e63          	bltz	a0,52f0 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    5278:	12c00613          	li	a2,300
    527c:	85ca                	mv	a1,s2
    527e:	8552                	mv	a0,s4
    5280:	00001097          	auipc	ra,0x1
    5284:	986080e7          	jalr	-1658(ra) # 5c06 <read>
    if(cc < 0){
    5288:	08054263          	bltz	a0,530c <bigfile+0x13a>
    if(cc == 0)
    528c:	c971                	beqz	a0,5360 <bigfile+0x18e>
    if(cc != SZ/2){
    528e:	12c00793          	li	a5,300
    5292:	08f51b63          	bne	a0,a5,5328 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    5296:	01f4d79b          	srliw	a5,s1,0x1f
    529a:	9fa5                	addw	a5,a5,s1
    529c:	4017d79b          	sraiw	a5,a5,0x1
    52a0:	00094703          	lbu	a4,0(s2)
    52a4:	0af71063          	bne	a4,a5,5344 <bigfile+0x172>
    52a8:	12b94703          	lbu	a4,299(s2)
    52ac:	08f71c63          	bne	a4,a5,5344 <bigfile+0x172>
    total += cc;
    52b0:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    52b4:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    52b6:	b7c9                	j	5278 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    52b8:	85d6                	mv	a1,s5
    52ba:	00003517          	auipc	a0,0x3
    52be:	ca650513          	addi	a0,a0,-858 # 7f60 <malloc+0x1f40>
    52c2:	00001097          	auipc	ra,0x1
    52c6:	ca6080e7          	jalr	-858(ra) # 5f68 <printf>
    exit(1);
    52ca:	4505                	li	a0,1
    52cc:	00001097          	auipc	ra,0x1
    52d0:	922080e7          	jalr	-1758(ra) # 5bee <exit>
      printf("%s: write bigfile failed\n", s);
    52d4:	85d6                	mv	a1,s5
    52d6:	00003517          	auipc	a0,0x3
    52da:	caa50513          	addi	a0,a0,-854 # 7f80 <malloc+0x1f60>
    52de:	00001097          	auipc	ra,0x1
    52e2:	c8a080e7          	jalr	-886(ra) # 5f68 <printf>
      exit(1);
    52e6:	4505                	li	a0,1
    52e8:	00001097          	auipc	ra,0x1
    52ec:	906080e7          	jalr	-1786(ra) # 5bee <exit>
    printf("%s: cannot open bigfile\n", s);
    52f0:	85d6                	mv	a1,s5
    52f2:	00003517          	auipc	a0,0x3
    52f6:	cae50513          	addi	a0,a0,-850 # 7fa0 <malloc+0x1f80>
    52fa:	00001097          	auipc	ra,0x1
    52fe:	c6e080e7          	jalr	-914(ra) # 5f68 <printf>
    exit(1);
    5302:	4505                	li	a0,1
    5304:	00001097          	auipc	ra,0x1
    5308:	8ea080e7          	jalr	-1814(ra) # 5bee <exit>
      printf("%s: read bigfile failed\n", s);
    530c:	85d6                	mv	a1,s5
    530e:	00003517          	auipc	a0,0x3
    5312:	cb250513          	addi	a0,a0,-846 # 7fc0 <malloc+0x1fa0>
    5316:	00001097          	auipc	ra,0x1
    531a:	c52080e7          	jalr	-942(ra) # 5f68 <printf>
      exit(1);
    531e:	4505                	li	a0,1
    5320:	00001097          	auipc	ra,0x1
    5324:	8ce080e7          	jalr	-1842(ra) # 5bee <exit>
      printf("%s: short read bigfile\n", s);
    5328:	85d6                	mv	a1,s5
    532a:	00003517          	auipc	a0,0x3
    532e:	cb650513          	addi	a0,a0,-842 # 7fe0 <malloc+0x1fc0>
    5332:	00001097          	auipc	ra,0x1
    5336:	c36080e7          	jalr	-970(ra) # 5f68 <printf>
      exit(1);
    533a:	4505                	li	a0,1
    533c:	00001097          	auipc	ra,0x1
    5340:	8b2080e7          	jalr	-1870(ra) # 5bee <exit>
      printf("%s: read bigfile wrong data\n", s);
    5344:	85d6                	mv	a1,s5
    5346:	00003517          	auipc	a0,0x3
    534a:	cb250513          	addi	a0,a0,-846 # 7ff8 <malloc+0x1fd8>
    534e:	00001097          	auipc	ra,0x1
    5352:	c1a080e7          	jalr	-998(ra) # 5f68 <printf>
      exit(1);
    5356:	4505                	li	a0,1
    5358:	00001097          	auipc	ra,0x1
    535c:	896080e7          	jalr	-1898(ra) # 5bee <exit>
  close(fd);
    5360:	8552                	mv	a0,s4
    5362:	00001097          	auipc	ra,0x1
    5366:	8b4080e7          	jalr	-1868(ra) # 5c16 <close>
  if(total != N*SZ){
    536a:	678d                	lui	a5,0x3
    536c:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x86>
    5370:	02f99363          	bne	s3,a5,5396 <bigfile+0x1c4>
  unlink("bigfile.dat");
    5374:	00003517          	auipc	a0,0x3
    5378:	bdc50513          	addi	a0,a0,-1060 # 7f50 <malloc+0x1f30>
    537c:	00001097          	auipc	ra,0x1
    5380:	8c2080e7          	jalr	-1854(ra) # 5c3e <unlink>
}
    5384:	70e2                	ld	ra,56(sp)
    5386:	7442                	ld	s0,48(sp)
    5388:	74a2                	ld	s1,40(sp)
    538a:	7902                	ld	s2,32(sp)
    538c:	69e2                	ld	s3,24(sp)
    538e:	6a42                	ld	s4,16(sp)
    5390:	6aa2                	ld	s5,8(sp)
    5392:	6121                	addi	sp,sp,64
    5394:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    5396:	85d6                	mv	a1,s5
    5398:	00003517          	auipc	a0,0x3
    539c:	c8050513          	addi	a0,a0,-896 # 8018 <malloc+0x1ff8>
    53a0:	00001097          	auipc	ra,0x1
    53a4:	bc8080e7          	jalr	-1080(ra) # 5f68 <printf>
    exit(1);
    53a8:	4505                	li	a0,1
    53aa:	00001097          	auipc	ra,0x1
    53ae:	844080e7          	jalr	-1980(ra) # 5bee <exit>

00000000000053b2 <fsfull>:
{
    53b2:	7171                	addi	sp,sp,-176
    53b4:	f506                	sd	ra,168(sp)
    53b6:	f122                	sd	s0,160(sp)
    53b8:	ed26                	sd	s1,152(sp)
    53ba:	e94a                	sd	s2,144(sp)
    53bc:	e54e                	sd	s3,136(sp)
    53be:	e152                	sd	s4,128(sp)
    53c0:	fcd6                	sd	s5,120(sp)
    53c2:	f8da                	sd	s6,112(sp)
    53c4:	f4de                	sd	s7,104(sp)
    53c6:	f0e2                	sd	s8,96(sp)
    53c8:	ece6                	sd	s9,88(sp)
    53ca:	e8ea                	sd	s10,80(sp)
    53cc:	e4ee                	sd	s11,72(sp)
    53ce:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53d0:	00003517          	auipc	a0,0x3
    53d4:	c6850513          	addi	a0,a0,-920 # 8038 <malloc+0x2018>
    53d8:	00001097          	auipc	ra,0x1
    53dc:	b90080e7          	jalr	-1136(ra) # 5f68 <printf>
  for(nfiles = 0; ; nfiles++){
    53e0:	4481                	li	s1,0
    name[0] = 'f';
    53e2:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53e6:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53ea:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53ee:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53f0:	00003c97          	auipc	s9,0x3
    53f4:	c58c8c93          	addi	s9,s9,-936 # 8048 <malloc+0x2028>
    int total = 0;
    53f8:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    53fa:	00008a17          	auipc	s4,0x8
    53fe:	87ea0a13          	addi	s4,s4,-1922 # cc78 <buf>
    name[0] = 'f';
    5402:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5406:	0384c7bb          	divw	a5,s1,s8
    540a:	0307879b          	addiw	a5,a5,48
    540e:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5412:	0384e7bb          	remw	a5,s1,s8
    5416:	0377c7bb          	divw	a5,a5,s7
    541a:	0307879b          	addiw	a5,a5,48
    541e:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5422:	0374e7bb          	remw	a5,s1,s7
    5426:	0367c7bb          	divw	a5,a5,s6
    542a:	0307879b          	addiw	a5,a5,48
    542e:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5432:	0364e7bb          	remw	a5,s1,s6
    5436:	0307879b          	addiw	a5,a5,48
    543a:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    543e:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5442:	f5040593          	addi	a1,s0,-176
    5446:	8566                	mv	a0,s9
    5448:	00001097          	auipc	ra,0x1
    544c:	b20080e7          	jalr	-1248(ra) # 5f68 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5450:	20200593          	li	a1,514
    5454:	f5040513          	addi	a0,s0,-176
    5458:	00000097          	auipc	ra,0x0
    545c:	7d6080e7          	jalr	2006(ra) # 5c2e <open>
    5460:	892a                	mv	s2,a0
    if(fd < 0){
    5462:	0a055663          	bgez	a0,550e <fsfull+0x15c>
      printf("open %s failed\n", name);
    5466:	f5040593          	addi	a1,s0,-176
    546a:	00003517          	auipc	a0,0x3
    546e:	bee50513          	addi	a0,a0,-1042 # 8058 <malloc+0x2038>
    5472:	00001097          	auipc	ra,0x1
    5476:	af6080e7          	jalr	-1290(ra) # 5f68 <printf>
  while(nfiles >= 0){
    547a:	0604c363          	bltz	s1,54e0 <fsfull+0x12e>
    name[0] = 'f';
    547e:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5482:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5486:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    548a:	4929                	li	s2,10
  while(nfiles >= 0){
    548c:	5afd                	li	s5,-1
    name[0] = 'f';
    548e:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5492:	0344c7bb          	divw	a5,s1,s4
    5496:	0307879b          	addiw	a5,a5,48
    549a:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    549e:	0344e7bb          	remw	a5,s1,s4
    54a2:	0337c7bb          	divw	a5,a5,s3
    54a6:	0307879b          	addiw	a5,a5,48
    54aa:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    54ae:	0334e7bb          	remw	a5,s1,s3
    54b2:	0327c7bb          	divw	a5,a5,s2
    54b6:	0307879b          	addiw	a5,a5,48
    54ba:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54be:	0324e7bb          	remw	a5,s1,s2
    54c2:	0307879b          	addiw	a5,a5,48
    54c6:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54ca:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54ce:	f5040513          	addi	a0,s0,-176
    54d2:	00000097          	auipc	ra,0x0
    54d6:	76c080e7          	jalr	1900(ra) # 5c3e <unlink>
    nfiles--;
    54da:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54dc:	fb5499e3          	bne	s1,s5,548e <fsfull+0xdc>
  printf("fsfull test finished\n");
    54e0:	00003517          	auipc	a0,0x3
    54e4:	b9850513          	addi	a0,a0,-1128 # 8078 <malloc+0x2058>
    54e8:	00001097          	auipc	ra,0x1
    54ec:	a80080e7          	jalr	-1408(ra) # 5f68 <printf>
}
    54f0:	70aa                	ld	ra,168(sp)
    54f2:	740a                	ld	s0,160(sp)
    54f4:	64ea                	ld	s1,152(sp)
    54f6:	694a                	ld	s2,144(sp)
    54f8:	69aa                	ld	s3,136(sp)
    54fa:	6a0a                	ld	s4,128(sp)
    54fc:	7ae6                	ld	s5,120(sp)
    54fe:	7b46                	ld	s6,112(sp)
    5500:	7ba6                	ld	s7,104(sp)
    5502:	7c06                	ld	s8,96(sp)
    5504:	6ce6                	ld	s9,88(sp)
    5506:	6d46                	ld	s10,80(sp)
    5508:	6da6                	ld	s11,72(sp)
    550a:	614d                	addi	sp,sp,176
    550c:	8082                	ret
    int total = 0;
    550e:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    5510:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    5514:	40000613          	li	a2,1024
    5518:	85d2                	mv	a1,s4
    551a:	854a                	mv	a0,s2
    551c:	00000097          	auipc	ra,0x0
    5520:	6f2080e7          	jalr	1778(ra) # 5c0e <write>
      if(cc < BSIZE)
    5524:	00aad563          	bge	s5,a0,552e <fsfull+0x17c>
      total += cc;
    5528:	00a989bb          	addw	s3,s3,a0
    while(1){
    552c:	b7e5                	j	5514 <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    552e:	85ce                	mv	a1,s3
    5530:	00003517          	auipc	a0,0x3
    5534:	b3850513          	addi	a0,a0,-1224 # 8068 <malloc+0x2048>
    5538:	00001097          	auipc	ra,0x1
    553c:	a30080e7          	jalr	-1488(ra) # 5f68 <printf>
    close(fd);
    5540:	854a                	mv	a0,s2
    5542:	00000097          	auipc	ra,0x0
    5546:	6d4080e7          	jalr	1748(ra) # 5c16 <close>
    if(total == 0)
    554a:	f20988e3          	beqz	s3,547a <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    554e:	2485                	addiw	s1,s1,1
    5550:	bd4d                	j	5402 <fsfull+0x50>

0000000000005552 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5552:	7179                	addi	sp,sp,-48
    5554:	f406                	sd	ra,40(sp)
    5556:	f022                	sd	s0,32(sp)
    5558:	ec26                	sd	s1,24(sp)
    555a:	e84a                	sd	s2,16(sp)
    555c:	1800                	addi	s0,sp,48
    555e:	84aa                	mv	s1,a0
    5560:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5562:	00003517          	auipc	a0,0x3
    5566:	b2e50513          	addi	a0,a0,-1234 # 8090 <malloc+0x2070>
    556a:	00001097          	auipc	ra,0x1
    556e:	9fe080e7          	jalr	-1538(ra) # 5f68 <printf>
  if((pid = fork()) < 0) {
    5572:	00000097          	auipc	ra,0x0
    5576:	674080e7          	jalr	1652(ra) # 5be6 <fork>
    557a:	02054e63          	bltz	a0,55b6 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    557e:	c929                	beqz	a0,55d0 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5580:	fdc40513          	addi	a0,s0,-36
    5584:	00000097          	auipc	ra,0x0
    5588:	672080e7          	jalr	1650(ra) # 5bf6 <wait>
    if(xstatus != 0) 
    558c:	fdc42783          	lw	a5,-36(s0)
    5590:	c7b9                	beqz	a5,55de <run+0x8c>
      printf("FAILED\n");
    5592:	00003517          	auipc	a0,0x3
    5596:	b2650513          	addi	a0,a0,-1242 # 80b8 <malloc+0x2098>
    559a:	00001097          	auipc	ra,0x1
    559e:	9ce080e7          	jalr	-1586(ra) # 5f68 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    55a2:	fdc42503          	lw	a0,-36(s0)
  }
}
    55a6:	00153513          	seqz	a0,a0
    55aa:	70a2                	ld	ra,40(sp)
    55ac:	7402                	ld	s0,32(sp)
    55ae:	64e2                	ld	s1,24(sp)
    55b0:	6942                	ld	s2,16(sp)
    55b2:	6145                	addi	sp,sp,48
    55b4:	8082                	ret
    printf("runtest: fork error\n");
    55b6:	00003517          	auipc	a0,0x3
    55ba:	aea50513          	addi	a0,a0,-1302 # 80a0 <malloc+0x2080>
    55be:	00001097          	auipc	ra,0x1
    55c2:	9aa080e7          	jalr	-1622(ra) # 5f68 <printf>
    exit(1);
    55c6:	4505                	li	a0,1
    55c8:	00000097          	auipc	ra,0x0
    55cc:	626080e7          	jalr	1574(ra) # 5bee <exit>
    f(s);
    55d0:	854a                	mv	a0,s2
    55d2:	9482                	jalr	s1
    exit(0);
    55d4:	4501                	li	a0,0
    55d6:	00000097          	auipc	ra,0x0
    55da:	618080e7          	jalr	1560(ra) # 5bee <exit>
      printf("OK\n");
    55de:	00003517          	auipc	a0,0x3
    55e2:	ae250513          	addi	a0,a0,-1310 # 80c0 <malloc+0x20a0>
    55e6:	00001097          	auipc	ra,0x1
    55ea:	982080e7          	jalr	-1662(ra) # 5f68 <printf>
    55ee:	bf55                	j	55a2 <run+0x50>

00000000000055f0 <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    55f0:	7179                	addi	sp,sp,-48
    55f2:	f406                	sd	ra,40(sp)
    55f4:	f022                	sd	s0,32(sp)
    55f6:	ec26                	sd	s1,24(sp)
    55f8:	e84a                	sd	s2,16(sp)
    55fa:	e44e                	sd	s3,8(sp)
    55fc:	e052                	sd	s4,0(sp)
    55fe:	1800                	addi	s0,sp,48
    5600:	84aa                	mv	s1,a0
  for (struct test *t = tests; t->s != 0; t++) {
    5602:	6508                	ld	a0,8(a0)
    5604:	c931                	beqz	a0,5658 <runtests+0x68>
    5606:	892e                	mv	s2,a1
    5608:	89b2                	mv	s3,a2
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s)){
        if(continuous != 2){
    560a:	4a09                	li	s4,2
    560c:	a021                	j	5614 <runtests+0x24>
  for (struct test *t = tests; t->s != 0; t++) {
    560e:	04c1                	addi	s1,s1,16
    5610:	6488                	ld	a0,8(s1)
    5612:	c91d                	beqz	a0,5648 <runtests+0x58>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5614:	00090863          	beqz	s2,5624 <runtests+0x34>
    5618:	85ca                	mv	a1,s2
    561a:	00000097          	auipc	ra,0x0
    561e:	384080e7          	jalr	900(ra) # 599e <strcmp>
    5622:	f575                	bnez	a0,560e <runtests+0x1e>
      if(!run(t->f, t->s)){
    5624:	648c                	ld	a1,8(s1)
    5626:	6088                	ld	a0,0(s1)
    5628:	00000097          	auipc	ra,0x0
    562c:	f2a080e7          	jalr	-214(ra) # 5552 <run>
    5630:	fd79                	bnez	a0,560e <runtests+0x1e>
        if(continuous != 2){
    5632:	fd498ee3          	beq	s3,s4,560e <runtests+0x1e>
          printf("SOME TESTS FAILED\n");
    5636:	00003517          	auipc	a0,0x3
    563a:	a9250513          	addi	a0,a0,-1390 # 80c8 <malloc+0x20a8>
    563e:	00001097          	auipc	ra,0x1
    5642:	92a080e7          	jalr	-1750(ra) # 5f68 <printf>
          return 1;
    5646:	4505                	li	a0,1
        }
      }
    }
  }
  return 0;
}
    5648:	70a2                	ld	ra,40(sp)
    564a:	7402                	ld	s0,32(sp)
    564c:	64e2                	ld	s1,24(sp)
    564e:	6942                	ld	s2,16(sp)
    5650:	69a2                	ld	s3,8(sp)
    5652:	6a02                	ld	s4,0(sp)
    5654:	6145                	addi	sp,sp,48
    5656:	8082                	ret
  return 0;
    5658:	4501                	li	a0,0
    565a:	b7fd                	j	5648 <runtests+0x58>

000000000000565c <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    565c:	7139                	addi	sp,sp,-64
    565e:	fc06                	sd	ra,56(sp)
    5660:	f822                	sd	s0,48(sp)
    5662:	f426                	sd	s1,40(sp)
    5664:	f04a                	sd	s2,32(sp)
    5666:	ec4e                	sd	s3,24(sp)
    5668:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    566a:	fc840513          	addi	a0,s0,-56
    566e:	00000097          	auipc	ra,0x0
    5672:	590080e7          	jalr	1424(ra) # 5bfe <pipe>
    5676:	06054763          	bltz	a0,56e4 <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    567a:	00000097          	auipc	ra,0x0
    567e:	56c080e7          	jalr	1388(ra) # 5be6 <fork>

  if(pid < 0){
    5682:	06054e63          	bltz	a0,56fe <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5686:	ed51                	bnez	a0,5722 <countfree+0xc6>
    close(fds[0]);
    5688:	fc842503          	lw	a0,-56(s0)
    568c:	00000097          	auipc	ra,0x0
    5690:	58a080e7          	jalr	1418(ra) # 5c16 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    5694:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5696:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5698:	00001997          	auipc	s3,0x1
    569c:	b2098993          	addi	s3,s3,-1248 # 61b8 <malloc+0x198>
      uint64 a = (uint64) sbrk(4096);
    56a0:	6505                	lui	a0,0x1
    56a2:	00000097          	auipc	ra,0x0
    56a6:	5d4080e7          	jalr	1492(ra) # 5c76 <sbrk>
      if(a == 0xffffffffffffffff){
    56aa:	07250763          	beq	a0,s2,5718 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    56ae:	6785                	lui	a5,0x1
    56b0:	97aa                	add	a5,a5,a0
    56b2:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0x103>
      if(write(fds[1], "x", 1) != 1){
    56b6:	8626                	mv	a2,s1
    56b8:	85ce                	mv	a1,s3
    56ba:	fcc42503          	lw	a0,-52(s0)
    56be:	00000097          	auipc	ra,0x0
    56c2:	550080e7          	jalr	1360(ra) # 5c0e <write>
    56c6:	fc950de3          	beq	a0,s1,56a0 <countfree+0x44>
        printf("write() failed in countfree()\n");
    56ca:	00003517          	auipc	a0,0x3
    56ce:	a5650513          	addi	a0,a0,-1450 # 8120 <malloc+0x2100>
    56d2:	00001097          	auipc	ra,0x1
    56d6:	896080e7          	jalr	-1898(ra) # 5f68 <printf>
        exit(1);
    56da:	4505                	li	a0,1
    56dc:	00000097          	auipc	ra,0x0
    56e0:	512080e7          	jalr	1298(ra) # 5bee <exit>
    printf("pipe() failed in countfree()\n");
    56e4:	00003517          	auipc	a0,0x3
    56e8:	9fc50513          	addi	a0,a0,-1540 # 80e0 <malloc+0x20c0>
    56ec:	00001097          	auipc	ra,0x1
    56f0:	87c080e7          	jalr	-1924(ra) # 5f68 <printf>
    exit(1);
    56f4:	4505                	li	a0,1
    56f6:	00000097          	auipc	ra,0x0
    56fa:	4f8080e7          	jalr	1272(ra) # 5bee <exit>
    printf("fork failed in countfree()\n");
    56fe:	00003517          	auipc	a0,0x3
    5702:	a0250513          	addi	a0,a0,-1534 # 8100 <malloc+0x20e0>
    5706:	00001097          	auipc	ra,0x1
    570a:	862080e7          	jalr	-1950(ra) # 5f68 <printf>
    exit(1);
    570e:	4505                	li	a0,1
    5710:	00000097          	auipc	ra,0x0
    5714:	4de080e7          	jalr	1246(ra) # 5bee <exit>
      }
    }

    exit(0);
    5718:	4501                	li	a0,0
    571a:	00000097          	auipc	ra,0x0
    571e:	4d4080e7          	jalr	1236(ra) # 5bee <exit>
  }

  close(fds[1]);
    5722:	fcc42503          	lw	a0,-52(s0)
    5726:	00000097          	auipc	ra,0x0
    572a:	4f0080e7          	jalr	1264(ra) # 5c16 <close>

  int n = 0;
    572e:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5730:	4605                	li	a2,1
    5732:	fc740593          	addi	a1,s0,-57
    5736:	fc842503          	lw	a0,-56(s0)
    573a:	00000097          	auipc	ra,0x0
    573e:	4cc080e7          	jalr	1228(ra) # 5c06 <read>
    if(cc < 0){
    5742:	00054563          	bltz	a0,574c <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5746:	c105                	beqz	a0,5766 <countfree+0x10a>
      break;
    n += 1;
    5748:	2485                	addiw	s1,s1,1
  while(1){
    574a:	b7dd                	j	5730 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    574c:	00003517          	auipc	a0,0x3
    5750:	9f450513          	addi	a0,a0,-1548 # 8140 <malloc+0x2120>
    5754:	00001097          	auipc	ra,0x1
    5758:	814080e7          	jalr	-2028(ra) # 5f68 <printf>
      exit(1);
    575c:	4505                	li	a0,1
    575e:	00000097          	auipc	ra,0x0
    5762:	490080e7          	jalr	1168(ra) # 5bee <exit>
  }

  close(fds[0]);
    5766:	fc842503          	lw	a0,-56(s0)
    576a:	00000097          	auipc	ra,0x0
    576e:	4ac080e7          	jalr	1196(ra) # 5c16 <close>
  wait((int*)0);
    5772:	4501                	li	a0,0
    5774:	00000097          	auipc	ra,0x0
    5778:	482080e7          	jalr	1154(ra) # 5bf6 <wait>
  
  return n;
}
    577c:	8526                	mv	a0,s1
    577e:	70e2                	ld	ra,56(sp)
    5780:	7442                	ld	s0,48(sp)
    5782:	74a2                	ld	s1,40(sp)
    5784:	7902                	ld	s2,32(sp)
    5786:	69e2                	ld	s3,24(sp)
    5788:	6121                	addi	sp,sp,64
    578a:	8082                	ret

000000000000578c <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    578c:	711d                	addi	sp,sp,-96
    578e:	ec86                	sd	ra,88(sp)
    5790:	e8a2                	sd	s0,80(sp)
    5792:	e4a6                	sd	s1,72(sp)
    5794:	e0ca                	sd	s2,64(sp)
    5796:	fc4e                	sd	s3,56(sp)
    5798:	f852                	sd	s4,48(sp)
    579a:	f456                	sd	s5,40(sp)
    579c:	f05a                	sd	s6,32(sp)
    579e:	ec5e                	sd	s7,24(sp)
    57a0:	e862                	sd	s8,16(sp)
    57a2:	e466                	sd	s9,8(sp)
    57a4:	e06a                	sd	s10,0(sp)
    57a6:	1080                	addi	s0,sp,96
    57a8:	8a2a                	mv	s4,a0
    57aa:	892e                	mv	s2,a1
    57ac:	89b2                	mv	s3,a2
  do {
    printf("usertests starting\n");
    57ae:	00003b97          	auipc	s7,0x3
    57b2:	9b2b8b93          	addi	s7,s7,-1614 # 8160 <malloc+0x2140>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone, continuous)) {
    57b6:	00004b17          	auipc	s6,0x4
    57ba:	85ab0b13          	addi	s6,s6,-1958 # 9010 <quicktests>
      if(continuous != 2) {
    57be:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    57c0:	00003c97          	auipc	s9,0x3
    57c4:	9d8c8c93          	addi	s9,s9,-1576 # 8198 <malloc+0x2178>
      if (runtests(slowtests, justone, continuous)) {
    57c8:	00004c17          	auipc	s8,0x4
    57cc:	c18c0c13          	addi	s8,s8,-1000 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    57d0:	00003d17          	auipc	s10,0x3
    57d4:	9a8d0d13          	addi	s10,s10,-1624 # 8178 <malloc+0x2158>
    57d8:	a839                	j	57f6 <drivetests+0x6a>
    57da:	856a                	mv	a0,s10
    57dc:	00000097          	auipc	ra,0x0
    57e0:	78c080e7          	jalr	1932(ra) # 5f68 <printf>
    57e4:	a089                	j	5826 <drivetests+0x9a>
    if((free1 = countfree()) < free0) {
    57e6:	00000097          	auipc	ra,0x0
    57ea:	e76080e7          	jalr	-394(ra) # 565c <countfree>
    57ee:	06954463          	blt	a0,s1,5856 <drivetests+0xca>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57f2:	08090163          	beqz	s2,5874 <drivetests+0xe8>
    printf("usertests starting\n");
    57f6:	855e                	mv	a0,s7
    57f8:	00000097          	auipc	ra,0x0
    57fc:	770080e7          	jalr	1904(ra) # 5f68 <printf>
    int free0 = countfree();
    5800:	00000097          	auipc	ra,0x0
    5804:	e5c080e7          	jalr	-420(ra) # 565c <countfree>
    5808:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone, continuous)) {
    580a:	864a                	mv	a2,s2
    580c:	85ce                	mv	a1,s3
    580e:	855a                	mv	a0,s6
    5810:	00000097          	auipc	ra,0x0
    5814:	de0080e7          	jalr	-544(ra) # 55f0 <runtests>
    5818:	c119                	beqz	a0,581e <drivetests+0x92>
      if(continuous != 2) {
    581a:	05591963          	bne	s2,s5,586c <drivetests+0xe0>
    if(!quick) {
    581e:	fc0a14e3          	bnez	s4,57e6 <drivetests+0x5a>
      if (justone == 0)
    5822:	fa098ce3          	beqz	s3,57da <drivetests+0x4e>
      if (runtests(slowtests, justone, continuous)) {
    5826:	864a                	mv	a2,s2
    5828:	85ce                	mv	a1,s3
    582a:	8562                	mv	a0,s8
    582c:	00000097          	auipc	ra,0x0
    5830:	dc4080e7          	jalr	-572(ra) # 55f0 <runtests>
    5834:	d94d                	beqz	a0,57e6 <drivetests+0x5a>
        if(continuous != 2) {
    5836:	03591d63          	bne	s2,s5,5870 <drivetests+0xe4>
    if((free1 = countfree()) < free0) {
    583a:	00000097          	auipc	ra,0x0
    583e:	e22080e7          	jalr	-478(ra) # 565c <countfree>
    5842:	fa9558e3          	bge	a0,s1,57f2 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5846:	8626                	mv	a2,s1
    5848:	85aa                	mv	a1,a0
    584a:	8566                	mv	a0,s9
    584c:	00000097          	auipc	ra,0x0
    5850:	71c080e7          	jalr	1820(ra) # 5f68 <printf>
      if(continuous != 2) {
    5854:	b74d                	j	57f6 <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5856:	8626                	mv	a2,s1
    5858:	85aa                	mv	a1,a0
    585a:	8566                	mv	a0,s9
    585c:	00000097          	auipc	ra,0x0
    5860:	70c080e7          	jalr	1804(ra) # 5f68 <printf>
      if(continuous != 2) {
    5864:	f95909e3          	beq	s2,s5,57f6 <drivetests+0x6a>
        return 1;
    5868:	4505                	li	a0,1
    586a:	a031                	j	5876 <drivetests+0xea>
        return 1;
    586c:	4505                	li	a0,1
    586e:	a021                	j	5876 <drivetests+0xea>
          return 1;
    5870:	4505                	li	a0,1
    5872:	a011                	j	5876 <drivetests+0xea>
  return 0;
    5874:	854a                	mv	a0,s2
}
    5876:	60e6                	ld	ra,88(sp)
    5878:	6446                	ld	s0,80(sp)
    587a:	64a6                	ld	s1,72(sp)
    587c:	6906                	ld	s2,64(sp)
    587e:	79e2                	ld	s3,56(sp)
    5880:	7a42                	ld	s4,48(sp)
    5882:	7aa2                	ld	s5,40(sp)
    5884:	7b02                	ld	s6,32(sp)
    5886:	6be2                	ld	s7,24(sp)
    5888:	6c42                	ld	s8,16(sp)
    588a:	6ca2                	ld	s9,8(sp)
    588c:	6d02                	ld	s10,0(sp)
    588e:	6125                	addi	sp,sp,96
    5890:	8082                	ret

0000000000005892 <main>:

int
main(int argc, char *argv[])
{
    5892:	1101                	addi	sp,sp,-32
    5894:	ec06                	sd	ra,24(sp)
    5896:	e822                	sd	s0,16(sp)
    5898:	e426                	sd	s1,8(sp)
    589a:	e04a                	sd	s2,0(sp)
    589c:	1000                	addi	s0,sp,32
    589e:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    58a0:	4789                	li	a5,2
    58a2:	02f50263          	beq	a0,a5,58c6 <main+0x34>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    58a6:	4785                	li	a5,1
    58a8:	06a7cd63          	blt	a5,a0,5922 <main+0x90>
  char *justone = 0;
    58ac:	4601                	li	a2,0
  int quick = 0;
    58ae:	4501                	li	a0,0
  int continuous = 0;
    58b0:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    58b2:	00000097          	auipc	ra,0x0
    58b6:	eda080e7          	jalr	-294(ra) # 578c <drivetests>
    58ba:	c951                	beqz	a0,594e <main+0xbc>
    exit(1);
    58bc:	4505                	li	a0,1
    58be:	00000097          	auipc	ra,0x0
    58c2:	330080e7          	jalr	816(ra) # 5bee <exit>
    58c6:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    58c8:	00003597          	auipc	a1,0x3
    58cc:	90058593          	addi	a1,a1,-1792 # 81c8 <malloc+0x21a8>
    58d0:	00893503          	ld	a0,8(s2)
    58d4:	00000097          	auipc	ra,0x0
    58d8:	0ca080e7          	jalr	202(ra) # 599e <strcmp>
    58dc:	85aa                	mv	a1,a0
    58de:	cd39                	beqz	a0,593c <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    58e0:	00003597          	auipc	a1,0x3
    58e4:	94058593          	addi	a1,a1,-1728 # 8220 <malloc+0x2200>
    58e8:	00893503          	ld	a0,8(s2)
    58ec:	00000097          	auipc	ra,0x0
    58f0:	0b2080e7          	jalr	178(ra) # 599e <strcmp>
    58f4:	c931                	beqz	a0,5948 <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    58f6:	00003597          	auipc	a1,0x3
    58fa:	92258593          	addi	a1,a1,-1758 # 8218 <malloc+0x21f8>
    58fe:	00893503          	ld	a0,8(s2)
    5902:	00000097          	auipc	ra,0x0
    5906:	09c080e7          	jalr	156(ra) # 599e <strcmp>
    590a:	cd05                	beqz	a0,5942 <main+0xb0>
  } else if(argc == 2 && argv[1][0] != '-'){
    590c:	00893603          	ld	a2,8(s2)
    5910:	00064703          	lbu	a4,0(a2) # 3000 <execout+0x9e>
    5914:	02d00793          	li	a5,45
    5918:	00f70563          	beq	a4,a5,5922 <main+0x90>
  int quick = 0;
    591c:	4501                	li	a0,0
  int continuous = 0;
    591e:	4581                	li	a1,0
    5920:	bf49                	j	58b2 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    5922:	00003517          	auipc	a0,0x3
    5926:	8ae50513          	addi	a0,a0,-1874 # 81d0 <malloc+0x21b0>
    592a:	00000097          	auipc	ra,0x0
    592e:	63e080e7          	jalr	1598(ra) # 5f68 <printf>
    exit(1);
    5932:	4505                	li	a0,1
    5934:	00000097          	auipc	ra,0x0
    5938:	2ba080e7          	jalr	698(ra) # 5bee <exit>
  char *justone = 0;
    593c:	4601                	li	a2,0
    quick = 1;
    593e:	4505                	li	a0,1
    5940:	bf8d                	j	58b2 <main+0x20>
    continuous = 2;
    5942:	85a6                	mv	a1,s1
  char *justone = 0;
    5944:	4601                	li	a2,0
    5946:	b7b5                	j	58b2 <main+0x20>
    5948:	4601                	li	a2,0
    continuous = 1;
    594a:	4585                	li	a1,1
    594c:	b79d                	j	58b2 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    594e:	00003517          	auipc	a0,0x3
    5952:	8b250513          	addi	a0,a0,-1870 # 8200 <malloc+0x21e0>
    5956:	00000097          	auipc	ra,0x0
    595a:	612080e7          	jalr	1554(ra) # 5f68 <printf>
  exit(0);
    595e:	4501                	li	a0,0
    5960:	00000097          	auipc	ra,0x0
    5964:	28e080e7          	jalr	654(ra) # 5bee <exit>

0000000000005968 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5968:	1141                	addi	sp,sp,-16
    596a:	e406                	sd	ra,8(sp)
    596c:	e022                	sd	s0,0(sp)
    596e:	0800                	addi	s0,sp,16
  extern int main();
  main();
    5970:	00000097          	auipc	ra,0x0
    5974:	f22080e7          	jalr	-222(ra) # 5892 <main>
  exit(0);
    5978:	4501                	li	a0,0
    597a:	00000097          	auipc	ra,0x0
    597e:	274080e7          	jalr	628(ra) # 5bee <exit>

0000000000005982 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    5982:	1141                	addi	sp,sp,-16
    5984:	e422                	sd	s0,8(sp)
    5986:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5988:	87aa                	mv	a5,a0
    598a:	0585                	addi	a1,a1,1
    598c:	0785                	addi	a5,a5,1
    598e:	fff5c703          	lbu	a4,-1(a1)
    5992:	fee78fa3          	sb	a4,-1(a5)
    5996:	fb75                	bnez	a4,598a <strcpy+0x8>
    ;
  return os;
}
    5998:	6422                	ld	s0,8(sp)
    599a:	0141                	addi	sp,sp,16
    599c:	8082                	ret

000000000000599e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    599e:	1141                	addi	sp,sp,-16
    59a0:	e422                	sd	s0,8(sp)
    59a2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    59a4:	00054783          	lbu	a5,0(a0)
    59a8:	cb91                	beqz	a5,59bc <strcmp+0x1e>
    59aa:	0005c703          	lbu	a4,0(a1)
    59ae:	00f71763          	bne	a4,a5,59bc <strcmp+0x1e>
    p++, q++;
    59b2:	0505                	addi	a0,a0,1
    59b4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    59b6:	00054783          	lbu	a5,0(a0)
    59ba:	fbe5                	bnez	a5,59aa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    59bc:	0005c503          	lbu	a0,0(a1)
}
    59c0:	40a7853b          	subw	a0,a5,a0
    59c4:	6422                	ld	s0,8(sp)
    59c6:	0141                	addi	sp,sp,16
    59c8:	8082                	ret

00000000000059ca <strlen>:

uint
strlen(const char *s)
{
    59ca:	1141                	addi	sp,sp,-16
    59cc:	e422                	sd	s0,8(sp)
    59ce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    59d0:	00054783          	lbu	a5,0(a0)
    59d4:	cf91                	beqz	a5,59f0 <strlen+0x26>
    59d6:	0505                	addi	a0,a0,1
    59d8:	87aa                	mv	a5,a0
    59da:	4685                	li	a3,1
    59dc:	9e89                	subw	a3,a3,a0
    59de:	00f6853b          	addw	a0,a3,a5
    59e2:	0785                	addi	a5,a5,1
    59e4:	fff7c703          	lbu	a4,-1(a5)
    59e8:	fb7d                	bnez	a4,59de <strlen+0x14>
    ;
  return n;
}
    59ea:	6422                	ld	s0,8(sp)
    59ec:	0141                	addi	sp,sp,16
    59ee:	8082                	ret
  for(n = 0; s[n]; n++)
    59f0:	4501                	li	a0,0
    59f2:	bfe5                	j	59ea <strlen+0x20>

00000000000059f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    59f4:	1141                	addi	sp,sp,-16
    59f6:	e422                	sd	s0,8(sp)
    59f8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    59fa:	ca19                	beqz	a2,5a10 <memset+0x1c>
    59fc:	87aa                	mv	a5,a0
    59fe:	1602                	slli	a2,a2,0x20
    5a00:	9201                	srli	a2,a2,0x20
    5a02:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5a06:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    5a0a:	0785                	addi	a5,a5,1
    5a0c:	fee79de3          	bne	a5,a4,5a06 <memset+0x12>
  }
  return dst;
}
    5a10:	6422                	ld	s0,8(sp)
    5a12:	0141                	addi	sp,sp,16
    5a14:	8082                	ret

0000000000005a16 <strchr>:

char*
strchr(const char *s, char c)
{
    5a16:	1141                	addi	sp,sp,-16
    5a18:	e422                	sd	s0,8(sp)
    5a1a:	0800                	addi	s0,sp,16
  for(; *s; s++)
    5a1c:	00054783          	lbu	a5,0(a0)
    5a20:	cb99                	beqz	a5,5a36 <strchr+0x20>
    if(*s == c)
    5a22:	00f58763          	beq	a1,a5,5a30 <strchr+0x1a>
  for(; *s; s++)
    5a26:	0505                	addi	a0,a0,1
    5a28:	00054783          	lbu	a5,0(a0)
    5a2c:	fbfd                	bnez	a5,5a22 <strchr+0xc>
      return (char*)s;
  return 0;
    5a2e:	4501                	li	a0,0
}
    5a30:	6422                	ld	s0,8(sp)
    5a32:	0141                	addi	sp,sp,16
    5a34:	8082                	ret
  return 0;
    5a36:	4501                	li	a0,0
    5a38:	bfe5                	j	5a30 <strchr+0x1a>

0000000000005a3a <gets>:

char*
gets(char *buf, int max)
{
    5a3a:	711d                	addi	sp,sp,-96
    5a3c:	ec86                	sd	ra,88(sp)
    5a3e:	e8a2                	sd	s0,80(sp)
    5a40:	e4a6                	sd	s1,72(sp)
    5a42:	e0ca                	sd	s2,64(sp)
    5a44:	fc4e                	sd	s3,56(sp)
    5a46:	f852                	sd	s4,48(sp)
    5a48:	f456                	sd	s5,40(sp)
    5a4a:	f05a                	sd	s6,32(sp)
    5a4c:	ec5e                	sd	s7,24(sp)
    5a4e:	1080                	addi	s0,sp,96
    5a50:	8baa                	mv	s7,a0
    5a52:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5a54:	892a                	mv	s2,a0
    5a56:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5a58:	4aa9                	li	s5,10
    5a5a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5a5c:	89a6                	mv	s3,s1
    5a5e:	2485                	addiw	s1,s1,1
    5a60:	0344d863          	bge	s1,s4,5a90 <gets+0x56>
    cc = read(0, &c, 1);
    5a64:	4605                	li	a2,1
    5a66:	faf40593          	addi	a1,s0,-81
    5a6a:	4501                	li	a0,0
    5a6c:	00000097          	auipc	ra,0x0
    5a70:	19a080e7          	jalr	410(ra) # 5c06 <read>
    if(cc < 1)
    5a74:	00a05e63          	blez	a0,5a90 <gets+0x56>
    buf[i++] = c;
    5a78:	faf44783          	lbu	a5,-81(s0)
    5a7c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a80:	01578763          	beq	a5,s5,5a8e <gets+0x54>
    5a84:	0905                	addi	s2,s2,1
    5a86:	fd679be3          	bne	a5,s6,5a5c <gets+0x22>
  for(i=0; i+1 < max; ){
    5a8a:	89a6                	mv	s3,s1
    5a8c:	a011                	j	5a90 <gets+0x56>
    5a8e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a90:	99de                	add	s3,s3,s7
    5a92:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a96:	855e                	mv	a0,s7
    5a98:	60e6                	ld	ra,88(sp)
    5a9a:	6446                	ld	s0,80(sp)
    5a9c:	64a6                	ld	s1,72(sp)
    5a9e:	6906                	ld	s2,64(sp)
    5aa0:	79e2                	ld	s3,56(sp)
    5aa2:	7a42                	ld	s4,48(sp)
    5aa4:	7aa2                	ld	s5,40(sp)
    5aa6:	7b02                	ld	s6,32(sp)
    5aa8:	6be2                	ld	s7,24(sp)
    5aaa:	6125                	addi	sp,sp,96
    5aac:	8082                	ret

0000000000005aae <stat>:

int
stat(const char *n, struct stat *st)
{
    5aae:	1101                	addi	sp,sp,-32
    5ab0:	ec06                	sd	ra,24(sp)
    5ab2:	e822                	sd	s0,16(sp)
    5ab4:	e426                	sd	s1,8(sp)
    5ab6:	e04a                	sd	s2,0(sp)
    5ab8:	1000                	addi	s0,sp,32
    5aba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5abc:	4581                	li	a1,0
    5abe:	00000097          	auipc	ra,0x0
    5ac2:	170080e7          	jalr	368(ra) # 5c2e <open>
  if(fd < 0)
    5ac6:	02054563          	bltz	a0,5af0 <stat+0x42>
    5aca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5acc:	85ca                	mv	a1,s2
    5ace:	00000097          	auipc	ra,0x0
    5ad2:	178080e7          	jalr	376(ra) # 5c46 <fstat>
    5ad6:	892a                	mv	s2,a0
  close(fd);
    5ad8:	8526                	mv	a0,s1
    5ada:	00000097          	auipc	ra,0x0
    5ade:	13c080e7          	jalr	316(ra) # 5c16 <close>
  return r;
}
    5ae2:	854a                	mv	a0,s2
    5ae4:	60e2                	ld	ra,24(sp)
    5ae6:	6442                	ld	s0,16(sp)
    5ae8:	64a2                	ld	s1,8(sp)
    5aea:	6902                	ld	s2,0(sp)
    5aec:	6105                	addi	sp,sp,32
    5aee:	8082                	ret
    return -1;
    5af0:	597d                	li	s2,-1
    5af2:	bfc5                	j	5ae2 <stat+0x34>

0000000000005af4 <atoi>:

int
atoi(const char *s)
{
    5af4:	1141                	addi	sp,sp,-16
    5af6:	e422                	sd	s0,8(sp)
    5af8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5afa:	00054683          	lbu	a3,0(a0)
    5afe:	fd06879b          	addiw	a5,a3,-48
    5b02:	0ff7f793          	zext.b	a5,a5
    5b06:	4625                	li	a2,9
    5b08:	02f66863          	bltu	a2,a5,5b38 <atoi+0x44>
    5b0c:	872a                	mv	a4,a0
  n = 0;
    5b0e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5b10:	0705                	addi	a4,a4,1
    5b12:	0025179b          	slliw	a5,a0,0x2
    5b16:	9fa9                	addw	a5,a5,a0
    5b18:	0017979b          	slliw	a5,a5,0x1
    5b1c:	9fb5                	addw	a5,a5,a3
    5b1e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5b22:	00074683          	lbu	a3,0(a4)
    5b26:	fd06879b          	addiw	a5,a3,-48
    5b2a:	0ff7f793          	zext.b	a5,a5
    5b2e:	fef671e3          	bgeu	a2,a5,5b10 <atoi+0x1c>
  return n;
}
    5b32:	6422                	ld	s0,8(sp)
    5b34:	0141                	addi	sp,sp,16
    5b36:	8082                	ret
  n = 0;
    5b38:	4501                	li	a0,0
    5b3a:	bfe5                	j	5b32 <atoi+0x3e>

0000000000005b3c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5b3c:	1141                	addi	sp,sp,-16
    5b3e:	e422                	sd	s0,8(sp)
    5b40:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b42:	02b57463          	bgeu	a0,a1,5b6a <memmove+0x2e>
    while(n-- > 0)
    5b46:	00c05f63          	blez	a2,5b64 <memmove+0x28>
    5b4a:	1602                	slli	a2,a2,0x20
    5b4c:	9201                	srli	a2,a2,0x20
    5b4e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5b52:	872a                	mv	a4,a0
      *dst++ = *src++;
    5b54:	0585                	addi	a1,a1,1
    5b56:	0705                	addi	a4,a4,1
    5b58:	fff5c683          	lbu	a3,-1(a1)
    5b5c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b60:	fee79ae3          	bne	a5,a4,5b54 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b64:	6422                	ld	s0,8(sp)
    5b66:	0141                	addi	sp,sp,16
    5b68:	8082                	ret
    dst += n;
    5b6a:	00c50733          	add	a4,a0,a2
    src += n;
    5b6e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b70:	fec05ae3          	blez	a2,5b64 <memmove+0x28>
    5b74:	fff6079b          	addiw	a5,a2,-1
    5b78:	1782                	slli	a5,a5,0x20
    5b7a:	9381                	srli	a5,a5,0x20
    5b7c:	fff7c793          	not	a5,a5
    5b80:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b82:	15fd                	addi	a1,a1,-1
    5b84:	177d                	addi	a4,a4,-1
    5b86:	0005c683          	lbu	a3,0(a1)
    5b8a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b8e:	fee79ae3          	bne	a5,a4,5b82 <memmove+0x46>
    5b92:	bfc9                	j	5b64 <memmove+0x28>

0000000000005b94 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b94:	1141                	addi	sp,sp,-16
    5b96:	e422                	sd	s0,8(sp)
    5b98:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5b9a:	ca05                	beqz	a2,5bca <memcmp+0x36>
    5b9c:	fff6069b          	addiw	a3,a2,-1
    5ba0:	1682                	slli	a3,a3,0x20
    5ba2:	9281                	srli	a3,a3,0x20
    5ba4:	0685                	addi	a3,a3,1
    5ba6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5ba8:	00054783          	lbu	a5,0(a0)
    5bac:	0005c703          	lbu	a4,0(a1)
    5bb0:	00e79863          	bne	a5,a4,5bc0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5bb4:	0505                	addi	a0,a0,1
    p2++;
    5bb6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5bb8:	fed518e3          	bne	a0,a3,5ba8 <memcmp+0x14>
  }
  return 0;
    5bbc:	4501                	li	a0,0
    5bbe:	a019                	j	5bc4 <memcmp+0x30>
      return *p1 - *p2;
    5bc0:	40e7853b          	subw	a0,a5,a4
}
    5bc4:	6422                	ld	s0,8(sp)
    5bc6:	0141                	addi	sp,sp,16
    5bc8:	8082                	ret
  return 0;
    5bca:	4501                	li	a0,0
    5bcc:	bfe5                	j	5bc4 <memcmp+0x30>

0000000000005bce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5bce:	1141                	addi	sp,sp,-16
    5bd0:	e406                	sd	ra,8(sp)
    5bd2:	e022                	sd	s0,0(sp)
    5bd4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5bd6:	00000097          	auipc	ra,0x0
    5bda:	f66080e7          	jalr	-154(ra) # 5b3c <memmove>
}
    5bde:	60a2                	ld	ra,8(sp)
    5be0:	6402                	ld	s0,0(sp)
    5be2:	0141                	addi	sp,sp,16
    5be4:	8082                	ret

0000000000005be6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5be6:	4885                	li	a7,1
 ecall
    5be8:	00000073          	ecall
 ret
    5bec:	8082                	ret

0000000000005bee <exit>:
.global exit
exit:
 li a7, SYS_exit
    5bee:	4889                	li	a7,2
 ecall
    5bf0:	00000073          	ecall
 ret
    5bf4:	8082                	ret

0000000000005bf6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5bf6:	488d                	li	a7,3
 ecall
    5bf8:	00000073          	ecall
 ret
    5bfc:	8082                	ret

0000000000005bfe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5bfe:	4891                	li	a7,4
 ecall
    5c00:	00000073          	ecall
 ret
    5c04:	8082                	ret

0000000000005c06 <read>:
.global read
read:
 li a7, SYS_read
    5c06:	4895                	li	a7,5
 ecall
    5c08:	00000073          	ecall
 ret
    5c0c:	8082                	ret

0000000000005c0e <write>:
.global write
write:
 li a7, SYS_write
    5c0e:	48c1                	li	a7,16
 ecall
    5c10:	00000073          	ecall
 ret
    5c14:	8082                	ret

0000000000005c16 <close>:
.global close
close:
 li a7, SYS_close
    5c16:	48d5                	li	a7,21
 ecall
    5c18:	00000073          	ecall
 ret
    5c1c:	8082                	ret

0000000000005c1e <kill>:
.global kill
kill:
 li a7, SYS_kill
    5c1e:	4899                	li	a7,6
 ecall
    5c20:	00000073          	ecall
 ret
    5c24:	8082                	ret

0000000000005c26 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c26:	489d                	li	a7,7
 ecall
    5c28:	00000073          	ecall
 ret
    5c2c:	8082                	ret

0000000000005c2e <open>:
.global open
open:
 li a7, SYS_open
    5c2e:	48bd                	li	a7,15
 ecall
    5c30:	00000073          	ecall
 ret
    5c34:	8082                	ret

0000000000005c36 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c36:	48c5                	li	a7,17
 ecall
    5c38:	00000073          	ecall
 ret
    5c3c:	8082                	ret

0000000000005c3e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c3e:	48c9                	li	a7,18
 ecall
    5c40:	00000073          	ecall
 ret
    5c44:	8082                	ret

0000000000005c46 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c46:	48a1                	li	a7,8
 ecall
    5c48:	00000073          	ecall
 ret
    5c4c:	8082                	ret

0000000000005c4e <link>:
.global link
link:
 li a7, SYS_link
    5c4e:	48cd                	li	a7,19
 ecall
    5c50:	00000073          	ecall
 ret
    5c54:	8082                	ret

0000000000005c56 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c56:	48d1                	li	a7,20
 ecall
    5c58:	00000073          	ecall
 ret
    5c5c:	8082                	ret

0000000000005c5e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c5e:	48a5                	li	a7,9
 ecall
    5c60:	00000073          	ecall
 ret
    5c64:	8082                	ret

0000000000005c66 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c66:	48a9                	li	a7,10
 ecall
    5c68:	00000073          	ecall
 ret
    5c6c:	8082                	ret

0000000000005c6e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c6e:	48ad                	li	a7,11
 ecall
    5c70:	00000073          	ecall
 ret
    5c74:	8082                	ret

0000000000005c76 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5c76:	48b1                	li	a7,12
 ecall
    5c78:	00000073          	ecall
 ret
    5c7c:	8082                	ret

0000000000005c7e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5c7e:	48b5                	li	a7,13
 ecall
    5c80:	00000073          	ecall
 ret
    5c84:	8082                	ret

0000000000005c86 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5c86:	48b9                	li	a7,14
 ecall
    5c88:	00000073          	ecall
 ret
    5c8c:	8082                	ret

0000000000005c8e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5c8e:	1101                	addi	sp,sp,-32
    5c90:	ec06                	sd	ra,24(sp)
    5c92:	e822                	sd	s0,16(sp)
    5c94:	1000                	addi	s0,sp,32
    5c96:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5c9a:	4605                	li	a2,1
    5c9c:	fef40593          	addi	a1,s0,-17
    5ca0:	00000097          	auipc	ra,0x0
    5ca4:	f6e080e7          	jalr	-146(ra) # 5c0e <write>
}
    5ca8:	60e2                	ld	ra,24(sp)
    5caa:	6442                	ld	s0,16(sp)
    5cac:	6105                	addi	sp,sp,32
    5cae:	8082                	ret

0000000000005cb0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5cb0:	7139                	addi	sp,sp,-64
    5cb2:	fc06                	sd	ra,56(sp)
    5cb4:	f822                	sd	s0,48(sp)
    5cb6:	f426                	sd	s1,40(sp)
    5cb8:	f04a                	sd	s2,32(sp)
    5cba:	ec4e                	sd	s3,24(sp)
    5cbc:	0080                	addi	s0,sp,64
    5cbe:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5cc0:	c299                	beqz	a3,5cc6 <printint+0x16>
    5cc2:	0805c963          	bltz	a1,5d54 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5cc6:	2581                	sext.w	a1,a1
  neg = 0;
    5cc8:	4881                	li	a7,0
    5cca:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5cce:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5cd0:	2601                	sext.w	a2,a2
    5cd2:	00003517          	auipc	a0,0x3
    5cd6:	91650513          	addi	a0,a0,-1770 # 85e8 <digits>
    5cda:	883a                	mv	a6,a4
    5cdc:	2705                	addiw	a4,a4,1
    5cde:	02c5f7bb          	remuw	a5,a1,a2
    5ce2:	1782                	slli	a5,a5,0x20
    5ce4:	9381                	srli	a5,a5,0x20
    5ce6:	97aa                	add	a5,a5,a0
    5ce8:	0007c783          	lbu	a5,0(a5)
    5cec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5cf0:	0005879b          	sext.w	a5,a1
    5cf4:	02c5d5bb          	divuw	a1,a1,a2
    5cf8:	0685                	addi	a3,a3,1
    5cfa:	fec7f0e3          	bgeu	a5,a2,5cda <printint+0x2a>
  if(neg)
    5cfe:	00088c63          	beqz	a7,5d16 <printint+0x66>
    buf[i++] = '-';
    5d02:	fd070793          	addi	a5,a4,-48
    5d06:	00878733          	add	a4,a5,s0
    5d0a:	02d00793          	li	a5,45
    5d0e:	fef70823          	sb	a5,-16(a4)
    5d12:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5d16:	02e05863          	blez	a4,5d46 <printint+0x96>
    5d1a:	fc040793          	addi	a5,s0,-64
    5d1e:	00e78933          	add	s2,a5,a4
    5d22:	fff78993          	addi	s3,a5,-1
    5d26:	99ba                	add	s3,s3,a4
    5d28:	377d                	addiw	a4,a4,-1
    5d2a:	1702                	slli	a4,a4,0x20
    5d2c:	9301                	srli	a4,a4,0x20
    5d2e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5d32:	fff94583          	lbu	a1,-1(s2)
    5d36:	8526                	mv	a0,s1
    5d38:	00000097          	auipc	ra,0x0
    5d3c:	f56080e7          	jalr	-170(ra) # 5c8e <putc>
  while(--i >= 0)
    5d40:	197d                	addi	s2,s2,-1
    5d42:	ff3918e3          	bne	s2,s3,5d32 <printint+0x82>
}
    5d46:	70e2                	ld	ra,56(sp)
    5d48:	7442                	ld	s0,48(sp)
    5d4a:	74a2                	ld	s1,40(sp)
    5d4c:	7902                	ld	s2,32(sp)
    5d4e:	69e2                	ld	s3,24(sp)
    5d50:	6121                	addi	sp,sp,64
    5d52:	8082                	ret
    x = -xx;
    5d54:	40b005bb          	negw	a1,a1
    neg = 1;
    5d58:	4885                	li	a7,1
    x = -xx;
    5d5a:	bf85                	j	5cca <printint+0x1a>

0000000000005d5c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5d5c:	7119                	addi	sp,sp,-128
    5d5e:	fc86                	sd	ra,120(sp)
    5d60:	f8a2                	sd	s0,112(sp)
    5d62:	f4a6                	sd	s1,104(sp)
    5d64:	f0ca                	sd	s2,96(sp)
    5d66:	ecce                	sd	s3,88(sp)
    5d68:	e8d2                	sd	s4,80(sp)
    5d6a:	e4d6                	sd	s5,72(sp)
    5d6c:	e0da                	sd	s6,64(sp)
    5d6e:	fc5e                	sd	s7,56(sp)
    5d70:	f862                	sd	s8,48(sp)
    5d72:	f466                	sd	s9,40(sp)
    5d74:	f06a                	sd	s10,32(sp)
    5d76:	ec6e                	sd	s11,24(sp)
    5d78:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5d7a:	0005c903          	lbu	s2,0(a1)
    5d7e:	18090f63          	beqz	s2,5f1c <vprintf+0x1c0>
    5d82:	8aaa                	mv	s5,a0
    5d84:	8b32                	mv	s6,a2
    5d86:	00158493          	addi	s1,a1,1
  state = 0;
    5d8a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5d8c:	02500a13          	li	s4,37
    5d90:	4c55                	li	s8,21
    5d92:	00002c97          	auipc	s9,0x2
    5d96:	7fec8c93          	addi	s9,s9,2046 # 8590 <malloc+0x2570>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    5d9a:	02800d93          	li	s11,40
  putc(fd, 'x');
    5d9e:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5da0:	00003b97          	auipc	s7,0x3
    5da4:	848b8b93          	addi	s7,s7,-1976 # 85e8 <digits>
    5da8:	a839                	j	5dc6 <vprintf+0x6a>
        putc(fd, c);
    5daa:	85ca                	mv	a1,s2
    5dac:	8556                	mv	a0,s5
    5dae:	00000097          	auipc	ra,0x0
    5db2:	ee0080e7          	jalr	-288(ra) # 5c8e <putc>
    5db6:	a019                	j	5dbc <vprintf+0x60>
    } else if(state == '%'){
    5db8:	01498d63          	beq	s3,s4,5dd2 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    5dbc:	0485                	addi	s1,s1,1
    5dbe:	fff4c903          	lbu	s2,-1(s1)
    5dc2:	14090d63          	beqz	s2,5f1c <vprintf+0x1c0>
    if(state == 0){
    5dc6:	fe0999e3          	bnez	s3,5db8 <vprintf+0x5c>
      if(c == '%'){
    5dca:	ff4910e3          	bne	s2,s4,5daa <vprintf+0x4e>
        state = '%';
    5dce:	89d2                	mv	s3,s4
    5dd0:	b7f5                	j	5dbc <vprintf+0x60>
      if(c == 'd'){
    5dd2:	11490c63          	beq	s2,s4,5eea <vprintf+0x18e>
    5dd6:	f9d9079b          	addiw	a5,s2,-99
    5dda:	0ff7f793          	zext.b	a5,a5
    5dde:	10fc6e63          	bltu	s8,a5,5efa <vprintf+0x19e>
    5de2:	f9d9079b          	addiw	a5,s2,-99
    5de6:	0ff7f713          	zext.b	a4,a5
    5dea:	10ec6863          	bltu	s8,a4,5efa <vprintf+0x19e>
    5dee:	00271793          	slli	a5,a4,0x2
    5df2:	97e6                	add	a5,a5,s9
    5df4:	439c                	lw	a5,0(a5)
    5df6:	97e6                	add	a5,a5,s9
    5df8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5dfa:	008b0913          	addi	s2,s6,8
    5dfe:	4685                	li	a3,1
    5e00:	4629                	li	a2,10
    5e02:	000b2583          	lw	a1,0(s6)
    5e06:	8556                	mv	a0,s5
    5e08:	00000097          	auipc	ra,0x0
    5e0c:	ea8080e7          	jalr	-344(ra) # 5cb0 <printint>
    5e10:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5e12:	4981                	li	s3,0
    5e14:	b765                	j	5dbc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e16:	008b0913          	addi	s2,s6,8
    5e1a:	4681                	li	a3,0
    5e1c:	4629                	li	a2,10
    5e1e:	000b2583          	lw	a1,0(s6)
    5e22:	8556                	mv	a0,s5
    5e24:	00000097          	auipc	ra,0x0
    5e28:	e8c080e7          	jalr	-372(ra) # 5cb0 <printint>
    5e2c:	8b4a                	mv	s6,s2
      state = 0;
    5e2e:	4981                	li	s3,0
    5e30:	b771                	j	5dbc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5e32:	008b0913          	addi	s2,s6,8
    5e36:	4681                	li	a3,0
    5e38:	866a                	mv	a2,s10
    5e3a:	000b2583          	lw	a1,0(s6)
    5e3e:	8556                	mv	a0,s5
    5e40:	00000097          	auipc	ra,0x0
    5e44:	e70080e7          	jalr	-400(ra) # 5cb0 <printint>
    5e48:	8b4a                	mv	s6,s2
      state = 0;
    5e4a:	4981                	li	s3,0
    5e4c:	bf85                	j	5dbc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5e4e:	008b0793          	addi	a5,s6,8
    5e52:	f8f43423          	sd	a5,-120(s0)
    5e56:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5e5a:	03000593          	li	a1,48
    5e5e:	8556                	mv	a0,s5
    5e60:	00000097          	auipc	ra,0x0
    5e64:	e2e080e7          	jalr	-466(ra) # 5c8e <putc>
  putc(fd, 'x');
    5e68:	07800593          	li	a1,120
    5e6c:	8556                	mv	a0,s5
    5e6e:	00000097          	auipc	ra,0x0
    5e72:	e20080e7          	jalr	-480(ra) # 5c8e <putc>
    5e76:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5e78:	03c9d793          	srli	a5,s3,0x3c
    5e7c:	97de                	add	a5,a5,s7
    5e7e:	0007c583          	lbu	a1,0(a5)
    5e82:	8556                	mv	a0,s5
    5e84:	00000097          	auipc	ra,0x0
    5e88:	e0a080e7          	jalr	-502(ra) # 5c8e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5e8c:	0992                	slli	s3,s3,0x4
    5e8e:	397d                	addiw	s2,s2,-1
    5e90:	fe0914e3          	bnez	s2,5e78 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    5e94:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5e98:	4981                	li	s3,0
    5e9a:	b70d                	j	5dbc <vprintf+0x60>
        s = va_arg(ap, char*);
    5e9c:	008b0913          	addi	s2,s6,8
    5ea0:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    5ea4:	02098163          	beqz	s3,5ec6 <vprintf+0x16a>
        while(*s != 0){
    5ea8:	0009c583          	lbu	a1,0(s3)
    5eac:	c5ad                	beqz	a1,5f16 <vprintf+0x1ba>
          putc(fd, *s);
    5eae:	8556                	mv	a0,s5
    5eb0:	00000097          	auipc	ra,0x0
    5eb4:	dde080e7          	jalr	-546(ra) # 5c8e <putc>
          s++;
    5eb8:	0985                	addi	s3,s3,1
        while(*s != 0){
    5eba:	0009c583          	lbu	a1,0(s3)
    5ebe:	f9e5                	bnez	a1,5eae <vprintf+0x152>
        s = va_arg(ap, char*);
    5ec0:	8b4a                	mv	s6,s2
      state = 0;
    5ec2:	4981                	li	s3,0
    5ec4:	bde5                	j	5dbc <vprintf+0x60>
          s = "(null)";
    5ec6:	00002997          	auipc	s3,0x2
    5eca:	6c298993          	addi	s3,s3,1730 # 8588 <malloc+0x2568>
        while(*s != 0){
    5ece:	85ee                	mv	a1,s11
    5ed0:	bff9                	j	5eae <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    5ed2:	008b0913          	addi	s2,s6,8
    5ed6:	000b4583          	lbu	a1,0(s6)
    5eda:	8556                	mv	a0,s5
    5edc:	00000097          	auipc	ra,0x0
    5ee0:	db2080e7          	jalr	-590(ra) # 5c8e <putc>
    5ee4:	8b4a                	mv	s6,s2
      state = 0;
    5ee6:	4981                	li	s3,0
    5ee8:	bdd1                	j	5dbc <vprintf+0x60>
        putc(fd, c);
    5eea:	85d2                	mv	a1,s4
    5eec:	8556                	mv	a0,s5
    5eee:	00000097          	auipc	ra,0x0
    5ef2:	da0080e7          	jalr	-608(ra) # 5c8e <putc>
      state = 0;
    5ef6:	4981                	li	s3,0
    5ef8:	b5d1                	j	5dbc <vprintf+0x60>
        putc(fd, '%');
    5efa:	85d2                	mv	a1,s4
    5efc:	8556                	mv	a0,s5
    5efe:	00000097          	auipc	ra,0x0
    5f02:	d90080e7          	jalr	-624(ra) # 5c8e <putc>
        putc(fd, c);
    5f06:	85ca                	mv	a1,s2
    5f08:	8556                	mv	a0,s5
    5f0a:	00000097          	auipc	ra,0x0
    5f0e:	d84080e7          	jalr	-636(ra) # 5c8e <putc>
      state = 0;
    5f12:	4981                	li	s3,0
    5f14:	b565                	j	5dbc <vprintf+0x60>
        s = va_arg(ap, char*);
    5f16:	8b4a                	mv	s6,s2
      state = 0;
    5f18:	4981                	li	s3,0
    5f1a:	b54d                	j	5dbc <vprintf+0x60>
    }
  }
}
    5f1c:	70e6                	ld	ra,120(sp)
    5f1e:	7446                	ld	s0,112(sp)
    5f20:	74a6                	ld	s1,104(sp)
    5f22:	7906                	ld	s2,96(sp)
    5f24:	69e6                	ld	s3,88(sp)
    5f26:	6a46                	ld	s4,80(sp)
    5f28:	6aa6                	ld	s5,72(sp)
    5f2a:	6b06                	ld	s6,64(sp)
    5f2c:	7be2                	ld	s7,56(sp)
    5f2e:	7c42                	ld	s8,48(sp)
    5f30:	7ca2                	ld	s9,40(sp)
    5f32:	7d02                	ld	s10,32(sp)
    5f34:	6de2                	ld	s11,24(sp)
    5f36:	6109                	addi	sp,sp,128
    5f38:	8082                	ret

0000000000005f3a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f3a:	715d                	addi	sp,sp,-80
    5f3c:	ec06                	sd	ra,24(sp)
    5f3e:	e822                	sd	s0,16(sp)
    5f40:	1000                	addi	s0,sp,32
    5f42:	e010                	sd	a2,0(s0)
    5f44:	e414                	sd	a3,8(s0)
    5f46:	e818                	sd	a4,16(s0)
    5f48:	ec1c                	sd	a5,24(s0)
    5f4a:	03043023          	sd	a6,32(s0)
    5f4e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f52:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f56:	8622                	mv	a2,s0
    5f58:	00000097          	auipc	ra,0x0
    5f5c:	e04080e7          	jalr	-508(ra) # 5d5c <vprintf>
}
    5f60:	60e2                	ld	ra,24(sp)
    5f62:	6442                	ld	s0,16(sp)
    5f64:	6161                	addi	sp,sp,80
    5f66:	8082                	ret

0000000000005f68 <printf>:

void
printf(const char *fmt, ...)
{
    5f68:	711d                	addi	sp,sp,-96
    5f6a:	ec06                	sd	ra,24(sp)
    5f6c:	e822                	sd	s0,16(sp)
    5f6e:	1000                	addi	s0,sp,32
    5f70:	e40c                	sd	a1,8(s0)
    5f72:	e810                	sd	a2,16(s0)
    5f74:	ec14                	sd	a3,24(s0)
    5f76:	f018                	sd	a4,32(s0)
    5f78:	f41c                	sd	a5,40(s0)
    5f7a:	03043823          	sd	a6,48(s0)
    5f7e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5f82:	00840613          	addi	a2,s0,8
    5f86:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5f8a:	85aa                	mv	a1,a0
    5f8c:	4505                	li	a0,1
    5f8e:	00000097          	auipc	ra,0x0
    5f92:	dce080e7          	jalr	-562(ra) # 5d5c <vprintf>
}
    5f96:	60e2                	ld	ra,24(sp)
    5f98:	6442                	ld	s0,16(sp)
    5f9a:	6125                	addi	sp,sp,96
    5f9c:	8082                	ret

0000000000005f9e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5f9e:	1141                	addi	sp,sp,-16
    5fa0:	e422                	sd	s0,8(sp)
    5fa2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5fa4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fa8:	00003797          	auipc	a5,0x3
    5fac:	4a87b783          	ld	a5,1192(a5) # 9450 <freep>
    5fb0:	a02d                	j	5fda <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5fb2:	4618                	lw	a4,8(a2)
    5fb4:	9f2d                	addw	a4,a4,a1
    5fb6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5fba:	6398                	ld	a4,0(a5)
    5fbc:	6310                	ld	a2,0(a4)
    5fbe:	a83d                	j	5ffc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5fc0:	ff852703          	lw	a4,-8(a0)
    5fc4:	9f31                	addw	a4,a4,a2
    5fc6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5fc8:	ff053683          	ld	a3,-16(a0)
    5fcc:	a091                	j	6010 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fce:	6398                	ld	a4,0(a5)
    5fd0:	00e7e463          	bltu	a5,a4,5fd8 <free+0x3a>
    5fd4:	00e6ea63          	bltu	a3,a4,5fe8 <free+0x4a>
{
    5fd8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fda:	fed7fae3          	bgeu	a5,a3,5fce <free+0x30>
    5fde:	6398                	ld	a4,0(a5)
    5fe0:	00e6e463          	bltu	a3,a4,5fe8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fe4:	fee7eae3          	bltu	a5,a4,5fd8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5fe8:	ff852583          	lw	a1,-8(a0)
    5fec:	6390                	ld	a2,0(a5)
    5fee:	02059813          	slli	a6,a1,0x20
    5ff2:	01c85713          	srli	a4,a6,0x1c
    5ff6:	9736                	add	a4,a4,a3
    5ff8:	fae60de3          	beq	a2,a4,5fb2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5ffc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    6000:	4790                	lw	a2,8(a5)
    6002:	02061593          	slli	a1,a2,0x20
    6006:	01c5d713          	srli	a4,a1,0x1c
    600a:	973e                	add	a4,a4,a5
    600c:	fae68ae3          	beq	a3,a4,5fc0 <free+0x22>
    p->s.ptr = bp->s.ptr;
    6010:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    6012:	00003717          	auipc	a4,0x3
    6016:	42f73f23          	sd	a5,1086(a4) # 9450 <freep>
}
    601a:	6422                	ld	s0,8(sp)
    601c:	0141                	addi	sp,sp,16
    601e:	8082                	ret

0000000000006020 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    6020:	7139                	addi	sp,sp,-64
    6022:	fc06                	sd	ra,56(sp)
    6024:	f822                	sd	s0,48(sp)
    6026:	f426                	sd	s1,40(sp)
    6028:	f04a                	sd	s2,32(sp)
    602a:	ec4e                	sd	s3,24(sp)
    602c:	e852                	sd	s4,16(sp)
    602e:	e456                	sd	s5,8(sp)
    6030:	e05a                	sd	s6,0(sp)
    6032:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    6034:	02051493          	slli	s1,a0,0x20
    6038:	9081                	srli	s1,s1,0x20
    603a:	04bd                	addi	s1,s1,15
    603c:	8091                	srli	s1,s1,0x4
    603e:	0014899b          	addiw	s3,s1,1
    6042:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    6044:	00003517          	auipc	a0,0x3
    6048:	40c53503          	ld	a0,1036(a0) # 9450 <freep>
    604c:	c515                	beqz	a0,6078 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    604e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6050:	4798                	lw	a4,8(a5)
    6052:	02977f63          	bgeu	a4,s1,6090 <malloc+0x70>
    6056:	8a4e                	mv	s4,s3
    6058:	0009871b          	sext.w	a4,s3
    605c:	6685                	lui	a3,0x1
    605e:	00d77363          	bgeu	a4,a3,6064 <malloc+0x44>
    6062:	6a05                	lui	s4,0x1
    6064:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    6068:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    606c:	00003917          	auipc	s2,0x3
    6070:	3e490913          	addi	s2,s2,996 # 9450 <freep>
  if(p == (char*)-1)
    6074:	5afd                	li	s5,-1
    6076:	a895                	j	60ea <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    6078:	0000a797          	auipc	a5,0xa
    607c:	c0078793          	addi	a5,a5,-1024 # fc78 <base>
    6080:	00003717          	auipc	a4,0x3
    6084:	3cf73823          	sd	a5,976(a4) # 9450 <freep>
    6088:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    608a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    608e:	b7e1                	j	6056 <malloc+0x36>
      if(p->s.size == nunits)
    6090:	02e48c63          	beq	s1,a4,60c8 <malloc+0xa8>
        p->s.size -= nunits;
    6094:	4137073b          	subw	a4,a4,s3
    6098:	c798                	sw	a4,8(a5)
        p += p->s.size;
    609a:	02071693          	slli	a3,a4,0x20
    609e:	01c6d713          	srli	a4,a3,0x1c
    60a2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    60a4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    60a8:	00003717          	auipc	a4,0x3
    60ac:	3aa73423          	sd	a0,936(a4) # 9450 <freep>
      return (void*)(p + 1);
    60b0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    60b4:	70e2                	ld	ra,56(sp)
    60b6:	7442                	ld	s0,48(sp)
    60b8:	74a2                	ld	s1,40(sp)
    60ba:	7902                	ld	s2,32(sp)
    60bc:	69e2                	ld	s3,24(sp)
    60be:	6a42                	ld	s4,16(sp)
    60c0:	6aa2                	ld	s5,8(sp)
    60c2:	6b02                	ld	s6,0(sp)
    60c4:	6121                	addi	sp,sp,64
    60c6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    60c8:	6398                	ld	a4,0(a5)
    60ca:	e118                	sd	a4,0(a0)
    60cc:	bff1                	j	60a8 <malloc+0x88>
  hp->s.size = nu;
    60ce:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    60d2:	0541                	addi	a0,a0,16
    60d4:	00000097          	auipc	ra,0x0
    60d8:	eca080e7          	jalr	-310(ra) # 5f9e <free>
  return freep;
    60dc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    60e0:	d971                	beqz	a0,60b4 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60e2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60e4:	4798                	lw	a4,8(a5)
    60e6:	fa9775e3          	bgeu	a4,s1,6090 <malloc+0x70>
    if(p == freep)
    60ea:	00093703          	ld	a4,0(s2)
    60ee:	853e                	mv	a0,a5
    60f0:	fef719e3          	bne	a4,a5,60e2 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    60f4:	8552                	mv	a0,s4
    60f6:	00000097          	auipc	ra,0x0
    60fa:	b80080e7          	jalr	-1152(ra) # 5c76 <sbrk>
  if(p == (char*)-1)
    60fe:	fd5518e3          	bne	a0,s5,60ce <malloc+0xae>
        return 0;
    6102:	4501                	li	a0,0
    6104:	bf45                	j	60b4 <malloc+0x94>
