
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	8d013103          	ld	sp,-1840(sp) # 800088d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	722050ef          	jal	ra,80005738 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00022797          	auipc	a5,0x22
    80000034:	d6078793          	addi	a5,a5,-672 # 80021d90 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	8d090913          	addi	s2,s2,-1840 # 80008920 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	0ca080e7          	jalr	202(ra) # 80006124 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	16a080e7          	jalr	362(ra) # 800061d8 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	b62080e7          	jalr	-1182(ra) # 80005bec <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	00e504b3          	add	s1,a0,a4
    800000ac:	777d                	lui	a4,0xfffff
    800000ae:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94be                	add	s1,s1,a5
    800000b2:	0095ee63          	bltu	a1,s1,800000ce <freerange+0x3c>
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
}
    800000ce:	70a2                	ld	ra,40(sp)
    800000d0:	7402                	ld	s0,32(sp)
    800000d2:	64e2                	ld	s1,24(sp)
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f3258593          	addi	a1,a1,-206 # 80008018 <etext+0x18>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	83250513          	addi	a0,a0,-1998 # 80008920 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	f9e080e7          	jalr	-98(ra) # 80006094 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00022517          	auipc	a0,0x22
    80000106:	c8e50513          	addi	a0,a0,-882 # 80021d90 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	00008497          	auipc	s1,0x8
    80000128:	7fc48493          	addi	s1,s1,2044 # 80008920 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	ff6080e7          	jalr	-10(ra) # 80006124 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	00008517          	auipc	a0,0x8
    80000140:	7e450513          	addi	a0,a0,2020 # 80008920 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	092080e7          	jalr	146(ra) # 800061d8 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	00008517          	auipc	a0,0x8
    8000016c:	7b850513          	addi	a0,a0,1976 # 80008920 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	068080e7          	jalr	104(ra) # 800061d8 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	addi	sp,sp,-16
    8000017c:	e422                	sd	s0,8(sp)
    8000017e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000180:	ca19                	beqz	a2,80000196 <memset+0x1c>
    80000182:	87aa                	mv	a5,a0
    80000184:	1602                	slli	a2,a2,0x20
    80000186:	9201                	srli	a2,a2,0x20
    80000188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000190:	0785                	addi	a5,a5,1
    80000192:	fee79de3          	bne	a5,a4,8000018c <memset+0x12>
  }
  return dst;
}
    80000196:	6422                	ld	s0,8(sp)
    80000198:	0141                	addi	sp,sp,16
    8000019a:	8082                	ret

000000008000019c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019c:	1141                	addi	sp,sp,-16
    8000019e:	e422                	sd	s0,8(sp)
    800001a0:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a2:	ca05                	beqz	a2,800001d2 <memcmp+0x36>
    800001a4:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001a8:	1682                	slli	a3,a3,0x20
    800001aa:	9281                	srli	a3,a3,0x20
    800001ac:	0685                	addi	a3,a3,1
    800001ae:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b0:	00054783          	lbu	a5,0(a0)
    800001b4:	0005c703          	lbu	a4,0(a1)
    800001b8:	00e79863          	bne	a5,a4,800001c8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001bc:	0505                	addi	a0,a0,1
    800001be:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c0:	fed518e3          	bne	a0,a3,800001b0 <memcmp+0x14>
  }

  return 0;
    800001c4:	4501                	li	a0,0
    800001c6:	a019                	j	800001cc <memcmp+0x30>
      return *s1 - *s2;
    800001c8:	40e7853b          	subw	a0,a5,a4
}
    800001cc:	6422                	ld	s0,8(sp)
    800001ce:	0141                	addi	sp,sp,16
    800001d0:	8082                	ret
  return 0;
    800001d2:	4501                	li	a0,0
    800001d4:	bfe5                	j	800001cc <memcmp+0x30>

00000000800001d6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d6:	1141                	addi	sp,sp,-16
    800001d8:	e422                	sd	s0,8(sp)
    800001da:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001dc:	c205                	beqz	a2,800001fc <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001de:	02a5e263          	bltu	a1,a0,80000202 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001e2:	1602                	slli	a2,a2,0x20
    800001e4:	9201                	srli	a2,a2,0x20
    800001e6:	00c587b3          	add	a5,a1,a2
{
    800001ea:	872a                	mv	a4,a0
      *d++ = *s++;
    800001ec:	0585                	addi	a1,a1,1
    800001ee:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdd271>
    800001f0:	fff5c683          	lbu	a3,-1(a1)
    800001f4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001f8:	fef59ae3          	bne	a1,a5,800001ec <memmove+0x16>

  return dst;
}
    800001fc:	6422                	ld	s0,8(sp)
    800001fe:	0141                	addi	sp,sp,16
    80000200:	8082                	ret
  if(s < d && s + n > d){
    80000202:	02061693          	slli	a3,a2,0x20
    80000206:	9281                	srli	a3,a3,0x20
    80000208:	00d58733          	add	a4,a1,a3
    8000020c:	fce57be3          	bgeu	a0,a4,800001e2 <memmove+0xc>
    d += n;
    80000210:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000212:	fff6079b          	addiw	a5,a2,-1
    80000216:	1782                	slli	a5,a5,0x20
    80000218:	9381                	srli	a5,a5,0x20
    8000021a:	fff7c793          	not	a5,a5
    8000021e:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000220:	177d                	addi	a4,a4,-1
    80000222:	16fd                	addi	a3,a3,-1
    80000224:	00074603          	lbu	a2,0(a4)
    80000228:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000022c:	fee79ae3          	bne	a5,a4,80000220 <memmove+0x4a>
    80000230:	b7f1                	j	800001fc <memmove+0x26>

0000000080000232 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000232:	1141                	addi	sp,sp,-16
    80000234:	e406                	sd	ra,8(sp)
    80000236:	e022                	sd	s0,0(sp)
    80000238:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000023a:	00000097          	auipc	ra,0x0
    8000023e:	f9c080e7          	jalr	-100(ra) # 800001d6 <memmove>
}
    80000242:	60a2                	ld	ra,8(sp)
    80000244:	6402                	ld	s0,0(sp)
    80000246:	0141                	addi	sp,sp,16
    80000248:	8082                	ret

000000008000024a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000024a:	1141                	addi	sp,sp,-16
    8000024c:	e422                	sd	s0,8(sp)
    8000024e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000250:	ce11                	beqz	a2,8000026c <strncmp+0x22>
    80000252:	00054783          	lbu	a5,0(a0)
    80000256:	cf89                	beqz	a5,80000270 <strncmp+0x26>
    80000258:	0005c703          	lbu	a4,0(a1)
    8000025c:	00f71a63          	bne	a4,a5,80000270 <strncmp+0x26>
    n--, p++, q++;
    80000260:	367d                	addiw	a2,a2,-1
    80000262:	0505                	addi	a0,a0,1
    80000264:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000266:	f675                	bnez	a2,80000252 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000268:	4501                	li	a0,0
    8000026a:	a809                	j	8000027c <strncmp+0x32>
    8000026c:	4501                	li	a0,0
    8000026e:	a039                	j	8000027c <strncmp+0x32>
  if(n == 0)
    80000270:	ca09                	beqz	a2,80000282 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000272:	00054503          	lbu	a0,0(a0)
    80000276:	0005c783          	lbu	a5,0(a1)
    8000027a:	9d1d                	subw	a0,a0,a5
}
    8000027c:	6422                	ld	s0,8(sp)
    8000027e:	0141                	addi	sp,sp,16
    80000280:	8082                	ret
    return 0;
    80000282:	4501                	li	a0,0
    80000284:	bfe5                	j	8000027c <strncmp+0x32>

0000000080000286 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000286:	1141                	addi	sp,sp,-16
    80000288:	e422                	sd	s0,8(sp)
    8000028a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000028c:	872a                	mv	a4,a0
    8000028e:	8832                	mv	a6,a2
    80000290:	367d                	addiw	a2,a2,-1
    80000292:	01005963          	blez	a6,800002a4 <strncpy+0x1e>
    80000296:	0705                	addi	a4,a4,1
    80000298:	0005c783          	lbu	a5,0(a1)
    8000029c:	fef70fa3          	sb	a5,-1(a4)
    800002a0:	0585                	addi	a1,a1,1
    800002a2:	f7f5                	bnez	a5,8000028e <strncpy+0x8>
    ;
  while(n-- > 0)
    800002a4:	86ba                	mv	a3,a4
    800002a6:	00c05c63          	blez	a2,800002be <strncpy+0x38>
    *s++ = 0;
    800002aa:	0685                	addi	a3,a3,1
    800002ac:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b0:	40d707bb          	subw	a5,a4,a3
    800002b4:	37fd                	addiw	a5,a5,-1
    800002b6:	010787bb          	addw	a5,a5,a6
    800002ba:	fef048e3          	bgtz	a5,800002aa <strncpy+0x24>
  return os;
}
    800002be:	6422                	ld	s0,8(sp)
    800002c0:	0141                	addi	sp,sp,16
    800002c2:	8082                	ret

00000000800002c4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002c4:	1141                	addi	sp,sp,-16
    800002c6:	e422                	sd	s0,8(sp)
    800002c8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002ca:	02c05363          	blez	a2,800002f0 <safestrcpy+0x2c>
    800002ce:	fff6069b          	addiw	a3,a2,-1
    800002d2:	1682                	slli	a3,a3,0x20
    800002d4:	9281                	srli	a3,a3,0x20
    800002d6:	96ae                	add	a3,a3,a1
    800002d8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002da:	00d58963          	beq	a1,a3,800002ec <safestrcpy+0x28>
    800002de:	0585                	addi	a1,a1,1
    800002e0:	0785                	addi	a5,a5,1
    800002e2:	fff5c703          	lbu	a4,-1(a1)
    800002e6:	fee78fa3          	sb	a4,-1(a5)
    800002ea:	fb65                	bnez	a4,800002da <safestrcpy+0x16>
    ;
  *s = 0;
    800002ec:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f0:	6422                	ld	s0,8(sp)
    800002f2:	0141                	addi	sp,sp,16
    800002f4:	8082                	ret

00000000800002f6 <strlen>:

int
strlen(const char *s)
{
    800002f6:	1141                	addi	sp,sp,-16
    800002f8:	e422                	sd	s0,8(sp)
    800002fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002fc:	00054783          	lbu	a5,0(a0)
    80000300:	cf91                	beqz	a5,8000031c <strlen+0x26>
    80000302:	0505                	addi	a0,a0,1
    80000304:	87aa                	mv	a5,a0
    80000306:	4685                	li	a3,1
    80000308:	9e89                	subw	a3,a3,a0
    8000030a:	00f6853b          	addw	a0,a3,a5
    8000030e:	0785                	addi	a5,a5,1
    80000310:	fff7c703          	lbu	a4,-1(a5)
    80000314:	fb7d                	bnez	a4,8000030a <strlen+0x14>
    ;
  return n;
}
    80000316:	6422                	ld	s0,8(sp)
    80000318:	0141                	addi	sp,sp,16
    8000031a:	8082                	ret
  for(n = 0; s[n]; n++)
    8000031c:	4501                	li	a0,0
    8000031e:	bfe5                	j	80000316 <strlen+0x20>

0000000080000320 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000320:	1141                	addi	sp,sp,-16
    80000322:	e406                	sd	ra,8(sp)
    80000324:	e022                	sd	s0,0(sp)
    80000326:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000328:	00001097          	auipc	ra,0x1
    8000032c:	b58080e7          	jalr	-1192(ra) # 80000e80 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000330:	00008717          	auipc	a4,0x8
    80000334:	5c070713          	addi	a4,a4,1472 # 800088f0 <started>
  if(cpuid() == 0){
    80000338:	c139                	beqz	a0,8000037e <main+0x5e>
    while(started == 0)
    8000033a:	431c                	lw	a5,0(a4)
    8000033c:	2781                	sext.w	a5,a5
    8000033e:	dff5                	beqz	a5,8000033a <main+0x1a>
      ;
    __sync_synchronize();
    80000340:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000344:	00001097          	auipc	ra,0x1
    80000348:	b3c080e7          	jalr	-1220(ra) # 80000e80 <cpuid>
    8000034c:	85aa                	mv	a1,a0
    8000034e:	00008517          	auipc	a0,0x8
    80000352:	cea50513          	addi	a0,a0,-790 # 80008038 <etext+0x38>
    80000356:	00006097          	auipc	ra,0x6
    8000035a:	8e0080e7          	jalr	-1824(ra) # 80005c36 <printf>
    kvminithart();    // turn on paging
    8000035e:	00000097          	auipc	ra,0x0
    80000362:	0d8080e7          	jalr	216(ra) # 80000436 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000366:	00001097          	auipc	ra,0x1
    8000036a:	7e8080e7          	jalr	2024(ra) # 80001b4e <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000036e:	00005097          	auipc	ra,0x5
    80000372:	d82080e7          	jalr	-638(ra) # 800050f0 <plicinithart>
  }

  scheduler();        
    80000376:	00001097          	auipc	ra,0x1
    8000037a:	030080e7          	jalr	48(ra) # 800013a6 <scheduler>
    consoleinit();
    8000037e:	00005097          	auipc	ra,0x5
    80000382:	77e080e7          	jalr	1918(ra) # 80005afc <consoleinit>
    printfinit();
    80000386:	00006097          	auipc	ra,0x6
    8000038a:	a90080e7          	jalr	-1392(ra) # 80005e16 <printfinit>
    printf("\n");
    8000038e:	00008517          	auipc	a0,0x8
    80000392:	cba50513          	addi	a0,a0,-838 # 80008048 <etext+0x48>
    80000396:	00006097          	auipc	ra,0x6
    8000039a:	8a0080e7          	jalr	-1888(ra) # 80005c36 <printf>
    printf("xv6 kernel is booting\n");
    8000039e:	00008517          	auipc	a0,0x8
    800003a2:	c8250513          	addi	a0,a0,-894 # 80008020 <etext+0x20>
    800003a6:	00006097          	auipc	ra,0x6
    800003aa:	890080e7          	jalr	-1904(ra) # 80005c36 <printf>
    printf("\n");
    800003ae:	00008517          	auipc	a0,0x8
    800003b2:	c9a50513          	addi	a0,a0,-870 # 80008048 <etext+0x48>
    800003b6:	00006097          	auipc	ra,0x6
    800003ba:	880080e7          	jalr	-1920(ra) # 80005c36 <printf>
    kinit();         // physical page allocator
    800003be:	00000097          	auipc	ra,0x0
    800003c2:	d20080e7          	jalr	-736(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003c6:	00000097          	auipc	ra,0x0
    800003ca:	34a080e7          	jalr	842(ra) # 80000710 <kvminit>
    kvminithart();   // turn on paging
    800003ce:	00000097          	auipc	ra,0x0
    800003d2:	068080e7          	jalr	104(ra) # 80000436 <kvminithart>
    procinit();      // process table
    800003d6:	00001097          	auipc	ra,0x1
    800003da:	9f6080e7          	jalr	-1546(ra) # 80000dcc <procinit>
    trapinit();      // trap vectors
    800003de:	00001097          	auipc	ra,0x1
    800003e2:	748080e7          	jalr	1864(ra) # 80001b26 <trapinit>
    trapinithart();  // install kernel trap vector
    800003e6:	00001097          	auipc	ra,0x1
    800003ea:	768080e7          	jalr	1896(ra) # 80001b4e <trapinithart>
    plicinit();      // set up interrupt controller
    800003ee:	00005097          	auipc	ra,0x5
    800003f2:	cec080e7          	jalr	-788(ra) # 800050da <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003f6:	00005097          	auipc	ra,0x5
    800003fa:	cfa080e7          	jalr	-774(ra) # 800050f0 <plicinithart>
    binit();         // buffer cache
    800003fe:	00002097          	auipc	ra,0x2
    80000402:	e9a080e7          	jalr	-358(ra) # 80002298 <binit>
    iinit();         // inode table
    80000406:	00002097          	auipc	ra,0x2
    8000040a:	53a080e7          	jalr	1338(ra) # 80002940 <iinit>
    fileinit();      // file table
    8000040e:	00003097          	auipc	ra,0x3
    80000412:	4e0080e7          	jalr	1248(ra) # 800038ee <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000416:	00005097          	auipc	ra,0x5
    8000041a:	de2080e7          	jalr	-542(ra) # 800051f8 <virtio_disk_init>
    userinit();      // first user process
    8000041e:	00001097          	auipc	ra,0x1
    80000422:	d6a080e7          	jalr	-662(ra) # 80001188 <userinit>
    __sync_synchronize();
    80000426:	0ff0000f          	fence
    started = 1;
    8000042a:	4785                	li	a5,1
    8000042c:	00008717          	auipc	a4,0x8
    80000430:	4cf72223          	sw	a5,1220(a4) # 800088f0 <started>
    80000434:	b789                	j	80000376 <main+0x56>

0000000080000436 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000436:	1141                	addi	sp,sp,-16
    80000438:	e422                	sd	s0,8(sp)
    8000043a:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    8000043c:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000440:	00008797          	auipc	a5,0x8
    80000444:	4b87b783          	ld	a5,1208(a5) # 800088f8 <kernel_pagetable>
    80000448:	83b1                	srli	a5,a5,0xc
    8000044a:	577d                	li	a4,-1
    8000044c:	177e                	slli	a4,a4,0x3f
    8000044e:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000450:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000454:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000458:	6422                	ld	s0,8(sp)
    8000045a:	0141                	addi	sp,sp,16
    8000045c:	8082                	ret

000000008000045e <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000045e:	7139                	addi	sp,sp,-64
    80000460:	fc06                	sd	ra,56(sp)
    80000462:	f822                	sd	s0,48(sp)
    80000464:	f426                	sd	s1,40(sp)
    80000466:	f04a                	sd	s2,32(sp)
    80000468:	ec4e                	sd	s3,24(sp)
    8000046a:	e852                	sd	s4,16(sp)
    8000046c:	e456                	sd	s5,8(sp)
    8000046e:	e05a                	sd	s6,0(sp)
    80000470:	0080                	addi	s0,sp,64
    80000472:	84aa                	mv	s1,a0
    80000474:	89ae                	mv	s3,a1
    80000476:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000478:	57fd                	li	a5,-1
    8000047a:	83e9                	srli	a5,a5,0x1a
    8000047c:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000047e:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000480:	04b7f263          	bgeu	a5,a1,800004c4 <walk+0x66>
    panic("walk");
    80000484:	00008517          	auipc	a0,0x8
    80000488:	bcc50513          	addi	a0,a0,-1076 # 80008050 <etext+0x50>
    8000048c:	00005097          	auipc	ra,0x5
    80000490:	760080e7          	jalr	1888(ra) # 80005bec <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000494:	060a8663          	beqz	s5,80000500 <walk+0xa2>
    80000498:	00000097          	auipc	ra,0x0
    8000049c:	c82080e7          	jalr	-894(ra) # 8000011a <kalloc>
    800004a0:	84aa                	mv	s1,a0
    800004a2:	c529                	beqz	a0,800004ec <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004a4:	6605                	lui	a2,0x1
    800004a6:	4581                	li	a1,0
    800004a8:	00000097          	auipc	ra,0x0
    800004ac:	cd2080e7          	jalr	-814(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b0:	00c4d793          	srli	a5,s1,0xc
    800004b4:	07aa                	slli	a5,a5,0xa
    800004b6:	0017e793          	ori	a5,a5,1
    800004ba:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004be:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffdd267>
    800004c0:	036a0063          	beq	s4,s6,800004e0 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004c4:	0149d933          	srl	s2,s3,s4
    800004c8:	1ff97913          	andi	s2,s2,511
    800004cc:	090e                	slli	s2,s2,0x3
    800004ce:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004d0:	00093483          	ld	s1,0(s2)
    800004d4:	0014f793          	andi	a5,s1,1
    800004d8:	dfd5                	beqz	a5,80000494 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004da:	80a9                	srli	s1,s1,0xa
    800004dc:	04b2                	slli	s1,s1,0xc
    800004de:	b7c5                	j	800004be <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004e0:	00c9d513          	srli	a0,s3,0xc
    800004e4:	1ff57513          	andi	a0,a0,511
    800004e8:	050e                	slli	a0,a0,0x3
    800004ea:	9526                	add	a0,a0,s1
}
    800004ec:	70e2                	ld	ra,56(sp)
    800004ee:	7442                	ld	s0,48(sp)
    800004f0:	74a2                	ld	s1,40(sp)
    800004f2:	7902                	ld	s2,32(sp)
    800004f4:	69e2                	ld	s3,24(sp)
    800004f6:	6a42                	ld	s4,16(sp)
    800004f8:	6aa2                	ld	s5,8(sp)
    800004fa:	6b02                	ld	s6,0(sp)
    800004fc:	6121                	addi	sp,sp,64
    800004fe:	8082                	ret
        return 0;
    80000500:	4501                	li	a0,0
    80000502:	b7ed                	j	800004ec <walk+0x8e>

0000000080000504 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000504:	57fd                	li	a5,-1
    80000506:	83e9                	srli	a5,a5,0x1a
    80000508:	00b7f463          	bgeu	a5,a1,80000510 <walkaddr+0xc>
    return 0;
    8000050c:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000050e:	8082                	ret
{
    80000510:	1141                	addi	sp,sp,-16
    80000512:	e406                	sd	ra,8(sp)
    80000514:	e022                	sd	s0,0(sp)
    80000516:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000518:	4601                	li	a2,0
    8000051a:	00000097          	auipc	ra,0x0
    8000051e:	f44080e7          	jalr	-188(ra) # 8000045e <walk>
  if(pte == 0)
    80000522:	c105                	beqz	a0,80000542 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000524:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000526:	0117f693          	andi	a3,a5,17
    8000052a:	4745                	li	a4,17
    return 0;
    8000052c:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000052e:	00e68663          	beq	a3,a4,8000053a <walkaddr+0x36>
}
    80000532:	60a2                	ld	ra,8(sp)
    80000534:	6402                	ld	s0,0(sp)
    80000536:	0141                	addi	sp,sp,16
    80000538:	8082                	ret
  pa = PTE2PA(*pte);
    8000053a:	83a9                	srli	a5,a5,0xa
    8000053c:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000540:	bfcd                	j	80000532 <walkaddr+0x2e>
    return 0;
    80000542:	4501                	li	a0,0
    80000544:	b7fd                	j	80000532 <walkaddr+0x2e>

0000000080000546 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000546:	715d                	addi	sp,sp,-80
    80000548:	e486                	sd	ra,72(sp)
    8000054a:	e0a2                	sd	s0,64(sp)
    8000054c:	fc26                	sd	s1,56(sp)
    8000054e:	f84a                	sd	s2,48(sp)
    80000550:	f44e                	sd	s3,40(sp)
    80000552:	f052                	sd	s4,32(sp)
    80000554:	ec56                	sd	s5,24(sp)
    80000556:	e85a                	sd	s6,16(sp)
    80000558:	e45e                	sd	s7,8(sp)
    8000055a:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000055c:	03459793          	slli	a5,a1,0x34
    80000560:	e7b9                	bnez	a5,800005ae <mappages+0x68>
    80000562:	8aaa                	mv	s5,a0
    80000564:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    80000566:	03461793          	slli	a5,a2,0x34
    8000056a:	ebb1                	bnez	a5,800005be <mappages+0x78>
    panic("mappages: size not aligned");

  if(size == 0)
    8000056c:	c22d                	beqz	a2,800005ce <mappages+0x88>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    8000056e:	77fd                	lui	a5,0xfffff
    80000570:	963e                	add	a2,a2,a5
    80000572:	00b609b3          	add	s3,a2,a1
  a = va;
    80000576:	892e                	mv	s2,a1
    80000578:	40b68a33          	sub	s4,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000057c:	6b85                	lui	s7,0x1
    8000057e:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000582:	4605                	li	a2,1
    80000584:	85ca                	mv	a1,s2
    80000586:	8556                	mv	a0,s5
    80000588:	00000097          	auipc	ra,0x0
    8000058c:	ed6080e7          	jalr	-298(ra) # 8000045e <walk>
    80000590:	cd39                	beqz	a0,800005ee <mappages+0xa8>
    if(*pte & PTE_V)
    80000592:	611c                	ld	a5,0(a0)
    80000594:	8b85                	andi	a5,a5,1
    80000596:	e7a1                	bnez	a5,800005de <mappages+0x98>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000598:	80b1                	srli	s1,s1,0xc
    8000059a:	04aa                	slli	s1,s1,0xa
    8000059c:	0164e4b3          	or	s1,s1,s6
    800005a0:	0014e493          	ori	s1,s1,1
    800005a4:	e104                	sd	s1,0(a0)
    if(a == last)
    800005a6:	07390063          	beq	s2,s3,80000606 <mappages+0xc0>
    a += PGSIZE;
    800005aa:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005ac:	bfc9                	j	8000057e <mappages+0x38>
    panic("mappages: va not aligned");
    800005ae:	00008517          	auipc	a0,0x8
    800005b2:	aaa50513          	addi	a0,a0,-1366 # 80008058 <etext+0x58>
    800005b6:	00005097          	auipc	ra,0x5
    800005ba:	636080e7          	jalr	1590(ra) # 80005bec <panic>
    panic("mappages: size not aligned");
    800005be:	00008517          	auipc	a0,0x8
    800005c2:	aba50513          	addi	a0,a0,-1350 # 80008078 <etext+0x78>
    800005c6:	00005097          	auipc	ra,0x5
    800005ca:	626080e7          	jalr	1574(ra) # 80005bec <panic>
    panic("mappages: size");
    800005ce:	00008517          	auipc	a0,0x8
    800005d2:	aca50513          	addi	a0,a0,-1334 # 80008098 <etext+0x98>
    800005d6:	00005097          	auipc	ra,0x5
    800005da:	616080e7          	jalr	1558(ra) # 80005bec <panic>
      panic("mappages: remap");
    800005de:	00008517          	auipc	a0,0x8
    800005e2:	aca50513          	addi	a0,a0,-1334 # 800080a8 <etext+0xa8>
    800005e6:	00005097          	auipc	ra,0x5
    800005ea:	606080e7          	jalr	1542(ra) # 80005bec <panic>
      return -1;
    800005ee:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005f0:	60a6                	ld	ra,72(sp)
    800005f2:	6406                	ld	s0,64(sp)
    800005f4:	74e2                	ld	s1,56(sp)
    800005f6:	7942                	ld	s2,48(sp)
    800005f8:	79a2                	ld	s3,40(sp)
    800005fa:	7a02                	ld	s4,32(sp)
    800005fc:	6ae2                	ld	s5,24(sp)
    800005fe:	6b42                	ld	s6,16(sp)
    80000600:	6ba2                	ld	s7,8(sp)
    80000602:	6161                	addi	sp,sp,80
    80000604:	8082                	ret
  return 0;
    80000606:	4501                	li	a0,0
    80000608:	b7e5                	j	800005f0 <mappages+0xaa>

000000008000060a <kvmmap>:
{
    8000060a:	1141                	addi	sp,sp,-16
    8000060c:	e406                	sd	ra,8(sp)
    8000060e:	e022                	sd	s0,0(sp)
    80000610:	0800                	addi	s0,sp,16
    80000612:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000614:	86b2                	mv	a3,a2
    80000616:	863e                	mv	a2,a5
    80000618:	00000097          	auipc	ra,0x0
    8000061c:	f2e080e7          	jalr	-210(ra) # 80000546 <mappages>
    80000620:	e509                	bnez	a0,8000062a <kvmmap+0x20>
}
    80000622:	60a2                	ld	ra,8(sp)
    80000624:	6402                	ld	s0,0(sp)
    80000626:	0141                	addi	sp,sp,16
    80000628:	8082                	ret
    panic("kvmmap");
    8000062a:	00008517          	auipc	a0,0x8
    8000062e:	a8e50513          	addi	a0,a0,-1394 # 800080b8 <etext+0xb8>
    80000632:	00005097          	auipc	ra,0x5
    80000636:	5ba080e7          	jalr	1466(ra) # 80005bec <panic>

000000008000063a <kvmmake>:
{
    8000063a:	1101                	addi	sp,sp,-32
    8000063c:	ec06                	sd	ra,24(sp)
    8000063e:	e822                	sd	s0,16(sp)
    80000640:	e426                	sd	s1,8(sp)
    80000642:	e04a                	sd	s2,0(sp)
    80000644:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000646:	00000097          	auipc	ra,0x0
    8000064a:	ad4080e7          	jalr	-1324(ra) # 8000011a <kalloc>
    8000064e:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000650:	6605                	lui	a2,0x1
    80000652:	4581                	li	a1,0
    80000654:	00000097          	auipc	ra,0x0
    80000658:	b26080e7          	jalr	-1242(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000065c:	4719                	li	a4,6
    8000065e:	6685                	lui	a3,0x1
    80000660:	10000637          	lui	a2,0x10000
    80000664:	100005b7          	lui	a1,0x10000
    80000668:	8526                	mv	a0,s1
    8000066a:	00000097          	auipc	ra,0x0
    8000066e:	fa0080e7          	jalr	-96(ra) # 8000060a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000672:	4719                	li	a4,6
    80000674:	6685                	lui	a3,0x1
    80000676:	10001637          	lui	a2,0x10001
    8000067a:	100015b7          	lui	a1,0x10001
    8000067e:	8526                	mv	a0,s1
    80000680:	00000097          	auipc	ra,0x0
    80000684:	f8a080e7          	jalr	-118(ra) # 8000060a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000688:	4719                	li	a4,6
    8000068a:	004006b7          	lui	a3,0x400
    8000068e:	0c000637          	lui	a2,0xc000
    80000692:	0c0005b7          	lui	a1,0xc000
    80000696:	8526                	mv	a0,s1
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	f72080e7          	jalr	-142(ra) # 8000060a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800006a0:	00008917          	auipc	s2,0x8
    800006a4:	96090913          	addi	s2,s2,-1696 # 80008000 <etext>
    800006a8:	4729                	li	a4,10
    800006aa:	80008697          	auipc	a3,0x80008
    800006ae:	95668693          	addi	a3,a3,-1706 # 8000 <_entry-0x7fff8000>
    800006b2:	4605                	li	a2,1
    800006b4:	067e                	slli	a2,a2,0x1f
    800006b6:	85b2                	mv	a1,a2
    800006b8:	8526                	mv	a0,s1
    800006ba:	00000097          	auipc	ra,0x0
    800006be:	f50080e7          	jalr	-176(ra) # 8000060a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006c2:	4719                	li	a4,6
    800006c4:	46c5                	li	a3,17
    800006c6:	06ee                	slli	a3,a3,0x1b
    800006c8:	412686b3          	sub	a3,a3,s2
    800006cc:	864a                	mv	a2,s2
    800006ce:	85ca                	mv	a1,s2
    800006d0:	8526                	mv	a0,s1
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	f38080e7          	jalr	-200(ra) # 8000060a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006da:	4729                	li	a4,10
    800006dc:	6685                	lui	a3,0x1
    800006de:	00007617          	auipc	a2,0x7
    800006e2:	92260613          	addi	a2,a2,-1758 # 80007000 <_trampoline>
    800006e6:	040005b7          	lui	a1,0x4000
    800006ea:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006ec:	05b2                	slli	a1,a1,0xc
    800006ee:	8526                	mv	a0,s1
    800006f0:	00000097          	auipc	ra,0x0
    800006f4:	f1a080e7          	jalr	-230(ra) # 8000060a <kvmmap>
  proc_mapstacks(kpgtbl);
    800006f8:	8526                	mv	a0,s1
    800006fa:	00000097          	auipc	ra,0x0
    800006fe:	63c080e7          	jalr	1596(ra) # 80000d36 <proc_mapstacks>
}
    80000702:	8526                	mv	a0,s1
    80000704:	60e2                	ld	ra,24(sp)
    80000706:	6442                	ld	s0,16(sp)
    80000708:	64a2                	ld	s1,8(sp)
    8000070a:	6902                	ld	s2,0(sp)
    8000070c:	6105                	addi	sp,sp,32
    8000070e:	8082                	ret

0000000080000710 <kvminit>:
{
    80000710:	1141                	addi	sp,sp,-16
    80000712:	e406                	sd	ra,8(sp)
    80000714:	e022                	sd	s0,0(sp)
    80000716:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000718:	00000097          	auipc	ra,0x0
    8000071c:	f22080e7          	jalr	-222(ra) # 8000063a <kvmmake>
    80000720:	00008797          	auipc	a5,0x8
    80000724:	1ca7bc23          	sd	a0,472(a5) # 800088f8 <kernel_pagetable>
}
    80000728:	60a2                	ld	ra,8(sp)
    8000072a:	6402                	ld	s0,0(sp)
    8000072c:	0141                	addi	sp,sp,16
    8000072e:	8082                	ret

0000000080000730 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000730:	715d                	addi	sp,sp,-80
    80000732:	e486                	sd	ra,72(sp)
    80000734:	e0a2                	sd	s0,64(sp)
    80000736:	fc26                	sd	s1,56(sp)
    80000738:	f84a                	sd	s2,48(sp)
    8000073a:	f44e                	sd	s3,40(sp)
    8000073c:	f052                	sd	s4,32(sp)
    8000073e:	ec56                	sd	s5,24(sp)
    80000740:	e85a                	sd	s6,16(sp)
    80000742:	e45e                	sd	s7,8(sp)
    80000744:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000746:	03459793          	slli	a5,a1,0x34
    8000074a:	e795                	bnez	a5,80000776 <uvmunmap+0x46>
    8000074c:	8a2a                	mv	s4,a0
    8000074e:	892e                	mv	s2,a1
    80000750:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000752:	0632                	slli	a2,a2,0xc
    80000754:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000758:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000075a:	6b05                	lui	s6,0x1
    8000075c:	0735e263          	bltu	a1,s3,800007c0 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000760:	60a6                	ld	ra,72(sp)
    80000762:	6406                	ld	s0,64(sp)
    80000764:	74e2                	ld	s1,56(sp)
    80000766:	7942                	ld	s2,48(sp)
    80000768:	79a2                	ld	s3,40(sp)
    8000076a:	7a02                	ld	s4,32(sp)
    8000076c:	6ae2                	ld	s5,24(sp)
    8000076e:	6b42                	ld	s6,16(sp)
    80000770:	6ba2                	ld	s7,8(sp)
    80000772:	6161                	addi	sp,sp,80
    80000774:	8082                	ret
    panic("uvmunmap: not aligned");
    80000776:	00008517          	auipc	a0,0x8
    8000077a:	94a50513          	addi	a0,a0,-1718 # 800080c0 <etext+0xc0>
    8000077e:	00005097          	auipc	ra,0x5
    80000782:	46e080e7          	jalr	1134(ra) # 80005bec <panic>
      panic("uvmunmap: walk");
    80000786:	00008517          	auipc	a0,0x8
    8000078a:	95250513          	addi	a0,a0,-1710 # 800080d8 <etext+0xd8>
    8000078e:	00005097          	auipc	ra,0x5
    80000792:	45e080e7          	jalr	1118(ra) # 80005bec <panic>
      panic("uvmunmap: not mapped");
    80000796:	00008517          	auipc	a0,0x8
    8000079a:	95250513          	addi	a0,a0,-1710 # 800080e8 <etext+0xe8>
    8000079e:	00005097          	auipc	ra,0x5
    800007a2:	44e080e7          	jalr	1102(ra) # 80005bec <panic>
      panic("uvmunmap: not a leaf");
    800007a6:	00008517          	auipc	a0,0x8
    800007aa:	95a50513          	addi	a0,a0,-1702 # 80008100 <etext+0x100>
    800007ae:	00005097          	auipc	ra,0x5
    800007b2:	43e080e7          	jalr	1086(ra) # 80005bec <panic>
    *pte = 0;
    800007b6:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007ba:	995a                	add	s2,s2,s6
    800007bc:	fb3972e3          	bgeu	s2,s3,80000760 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007c0:	4601                	li	a2,0
    800007c2:	85ca                	mv	a1,s2
    800007c4:	8552                	mv	a0,s4
    800007c6:	00000097          	auipc	ra,0x0
    800007ca:	c98080e7          	jalr	-872(ra) # 8000045e <walk>
    800007ce:	84aa                	mv	s1,a0
    800007d0:	d95d                	beqz	a0,80000786 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007d2:	6108                	ld	a0,0(a0)
    800007d4:	00157793          	andi	a5,a0,1
    800007d8:	dfdd                	beqz	a5,80000796 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007da:	3ff57793          	andi	a5,a0,1023
    800007de:	fd7784e3          	beq	a5,s7,800007a6 <uvmunmap+0x76>
    if(do_free){
    800007e2:	fc0a8ae3          	beqz	s5,800007b6 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    800007e6:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007e8:	0532                	slli	a0,a0,0xc
    800007ea:	00000097          	auipc	ra,0x0
    800007ee:	832080e7          	jalr	-1998(ra) # 8000001c <kfree>
    800007f2:	b7d1                	j	800007b6 <uvmunmap+0x86>

00000000800007f4 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007f4:	1101                	addi	sp,sp,-32
    800007f6:	ec06                	sd	ra,24(sp)
    800007f8:	e822                	sd	s0,16(sp)
    800007fa:	e426                	sd	s1,8(sp)
    800007fc:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007fe:	00000097          	auipc	ra,0x0
    80000802:	91c080e7          	jalr	-1764(ra) # 8000011a <kalloc>
    80000806:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000808:	c519                	beqz	a0,80000816 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000080a:	6605                	lui	a2,0x1
    8000080c:	4581                	li	a1,0
    8000080e:	00000097          	auipc	ra,0x0
    80000812:	96c080e7          	jalr	-1684(ra) # 8000017a <memset>
  return pagetable;
}
    80000816:	8526                	mv	a0,s1
    80000818:	60e2                	ld	ra,24(sp)
    8000081a:	6442                	ld	s0,16(sp)
    8000081c:	64a2                	ld	s1,8(sp)
    8000081e:	6105                	addi	sp,sp,32
    80000820:	8082                	ret

0000000080000822 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000822:	7179                	addi	sp,sp,-48
    80000824:	f406                	sd	ra,40(sp)
    80000826:	f022                	sd	s0,32(sp)
    80000828:	ec26                	sd	s1,24(sp)
    8000082a:	e84a                	sd	s2,16(sp)
    8000082c:	e44e                	sd	s3,8(sp)
    8000082e:	e052                	sd	s4,0(sp)
    80000830:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000832:	6785                	lui	a5,0x1
    80000834:	04f67863          	bgeu	a2,a5,80000884 <uvmfirst+0x62>
    80000838:	8a2a                	mv	s4,a0
    8000083a:	89ae                	mv	s3,a1
    8000083c:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    8000083e:	00000097          	auipc	ra,0x0
    80000842:	8dc080e7          	jalr	-1828(ra) # 8000011a <kalloc>
    80000846:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000848:	6605                	lui	a2,0x1
    8000084a:	4581                	li	a1,0
    8000084c:	00000097          	auipc	ra,0x0
    80000850:	92e080e7          	jalr	-1746(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000854:	4779                	li	a4,30
    80000856:	86ca                	mv	a3,s2
    80000858:	6605                	lui	a2,0x1
    8000085a:	4581                	li	a1,0
    8000085c:	8552                	mv	a0,s4
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	ce8080e7          	jalr	-792(ra) # 80000546 <mappages>
  memmove(mem, src, sz);
    80000866:	8626                	mv	a2,s1
    80000868:	85ce                	mv	a1,s3
    8000086a:	854a                	mv	a0,s2
    8000086c:	00000097          	auipc	ra,0x0
    80000870:	96a080e7          	jalr	-1686(ra) # 800001d6 <memmove>
}
    80000874:	70a2                	ld	ra,40(sp)
    80000876:	7402                	ld	s0,32(sp)
    80000878:	64e2                	ld	s1,24(sp)
    8000087a:	6942                	ld	s2,16(sp)
    8000087c:	69a2                	ld	s3,8(sp)
    8000087e:	6a02                	ld	s4,0(sp)
    80000880:	6145                	addi	sp,sp,48
    80000882:	8082                	ret
    panic("uvmfirst: more than a page");
    80000884:	00008517          	auipc	a0,0x8
    80000888:	89450513          	addi	a0,a0,-1900 # 80008118 <etext+0x118>
    8000088c:	00005097          	auipc	ra,0x5
    80000890:	360080e7          	jalr	864(ra) # 80005bec <panic>

0000000080000894 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000894:	1101                	addi	sp,sp,-32
    80000896:	ec06                	sd	ra,24(sp)
    80000898:	e822                	sd	s0,16(sp)
    8000089a:	e426                	sd	s1,8(sp)
    8000089c:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000089e:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008a0:	00b67d63          	bgeu	a2,a1,800008ba <uvmdealloc+0x26>
    800008a4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008a6:	6785                	lui	a5,0x1
    800008a8:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008aa:	00f60733          	add	a4,a2,a5
    800008ae:	76fd                	lui	a3,0xfffff
    800008b0:	8f75                	and	a4,a4,a3
    800008b2:	97ae                	add	a5,a5,a1
    800008b4:	8ff5                	and	a5,a5,a3
    800008b6:	00f76863          	bltu	a4,a5,800008c6 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008ba:	8526                	mv	a0,s1
    800008bc:	60e2                	ld	ra,24(sp)
    800008be:	6442                	ld	s0,16(sp)
    800008c0:	64a2                	ld	s1,8(sp)
    800008c2:	6105                	addi	sp,sp,32
    800008c4:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008c6:	8f99                	sub	a5,a5,a4
    800008c8:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ca:	4685                	li	a3,1
    800008cc:	0007861b          	sext.w	a2,a5
    800008d0:	85ba                	mv	a1,a4
    800008d2:	00000097          	auipc	ra,0x0
    800008d6:	e5e080e7          	jalr	-418(ra) # 80000730 <uvmunmap>
    800008da:	b7c5                	j	800008ba <uvmdealloc+0x26>

00000000800008dc <uvmalloc>:
  if(newsz < oldsz)
    800008dc:	0ab66563          	bltu	a2,a1,80000986 <uvmalloc+0xaa>
{
    800008e0:	7139                	addi	sp,sp,-64
    800008e2:	fc06                	sd	ra,56(sp)
    800008e4:	f822                	sd	s0,48(sp)
    800008e6:	f426                	sd	s1,40(sp)
    800008e8:	f04a                	sd	s2,32(sp)
    800008ea:	ec4e                	sd	s3,24(sp)
    800008ec:	e852                	sd	s4,16(sp)
    800008ee:	e456                	sd	s5,8(sp)
    800008f0:	e05a                	sd	s6,0(sp)
    800008f2:	0080                	addi	s0,sp,64
    800008f4:	8aaa                	mv	s5,a0
    800008f6:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008f8:	6785                	lui	a5,0x1
    800008fa:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008fc:	95be                	add	a1,a1,a5
    800008fe:	77fd                	lui	a5,0xfffff
    80000900:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000904:	08c9f363          	bgeu	s3,a2,8000098a <uvmalloc+0xae>
    80000908:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000090a:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    8000090e:	00000097          	auipc	ra,0x0
    80000912:	80c080e7          	jalr	-2036(ra) # 8000011a <kalloc>
    80000916:	84aa                	mv	s1,a0
    if(mem == 0){
    80000918:	c51d                	beqz	a0,80000946 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    8000091a:	6605                	lui	a2,0x1
    8000091c:	4581                	li	a1,0
    8000091e:	00000097          	auipc	ra,0x0
    80000922:	85c080e7          	jalr	-1956(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000926:	875a                	mv	a4,s6
    80000928:	86a6                	mv	a3,s1
    8000092a:	6605                	lui	a2,0x1
    8000092c:	85ca                	mv	a1,s2
    8000092e:	8556                	mv	a0,s5
    80000930:	00000097          	auipc	ra,0x0
    80000934:	c16080e7          	jalr	-1002(ra) # 80000546 <mappages>
    80000938:	e90d                	bnez	a0,8000096a <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000093a:	6785                	lui	a5,0x1
    8000093c:	993e                	add	s2,s2,a5
    8000093e:	fd4968e3          	bltu	s2,s4,8000090e <uvmalloc+0x32>
  return newsz;
    80000942:	8552                	mv	a0,s4
    80000944:	a809                	j	80000956 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000946:	864e                	mv	a2,s3
    80000948:	85ca                	mv	a1,s2
    8000094a:	8556                	mv	a0,s5
    8000094c:	00000097          	auipc	ra,0x0
    80000950:	f48080e7          	jalr	-184(ra) # 80000894 <uvmdealloc>
      return 0;
    80000954:	4501                	li	a0,0
}
    80000956:	70e2                	ld	ra,56(sp)
    80000958:	7442                	ld	s0,48(sp)
    8000095a:	74a2                	ld	s1,40(sp)
    8000095c:	7902                	ld	s2,32(sp)
    8000095e:	69e2                	ld	s3,24(sp)
    80000960:	6a42                	ld	s4,16(sp)
    80000962:	6aa2                	ld	s5,8(sp)
    80000964:	6b02                	ld	s6,0(sp)
    80000966:	6121                	addi	sp,sp,64
    80000968:	8082                	ret
      kfree(mem);
    8000096a:	8526                	mv	a0,s1
    8000096c:	fffff097          	auipc	ra,0xfffff
    80000970:	6b0080e7          	jalr	1712(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000974:	864e                	mv	a2,s3
    80000976:	85ca                	mv	a1,s2
    80000978:	8556                	mv	a0,s5
    8000097a:	00000097          	auipc	ra,0x0
    8000097e:	f1a080e7          	jalr	-230(ra) # 80000894 <uvmdealloc>
      return 0;
    80000982:	4501                	li	a0,0
    80000984:	bfc9                	j	80000956 <uvmalloc+0x7a>
    return oldsz;
    80000986:	852e                	mv	a0,a1
}
    80000988:	8082                	ret
  return newsz;
    8000098a:	8532                	mv	a0,a2
    8000098c:	b7e9                	j	80000956 <uvmalloc+0x7a>

000000008000098e <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000098e:	7179                	addi	sp,sp,-48
    80000990:	f406                	sd	ra,40(sp)
    80000992:	f022                	sd	s0,32(sp)
    80000994:	ec26                	sd	s1,24(sp)
    80000996:	e84a                	sd	s2,16(sp)
    80000998:	e44e                	sd	s3,8(sp)
    8000099a:	e052                	sd	s4,0(sp)
    8000099c:	1800                	addi	s0,sp,48
    8000099e:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009a0:	84aa                	mv	s1,a0
    800009a2:	6905                	lui	s2,0x1
    800009a4:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009a6:	4985                	li	s3,1
    800009a8:	a829                	j	800009c2 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009aa:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009ac:	00c79513          	slli	a0,a5,0xc
    800009b0:	00000097          	auipc	ra,0x0
    800009b4:	fde080e7          	jalr	-34(ra) # 8000098e <freewalk>
      pagetable[i] = 0;
    800009b8:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800009bc:	04a1                	addi	s1,s1,8
    800009be:	03248163          	beq	s1,s2,800009e0 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800009c2:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009c4:	00f7f713          	andi	a4,a5,15
    800009c8:	ff3701e3          	beq	a4,s3,800009aa <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009cc:	8b85                	andi	a5,a5,1
    800009ce:	d7fd                	beqz	a5,800009bc <freewalk+0x2e>
      panic("freewalk: leaf");
    800009d0:	00007517          	auipc	a0,0x7
    800009d4:	76850513          	addi	a0,a0,1896 # 80008138 <etext+0x138>
    800009d8:	00005097          	auipc	ra,0x5
    800009dc:	214080e7          	jalr	532(ra) # 80005bec <panic>
    }
  }
  kfree((void*)pagetable);
    800009e0:	8552                	mv	a0,s4
    800009e2:	fffff097          	auipc	ra,0xfffff
    800009e6:	63a080e7          	jalr	1594(ra) # 8000001c <kfree>
}
    800009ea:	70a2                	ld	ra,40(sp)
    800009ec:	7402                	ld	s0,32(sp)
    800009ee:	64e2                	ld	s1,24(sp)
    800009f0:	6942                	ld	s2,16(sp)
    800009f2:	69a2                	ld	s3,8(sp)
    800009f4:	6a02                	ld	s4,0(sp)
    800009f6:	6145                	addi	sp,sp,48
    800009f8:	8082                	ret

00000000800009fa <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009fa:	1101                	addi	sp,sp,-32
    800009fc:	ec06                	sd	ra,24(sp)
    800009fe:	e822                	sd	s0,16(sp)
    80000a00:	e426                	sd	s1,8(sp)
    80000a02:	1000                	addi	s0,sp,32
    80000a04:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a06:	e999                	bnez	a1,80000a1c <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a08:	8526                	mv	a0,s1
    80000a0a:	00000097          	auipc	ra,0x0
    80000a0e:	f84080e7          	jalr	-124(ra) # 8000098e <freewalk>
}
    80000a12:	60e2                	ld	ra,24(sp)
    80000a14:	6442                	ld	s0,16(sp)
    80000a16:	64a2                	ld	s1,8(sp)
    80000a18:	6105                	addi	sp,sp,32
    80000a1a:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a1c:	6785                	lui	a5,0x1
    80000a1e:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a20:	95be                	add	a1,a1,a5
    80000a22:	4685                	li	a3,1
    80000a24:	00c5d613          	srli	a2,a1,0xc
    80000a28:	4581                	li	a1,0
    80000a2a:	00000097          	auipc	ra,0x0
    80000a2e:	d06080e7          	jalr	-762(ra) # 80000730 <uvmunmap>
    80000a32:	bfd9                	j	80000a08 <uvmfree+0xe>

0000000080000a34 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a34:	c679                	beqz	a2,80000b02 <uvmcopy+0xce>
{
    80000a36:	715d                	addi	sp,sp,-80
    80000a38:	e486                	sd	ra,72(sp)
    80000a3a:	e0a2                	sd	s0,64(sp)
    80000a3c:	fc26                	sd	s1,56(sp)
    80000a3e:	f84a                	sd	s2,48(sp)
    80000a40:	f44e                	sd	s3,40(sp)
    80000a42:	f052                	sd	s4,32(sp)
    80000a44:	ec56                	sd	s5,24(sp)
    80000a46:	e85a                	sd	s6,16(sp)
    80000a48:	e45e                	sd	s7,8(sp)
    80000a4a:	0880                	addi	s0,sp,80
    80000a4c:	8b2a                	mv	s6,a0
    80000a4e:	8aae                	mv	s5,a1
    80000a50:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a52:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a54:	4601                	li	a2,0
    80000a56:	85ce                	mv	a1,s3
    80000a58:	855a                	mv	a0,s6
    80000a5a:	00000097          	auipc	ra,0x0
    80000a5e:	a04080e7          	jalr	-1532(ra) # 8000045e <walk>
    80000a62:	c531                	beqz	a0,80000aae <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a64:	6118                	ld	a4,0(a0)
    80000a66:	00177793          	andi	a5,a4,1
    80000a6a:	cbb1                	beqz	a5,80000abe <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a6c:	00a75593          	srli	a1,a4,0xa
    80000a70:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a74:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a78:	fffff097          	auipc	ra,0xfffff
    80000a7c:	6a2080e7          	jalr	1698(ra) # 8000011a <kalloc>
    80000a80:	892a                	mv	s2,a0
    80000a82:	c939                	beqz	a0,80000ad8 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a84:	6605                	lui	a2,0x1
    80000a86:	85de                	mv	a1,s7
    80000a88:	fffff097          	auipc	ra,0xfffff
    80000a8c:	74e080e7          	jalr	1870(ra) # 800001d6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a90:	8726                	mv	a4,s1
    80000a92:	86ca                	mv	a3,s2
    80000a94:	6605                	lui	a2,0x1
    80000a96:	85ce                	mv	a1,s3
    80000a98:	8556                	mv	a0,s5
    80000a9a:	00000097          	auipc	ra,0x0
    80000a9e:	aac080e7          	jalr	-1364(ra) # 80000546 <mappages>
    80000aa2:	e515                	bnez	a0,80000ace <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000aa4:	6785                	lui	a5,0x1
    80000aa6:	99be                	add	s3,s3,a5
    80000aa8:	fb49e6e3          	bltu	s3,s4,80000a54 <uvmcopy+0x20>
    80000aac:	a081                	j	80000aec <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000aae:	00007517          	auipc	a0,0x7
    80000ab2:	69a50513          	addi	a0,a0,1690 # 80008148 <etext+0x148>
    80000ab6:	00005097          	auipc	ra,0x5
    80000aba:	136080e7          	jalr	310(ra) # 80005bec <panic>
      panic("uvmcopy: page not present");
    80000abe:	00007517          	auipc	a0,0x7
    80000ac2:	6aa50513          	addi	a0,a0,1706 # 80008168 <etext+0x168>
    80000ac6:	00005097          	auipc	ra,0x5
    80000aca:	126080e7          	jalr	294(ra) # 80005bec <panic>
      kfree(mem);
    80000ace:	854a                	mv	a0,s2
    80000ad0:	fffff097          	auipc	ra,0xfffff
    80000ad4:	54c080e7          	jalr	1356(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000ad8:	4685                	li	a3,1
    80000ada:	00c9d613          	srli	a2,s3,0xc
    80000ade:	4581                	li	a1,0
    80000ae0:	8556                	mv	a0,s5
    80000ae2:	00000097          	auipc	ra,0x0
    80000ae6:	c4e080e7          	jalr	-946(ra) # 80000730 <uvmunmap>
  return -1;
    80000aea:	557d                	li	a0,-1
}
    80000aec:	60a6                	ld	ra,72(sp)
    80000aee:	6406                	ld	s0,64(sp)
    80000af0:	74e2                	ld	s1,56(sp)
    80000af2:	7942                	ld	s2,48(sp)
    80000af4:	79a2                	ld	s3,40(sp)
    80000af6:	7a02                	ld	s4,32(sp)
    80000af8:	6ae2                	ld	s5,24(sp)
    80000afa:	6b42                	ld	s6,16(sp)
    80000afc:	6ba2                	ld	s7,8(sp)
    80000afe:	6161                	addi	sp,sp,80
    80000b00:	8082                	ret
  return 0;
    80000b02:	4501                	li	a0,0
}
    80000b04:	8082                	ret

0000000080000b06 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b06:	1141                	addi	sp,sp,-16
    80000b08:	e406                	sd	ra,8(sp)
    80000b0a:	e022                	sd	s0,0(sp)
    80000b0c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b0e:	4601                	li	a2,0
    80000b10:	00000097          	auipc	ra,0x0
    80000b14:	94e080e7          	jalr	-1714(ra) # 8000045e <walk>
  if(pte == 0)
    80000b18:	c901                	beqz	a0,80000b28 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b1a:	611c                	ld	a5,0(a0)
    80000b1c:	9bbd                	andi	a5,a5,-17
    80000b1e:	e11c                	sd	a5,0(a0)
}
    80000b20:	60a2                	ld	ra,8(sp)
    80000b22:	6402                	ld	s0,0(sp)
    80000b24:	0141                	addi	sp,sp,16
    80000b26:	8082                	ret
    panic("uvmclear");
    80000b28:	00007517          	auipc	a0,0x7
    80000b2c:	66050513          	addi	a0,a0,1632 # 80008188 <etext+0x188>
    80000b30:	00005097          	auipc	ra,0x5
    80000b34:	0bc080e7          	jalr	188(ra) # 80005bec <panic>

0000000080000b38 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    80000b38:	cac9                	beqz	a3,80000bca <copyout+0x92>
{
    80000b3a:	711d                	addi	sp,sp,-96
    80000b3c:	ec86                	sd	ra,88(sp)
    80000b3e:	e8a2                	sd	s0,80(sp)
    80000b40:	e4a6                	sd	s1,72(sp)
    80000b42:	e0ca                	sd	s2,64(sp)
    80000b44:	fc4e                	sd	s3,56(sp)
    80000b46:	f852                	sd	s4,48(sp)
    80000b48:	f456                	sd	s5,40(sp)
    80000b4a:	f05a                	sd	s6,32(sp)
    80000b4c:	ec5e                	sd	s7,24(sp)
    80000b4e:	e862                	sd	s8,16(sp)
    80000b50:	e466                	sd	s9,8(sp)
    80000b52:	e06a                	sd	s10,0(sp)
    80000b54:	1080                	addi	s0,sp,96
    80000b56:	8baa                	mv	s7,a0
    80000b58:	8aae                	mv	s5,a1
    80000b5a:	8b32                	mv	s6,a2
    80000b5c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b5e:	74fd                	lui	s1,0xfffff
    80000b60:	8ced                	and	s1,s1,a1
    if(va0 >= MAXVA)
    80000b62:	57fd                	li	a5,-1
    80000b64:	83e9                	srli	a5,a5,0x1a
    80000b66:	0697e463          	bltu	a5,s1,80000bce <copyout+0x96>
      return -1;
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000b6a:	4cd5                	li	s9,21
    80000b6c:	6d05                	lui	s10,0x1
    if(va0 >= MAXVA)
    80000b6e:	8c3e                	mv	s8,a5
    80000b70:	a035                	j	80000b9c <copyout+0x64>
       (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    80000b72:	83a9                	srli	a5,a5,0xa
    80000b74:	07b2                	slli	a5,a5,0xc
    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b76:	409a8533          	sub	a0,s5,s1
    80000b7a:	0009061b          	sext.w	a2,s2
    80000b7e:	85da                	mv	a1,s6
    80000b80:	953e                	add	a0,a0,a5
    80000b82:	fffff097          	auipc	ra,0xfffff
    80000b86:	654080e7          	jalr	1620(ra) # 800001d6 <memmove>

    len -= n;
    80000b8a:	412989b3          	sub	s3,s3,s2
    src += n;
    80000b8e:	9b4a                	add	s6,s6,s2
  while(len > 0){
    80000b90:	02098b63          	beqz	s3,80000bc6 <copyout+0x8e>
    if(va0 >= MAXVA)
    80000b94:	034c6f63          	bltu	s8,s4,80000bd2 <copyout+0x9a>
    va0 = PGROUNDDOWN(dstva);
    80000b98:	84d2                	mv	s1,s4
    dstva = va0 + PGSIZE;
    80000b9a:	8ad2                	mv	s5,s4
    pte = walk(pagetable, va0, 0);
    80000b9c:	4601                	li	a2,0
    80000b9e:	85a6                	mv	a1,s1
    80000ba0:	855e                	mv	a0,s7
    80000ba2:	00000097          	auipc	ra,0x0
    80000ba6:	8bc080e7          	jalr	-1860(ra) # 8000045e <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000baa:	c515                	beqz	a0,80000bd6 <copyout+0x9e>
    80000bac:	611c                	ld	a5,0(a0)
    80000bae:	0157f713          	andi	a4,a5,21
    80000bb2:	05971163          	bne	a4,s9,80000bf4 <copyout+0xbc>
    n = PGSIZE - (dstva - va0);
    80000bb6:	01a48a33          	add	s4,s1,s10
    80000bba:	415a0933          	sub	s2,s4,s5
    80000bbe:	fb29fae3          	bgeu	s3,s2,80000b72 <copyout+0x3a>
    80000bc2:	894e                	mv	s2,s3
    80000bc4:	b77d                	j	80000b72 <copyout+0x3a>
  }
  return 0;
    80000bc6:	4501                	li	a0,0
    80000bc8:	a801                	j	80000bd8 <copyout+0xa0>
    80000bca:	4501                	li	a0,0
}
    80000bcc:	8082                	ret
      return -1;
    80000bce:	557d                	li	a0,-1
    80000bd0:	a021                	j	80000bd8 <copyout+0xa0>
    80000bd2:	557d                	li	a0,-1
    80000bd4:	a011                	j	80000bd8 <copyout+0xa0>
      return -1;
    80000bd6:	557d                	li	a0,-1
}
    80000bd8:	60e6                	ld	ra,88(sp)
    80000bda:	6446                	ld	s0,80(sp)
    80000bdc:	64a6                	ld	s1,72(sp)
    80000bde:	6906                	ld	s2,64(sp)
    80000be0:	79e2                	ld	s3,56(sp)
    80000be2:	7a42                	ld	s4,48(sp)
    80000be4:	7aa2                	ld	s5,40(sp)
    80000be6:	7b02                	ld	s6,32(sp)
    80000be8:	6be2                	ld	s7,24(sp)
    80000bea:	6c42                	ld	s8,16(sp)
    80000bec:	6ca2                	ld	s9,8(sp)
    80000bee:	6d02                	ld	s10,0(sp)
    80000bf0:	6125                	addi	sp,sp,96
    80000bf2:	8082                	ret
      return -1;
    80000bf4:	557d                	li	a0,-1
    80000bf6:	b7cd                	j	80000bd8 <copyout+0xa0>

0000000080000bf8 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bf8:	caa5                	beqz	a3,80000c68 <copyin+0x70>
{
    80000bfa:	715d                	addi	sp,sp,-80
    80000bfc:	e486                	sd	ra,72(sp)
    80000bfe:	e0a2                	sd	s0,64(sp)
    80000c00:	fc26                	sd	s1,56(sp)
    80000c02:	f84a                	sd	s2,48(sp)
    80000c04:	f44e                	sd	s3,40(sp)
    80000c06:	f052                	sd	s4,32(sp)
    80000c08:	ec56                	sd	s5,24(sp)
    80000c0a:	e85a                	sd	s6,16(sp)
    80000c0c:	e45e                	sd	s7,8(sp)
    80000c0e:	e062                	sd	s8,0(sp)
    80000c10:	0880                	addi	s0,sp,80
    80000c12:	8b2a                	mv	s6,a0
    80000c14:	8a2e                	mv	s4,a1
    80000c16:	8c32                	mv	s8,a2
    80000c18:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c1a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c1c:	6a85                	lui	s5,0x1
    80000c1e:	a01d                	j	80000c44 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c20:	018505b3          	add	a1,a0,s8
    80000c24:	0004861b          	sext.w	a2,s1
    80000c28:	412585b3          	sub	a1,a1,s2
    80000c2c:	8552                	mv	a0,s4
    80000c2e:	fffff097          	auipc	ra,0xfffff
    80000c32:	5a8080e7          	jalr	1448(ra) # 800001d6 <memmove>

    len -= n;
    80000c36:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c3a:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c3c:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c40:	02098263          	beqz	s3,80000c64 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c44:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c48:	85ca                	mv	a1,s2
    80000c4a:	855a                	mv	a0,s6
    80000c4c:	00000097          	auipc	ra,0x0
    80000c50:	8b8080e7          	jalr	-1864(ra) # 80000504 <walkaddr>
    if(pa0 == 0)
    80000c54:	cd01                	beqz	a0,80000c6c <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c56:	418904b3          	sub	s1,s2,s8
    80000c5a:	94d6                	add	s1,s1,s5
    80000c5c:	fc99f2e3          	bgeu	s3,s1,80000c20 <copyin+0x28>
    80000c60:	84ce                	mv	s1,s3
    80000c62:	bf7d                	j	80000c20 <copyin+0x28>
  }
  return 0;
    80000c64:	4501                	li	a0,0
    80000c66:	a021                	j	80000c6e <copyin+0x76>
    80000c68:	4501                	li	a0,0
}
    80000c6a:	8082                	ret
      return -1;
    80000c6c:	557d                	li	a0,-1
}
    80000c6e:	60a6                	ld	ra,72(sp)
    80000c70:	6406                	ld	s0,64(sp)
    80000c72:	74e2                	ld	s1,56(sp)
    80000c74:	7942                	ld	s2,48(sp)
    80000c76:	79a2                	ld	s3,40(sp)
    80000c78:	7a02                	ld	s4,32(sp)
    80000c7a:	6ae2                	ld	s5,24(sp)
    80000c7c:	6b42                	ld	s6,16(sp)
    80000c7e:	6ba2                	ld	s7,8(sp)
    80000c80:	6c02                	ld	s8,0(sp)
    80000c82:	6161                	addi	sp,sp,80
    80000c84:	8082                	ret

0000000080000c86 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c86:	c2dd                	beqz	a3,80000d2c <copyinstr+0xa6>
{
    80000c88:	715d                	addi	sp,sp,-80
    80000c8a:	e486                	sd	ra,72(sp)
    80000c8c:	e0a2                	sd	s0,64(sp)
    80000c8e:	fc26                	sd	s1,56(sp)
    80000c90:	f84a                	sd	s2,48(sp)
    80000c92:	f44e                	sd	s3,40(sp)
    80000c94:	f052                	sd	s4,32(sp)
    80000c96:	ec56                	sd	s5,24(sp)
    80000c98:	e85a                	sd	s6,16(sp)
    80000c9a:	e45e                	sd	s7,8(sp)
    80000c9c:	0880                	addi	s0,sp,80
    80000c9e:	8a2a                	mv	s4,a0
    80000ca0:	8b2e                	mv	s6,a1
    80000ca2:	8bb2                	mv	s7,a2
    80000ca4:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000ca6:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000ca8:	6985                	lui	s3,0x1
    80000caa:	a02d                	j	80000cd4 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000cac:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000cb0:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000cb2:	37fd                	addiw	a5,a5,-1
    80000cb4:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000cb8:	60a6                	ld	ra,72(sp)
    80000cba:	6406                	ld	s0,64(sp)
    80000cbc:	74e2                	ld	s1,56(sp)
    80000cbe:	7942                	ld	s2,48(sp)
    80000cc0:	79a2                	ld	s3,40(sp)
    80000cc2:	7a02                	ld	s4,32(sp)
    80000cc4:	6ae2                	ld	s5,24(sp)
    80000cc6:	6b42                	ld	s6,16(sp)
    80000cc8:	6ba2                	ld	s7,8(sp)
    80000cca:	6161                	addi	sp,sp,80
    80000ccc:	8082                	ret
    srcva = va0 + PGSIZE;
    80000cce:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000cd2:	c8a9                	beqz	s1,80000d24 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000cd4:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000cd8:	85ca                	mv	a1,s2
    80000cda:	8552                	mv	a0,s4
    80000cdc:	00000097          	auipc	ra,0x0
    80000ce0:	828080e7          	jalr	-2008(ra) # 80000504 <walkaddr>
    if(pa0 == 0)
    80000ce4:	c131                	beqz	a0,80000d28 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000ce6:	417906b3          	sub	a3,s2,s7
    80000cea:	96ce                	add	a3,a3,s3
    80000cec:	00d4f363          	bgeu	s1,a3,80000cf2 <copyinstr+0x6c>
    80000cf0:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000cf2:	955e                	add	a0,a0,s7
    80000cf4:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000cf8:	daf9                	beqz	a3,80000cce <copyinstr+0x48>
    80000cfa:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000cfc:	41650633          	sub	a2,a0,s6
    80000d00:	fff48593          	addi	a1,s1,-1 # ffffffffffffefff <end+0xffffffff7ffdd26f>
    80000d04:	95da                	add	a1,a1,s6
    while(n > 0){
    80000d06:	96da                	add	a3,a3,s6
      if(*p == '\0'){
    80000d08:	00f60733          	add	a4,a2,a5
    80000d0c:	00074703          	lbu	a4,0(a4)
    80000d10:	df51                	beqz	a4,80000cac <copyinstr+0x26>
        *dst = *p;
    80000d12:	00e78023          	sb	a4,0(a5)
      --max;
    80000d16:	40f584b3          	sub	s1,a1,a5
      dst++;
    80000d1a:	0785                	addi	a5,a5,1
    while(n > 0){
    80000d1c:	fed796e3          	bne	a5,a3,80000d08 <copyinstr+0x82>
      dst++;
    80000d20:	8b3e                	mv	s6,a5
    80000d22:	b775                	j	80000cce <copyinstr+0x48>
    80000d24:	4781                	li	a5,0
    80000d26:	b771                	j	80000cb2 <copyinstr+0x2c>
      return -1;
    80000d28:	557d                	li	a0,-1
    80000d2a:	b779                	j	80000cb8 <copyinstr+0x32>
  int got_null = 0;
    80000d2c:	4781                	li	a5,0
  if(got_null){
    80000d2e:	37fd                	addiw	a5,a5,-1
    80000d30:	0007851b          	sext.w	a0,a5
}
    80000d34:	8082                	ret

0000000080000d36 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000d36:	7139                	addi	sp,sp,-64
    80000d38:	fc06                	sd	ra,56(sp)
    80000d3a:	f822                	sd	s0,48(sp)
    80000d3c:	f426                	sd	s1,40(sp)
    80000d3e:	f04a                	sd	s2,32(sp)
    80000d40:	ec4e                	sd	s3,24(sp)
    80000d42:	e852                	sd	s4,16(sp)
    80000d44:	e456                	sd	s5,8(sp)
    80000d46:	e05a                	sd	s6,0(sp)
    80000d48:	0080                	addi	s0,sp,64
    80000d4a:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d4c:	00008497          	auipc	s1,0x8
    80000d50:	02448493          	addi	s1,s1,36 # 80008d70 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d54:	8b26                	mv	s6,s1
    80000d56:	00007a97          	auipc	s5,0x7
    80000d5a:	2aaa8a93          	addi	s5,s5,682 # 80008000 <etext>
    80000d5e:	04000937          	lui	s2,0x4000
    80000d62:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000d64:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d66:	0000ea17          	auipc	s4,0xe
    80000d6a:	a0aa0a13          	addi	s4,s4,-1526 # 8000e770 <tickslock>
    char *pa = kalloc();
    80000d6e:	fffff097          	auipc	ra,0xfffff
    80000d72:	3ac080e7          	jalr	940(ra) # 8000011a <kalloc>
    80000d76:	862a                	mv	a2,a0
    if(pa == 0)
    80000d78:	c131                	beqz	a0,80000dbc <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000d7a:	416485b3          	sub	a1,s1,s6
    80000d7e:	858d                	srai	a1,a1,0x3
    80000d80:	000ab783          	ld	a5,0(s5)
    80000d84:	02f585b3          	mul	a1,a1,a5
    80000d88:	2585                	addiw	a1,a1,1
    80000d8a:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d8e:	4719                	li	a4,6
    80000d90:	6685                	lui	a3,0x1
    80000d92:	40b905b3          	sub	a1,s2,a1
    80000d96:	854e                	mv	a0,s3
    80000d98:	00000097          	auipc	ra,0x0
    80000d9c:	872080e7          	jalr	-1934(ra) # 8000060a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000da0:	16848493          	addi	s1,s1,360
    80000da4:	fd4495e3          	bne	s1,s4,80000d6e <proc_mapstacks+0x38>
  }
}
    80000da8:	70e2                	ld	ra,56(sp)
    80000daa:	7442                	ld	s0,48(sp)
    80000dac:	74a2                	ld	s1,40(sp)
    80000dae:	7902                	ld	s2,32(sp)
    80000db0:	69e2                	ld	s3,24(sp)
    80000db2:	6a42                	ld	s4,16(sp)
    80000db4:	6aa2                	ld	s5,8(sp)
    80000db6:	6b02                	ld	s6,0(sp)
    80000db8:	6121                	addi	sp,sp,64
    80000dba:	8082                	ret
      panic("kalloc");
    80000dbc:	00007517          	auipc	a0,0x7
    80000dc0:	3dc50513          	addi	a0,a0,988 # 80008198 <etext+0x198>
    80000dc4:	00005097          	auipc	ra,0x5
    80000dc8:	e28080e7          	jalr	-472(ra) # 80005bec <panic>

0000000080000dcc <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000dcc:	7139                	addi	sp,sp,-64
    80000dce:	fc06                	sd	ra,56(sp)
    80000dd0:	f822                	sd	s0,48(sp)
    80000dd2:	f426                	sd	s1,40(sp)
    80000dd4:	f04a                	sd	s2,32(sp)
    80000dd6:	ec4e                	sd	s3,24(sp)
    80000dd8:	e852                	sd	s4,16(sp)
    80000dda:	e456                	sd	s5,8(sp)
    80000ddc:	e05a                	sd	s6,0(sp)
    80000dde:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000de0:	00007597          	auipc	a1,0x7
    80000de4:	3c058593          	addi	a1,a1,960 # 800081a0 <etext+0x1a0>
    80000de8:	00008517          	auipc	a0,0x8
    80000dec:	b5850513          	addi	a0,a0,-1192 # 80008940 <pid_lock>
    80000df0:	00005097          	auipc	ra,0x5
    80000df4:	2a4080e7          	jalr	676(ra) # 80006094 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000df8:	00007597          	auipc	a1,0x7
    80000dfc:	3b058593          	addi	a1,a1,944 # 800081a8 <etext+0x1a8>
    80000e00:	00008517          	auipc	a0,0x8
    80000e04:	b5850513          	addi	a0,a0,-1192 # 80008958 <wait_lock>
    80000e08:	00005097          	auipc	ra,0x5
    80000e0c:	28c080e7          	jalr	652(ra) # 80006094 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e10:	00008497          	auipc	s1,0x8
    80000e14:	f6048493          	addi	s1,s1,-160 # 80008d70 <proc>
      initlock(&p->lock, "proc");
    80000e18:	00007b17          	auipc	s6,0x7
    80000e1c:	3a0b0b13          	addi	s6,s6,928 # 800081b8 <etext+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000e20:	8aa6                	mv	s5,s1
    80000e22:	00007a17          	auipc	s4,0x7
    80000e26:	1dea0a13          	addi	s4,s4,478 # 80008000 <etext>
    80000e2a:	04000937          	lui	s2,0x4000
    80000e2e:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000e30:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e32:	0000e997          	auipc	s3,0xe
    80000e36:	93e98993          	addi	s3,s3,-1730 # 8000e770 <tickslock>
      initlock(&p->lock, "proc");
    80000e3a:	85da                	mv	a1,s6
    80000e3c:	8526                	mv	a0,s1
    80000e3e:	00005097          	auipc	ra,0x5
    80000e42:	256080e7          	jalr	598(ra) # 80006094 <initlock>
      p->state = UNUSED;
    80000e46:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000e4a:	415487b3          	sub	a5,s1,s5
    80000e4e:	878d                	srai	a5,a5,0x3
    80000e50:	000a3703          	ld	a4,0(s4)
    80000e54:	02e787b3          	mul	a5,a5,a4
    80000e58:	2785                	addiw	a5,a5,1
    80000e5a:	00d7979b          	slliw	a5,a5,0xd
    80000e5e:	40f907b3          	sub	a5,s2,a5
    80000e62:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e64:	16848493          	addi	s1,s1,360
    80000e68:	fd3499e3          	bne	s1,s3,80000e3a <procinit+0x6e>
  }
}
    80000e6c:	70e2                	ld	ra,56(sp)
    80000e6e:	7442                	ld	s0,48(sp)
    80000e70:	74a2                	ld	s1,40(sp)
    80000e72:	7902                	ld	s2,32(sp)
    80000e74:	69e2                	ld	s3,24(sp)
    80000e76:	6a42                	ld	s4,16(sp)
    80000e78:	6aa2                	ld	s5,8(sp)
    80000e7a:	6b02                	ld	s6,0(sp)
    80000e7c:	6121                	addi	sp,sp,64
    80000e7e:	8082                	ret

0000000080000e80 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e80:	1141                	addi	sp,sp,-16
    80000e82:	e422                	sd	s0,8(sp)
    80000e84:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e86:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e88:	2501                	sext.w	a0,a0
    80000e8a:	6422                	ld	s0,8(sp)
    80000e8c:	0141                	addi	sp,sp,16
    80000e8e:	8082                	ret

0000000080000e90 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000e90:	1141                	addi	sp,sp,-16
    80000e92:	e422                	sd	s0,8(sp)
    80000e94:	0800                	addi	s0,sp,16
    80000e96:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e98:	2781                	sext.w	a5,a5
    80000e9a:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e9c:	00008517          	auipc	a0,0x8
    80000ea0:	ad450513          	addi	a0,a0,-1324 # 80008970 <cpus>
    80000ea4:	953e                	add	a0,a0,a5
    80000ea6:	6422                	ld	s0,8(sp)
    80000ea8:	0141                	addi	sp,sp,16
    80000eaa:	8082                	ret

0000000080000eac <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000eac:	1101                	addi	sp,sp,-32
    80000eae:	ec06                	sd	ra,24(sp)
    80000eb0:	e822                	sd	s0,16(sp)
    80000eb2:	e426                	sd	s1,8(sp)
    80000eb4:	1000                	addi	s0,sp,32
  push_off();
    80000eb6:	00005097          	auipc	ra,0x5
    80000eba:	222080e7          	jalr	546(ra) # 800060d8 <push_off>
    80000ebe:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000ec0:	2781                	sext.w	a5,a5
    80000ec2:	079e                	slli	a5,a5,0x7
    80000ec4:	00008717          	auipc	a4,0x8
    80000ec8:	a7c70713          	addi	a4,a4,-1412 # 80008940 <pid_lock>
    80000ecc:	97ba                	add	a5,a5,a4
    80000ece:	7b84                	ld	s1,48(a5)
  pop_off();
    80000ed0:	00005097          	auipc	ra,0x5
    80000ed4:	2a8080e7          	jalr	680(ra) # 80006178 <pop_off>
  return p;
}
    80000ed8:	8526                	mv	a0,s1
    80000eda:	60e2                	ld	ra,24(sp)
    80000edc:	6442                	ld	s0,16(sp)
    80000ede:	64a2                	ld	s1,8(sp)
    80000ee0:	6105                	addi	sp,sp,32
    80000ee2:	8082                	ret

0000000080000ee4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000ee4:	1141                	addi	sp,sp,-16
    80000ee6:	e406                	sd	ra,8(sp)
    80000ee8:	e022                	sd	s0,0(sp)
    80000eea:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000eec:	00000097          	auipc	ra,0x0
    80000ef0:	fc0080e7          	jalr	-64(ra) # 80000eac <myproc>
    80000ef4:	00005097          	auipc	ra,0x5
    80000ef8:	2e4080e7          	jalr	740(ra) # 800061d8 <release>

  if (first) {
    80000efc:	00008797          	auipc	a5,0x8
    80000f00:	9847a783          	lw	a5,-1660(a5) # 80008880 <first.1>
    80000f04:	eb89                	bnez	a5,80000f16 <forkret+0x32>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    80000f06:	00001097          	auipc	ra,0x1
    80000f0a:	c60080e7          	jalr	-928(ra) # 80001b66 <usertrapret>
}
    80000f0e:	60a2                	ld	ra,8(sp)
    80000f10:	6402                	ld	s0,0(sp)
    80000f12:	0141                	addi	sp,sp,16
    80000f14:	8082                	ret
    fsinit(ROOTDEV);
    80000f16:	4505                	li	a0,1
    80000f18:	00002097          	auipc	ra,0x2
    80000f1c:	9a8080e7          	jalr	-1624(ra) # 800028c0 <fsinit>
    first = 0;
    80000f20:	00008797          	auipc	a5,0x8
    80000f24:	9607a023          	sw	zero,-1696(a5) # 80008880 <first.1>
    __sync_synchronize();
    80000f28:	0ff0000f          	fence
    80000f2c:	bfe9                	j	80000f06 <forkret+0x22>

0000000080000f2e <allocpid>:
{
    80000f2e:	1101                	addi	sp,sp,-32
    80000f30:	ec06                	sd	ra,24(sp)
    80000f32:	e822                	sd	s0,16(sp)
    80000f34:	e426                	sd	s1,8(sp)
    80000f36:	e04a                	sd	s2,0(sp)
    80000f38:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f3a:	00008917          	auipc	s2,0x8
    80000f3e:	a0690913          	addi	s2,s2,-1530 # 80008940 <pid_lock>
    80000f42:	854a                	mv	a0,s2
    80000f44:	00005097          	auipc	ra,0x5
    80000f48:	1e0080e7          	jalr	480(ra) # 80006124 <acquire>
  pid = nextpid;
    80000f4c:	00008797          	auipc	a5,0x8
    80000f50:	93878793          	addi	a5,a5,-1736 # 80008884 <nextpid>
    80000f54:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000f56:	0014871b          	addiw	a4,s1,1
    80000f5a:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f5c:	854a                	mv	a0,s2
    80000f5e:	00005097          	auipc	ra,0x5
    80000f62:	27a080e7          	jalr	634(ra) # 800061d8 <release>
}
    80000f66:	8526                	mv	a0,s1
    80000f68:	60e2                	ld	ra,24(sp)
    80000f6a:	6442                	ld	s0,16(sp)
    80000f6c:	64a2                	ld	s1,8(sp)
    80000f6e:	6902                	ld	s2,0(sp)
    80000f70:	6105                	addi	sp,sp,32
    80000f72:	8082                	ret

0000000080000f74 <proc_pagetable>:
{
    80000f74:	1101                	addi	sp,sp,-32
    80000f76:	ec06                	sd	ra,24(sp)
    80000f78:	e822                	sd	s0,16(sp)
    80000f7a:	e426                	sd	s1,8(sp)
    80000f7c:	e04a                	sd	s2,0(sp)
    80000f7e:	1000                	addi	s0,sp,32
    80000f80:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f82:	00000097          	auipc	ra,0x0
    80000f86:	872080e7          	jalr	-1934(ra) # 800007f4 <uvmcreate>
    80000f8a:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f8c:	c121                	beqz	a0,80000fcc <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f8e:	4729                	li	a4,10
    80000f90:	00006697          	auipc	a3,0x6
    80000f94:	07068693          	addi	a3,a3,112 # 80007000 <_trampoline>
    80000f98:	6605                	lui	a2,0x1
    80000f9a:	040005b7          	lui	a1,0x4000
    80000f9e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fa0:	05b2                	slli	a1,a1,0xc
    80000fa2:	fffff097          	auipc	ra,0xfffff
    80000fa6:	5a4080e7          	jalr	1444(ra) # 80000546 <mappages>
    80000faa:	02054863          	bltz	a0,80000fda <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000fae:	4719                	li	a4,6
    80000fb0:	05893683          	ld	a3,88(s2)
    80000fb4:	6605                	lui	a2,0x1
    80000fb6:	020005b7          	lui	a1,0x2000
    80000fba:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fbc:	05b6                	slli	a1,a1,0xd
    80000fbe:	8526                	mv	a0,s1
    80000fc0:	fffff097          	auipc	ra,0xfffff
    80000fc4:	586080e7          	jalr	1414(ra) # 80000546 <mappages>
    80000fc8:	02054163          	bltz	a0,80000fea <proc_pagetable+0x76>
}
    80000fcc:	8526                	mv	a0,s1
    80000fce:	60e2                	ld	ra,24(sp)
    80000fd0:	6442                	ld	s0,16(sp)
    80000fd2:	64a2                	ld	s1,8(sp)
    80000fd4:	6902                	ld	s2,0(sp)
    80000fd6:	6105                	addi	sp,sp,32
    80000fd8:	8082                	ret
    uvmfree(pagetable, 0);
    80000fda:	4581                	li	a1,0
    80000fdc:	8526                	mv	a0,s1
    80000fde:	00000097          	auipc	ra,0x0
    80000fe2:	a1c080e7          	jalr	-1508(ra) # 800009fa <uvmfree>
    return 0;
    80000fe6:	4481                	li	s1,0
    80000fe8:	b7d5                	j	80000fcc <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fea:	4681                	li	a3,0
    80000fec:	4605                	li	a2,1
    80000fee:	040005b7          	lui	a1,0x4000
    80000ff2:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ff4:	05b2                	slli	a1,a1,0xc
    80000ff6:	8526                	mv	a0,s1
    80000ff8:	fffff097          	auipc	ra,0xfffff
    80000ffc:	738080e7          	jalr	1848(ra) # 80000730 <uvmunmap>
    uvmfree(pagetable, 0);
    80001000:	4581                	li	a1,0
    80001002:	8526                	mv	a0,s1
    80001004:	00000097          	auipc	ra,0x0
    80001008:	9f6080e7          	jalr	-1546(ra) # 800009fa <uvmfree>
    return 0;
    8000100c:	4481                	li	s1,0
    8000100e:	bf7d                	j	80000fcc <proc_pagetable+0x58>

0000000080001010 <proc_freepagetable>:
{
    80001010:	1101                	addi	sp,sp,-32
    80001012:	ec06                	sd	ra,24(sp)
    80001014:	e822                	sd	s0,16(sp)
    80001016:	e426                	sd	s1,8(sp)
    80001018:	e04a                	sd	s2,0(sp)
    8000101a:	1000                	addi	s0,sp,32
    8000101c:	84aa                	mv	s1,a0
    8000101e:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001020:	4681                	li	a3,0
    80001022:	4605                	li	a2,1
    80001024:	040005b7          	lui	a1,0x4000
    80001028:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000102a:	05b2                	slli	a1,a1,0xc
    8000102c:	fffff097          	auipc	ra,0xfffff
    80001030:	704080e7          	jalr	1796(ra) # 80000730 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001034:	4681                	li	a3,0
    80001036:	4605                	li	a2,1
    80001038:	020005b7          	lui	a1,0x2000
    8000103c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    8000103e:	05b6                	slli	a1,a1,0xd
    80001040:	8526                	mv	a0,s1
    80001042:	fffff097          	auipc	ra,0xfffff
    80001046:	6ee080e7          	jalr	1774(ra) # 80000730 <uvmunmap>
  uvmfree(pagetable, sz);
    8000104a:	85ca                	mv	a1,s2
    8000104c:	8526                	mv	a0,s1
    8000104e:	00000097          	auipc	ra,0x0
    80001052:	9ac080e7          	jalr	-1620(ra) # 800009fa <uvmfree>
}
    80001056:	60e2                	ld	ra,24(sp)
    80001058:	6442                	ld	s0,16(sp)
    8000105a:	64a2                	ld	s1,8(sp)
    8000105c:	6902                	ld	s2,0(sp)
    8000105e:	6105                	addi	sp,sp,32
    80001060:	8082                	ret

0000000080001062 <freeproc>:
{
    80001062:	1101                	addi	sp,sp,-32
    80001064:	ec06                	sd	ra,24(sp)
    80001066:	e822                	sd	s0,16(sp)
    80001068:	e426                	sd	s1,8(sp)
    8000106a:	1000                	addi	s0,sp,32
    8000106c:	84aa                	mv	s1,a0
  if(p->trapframe)
    8000106e:	6d28                	ld	a0,88(a0)
    80001070:	c509                	beqz	a0,8000107a <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001072:	fffff097          	auipc	ra,0xfffff
    80001076:	faa080e7          	jalr	-86(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000107a:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    8000107e:	68a8                	ld	a0,80(s1)
    80001080:	c511                	beqz	a0,8000108c <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001082:	64ac                	ld	a1,72(s1)
    80001084:	00000097          	auipc	ra,0x0
    80001088:	f8c080e7          	jalr	-116(ra) # 80001010 <proc_freepagetable>
  p->pagetable = 0;
    8000108c:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001090:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001094:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001098:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000109c:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800010a0:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800010a4:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    800010a8:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    800010ac:	0004ac23          	sw	zero,24(s1)
}
    800010b0:	60e2                	ld	ra,24(sp)
    800010b2:	6442                	ld	s0,16(sp)
    800010b4:	64a2                	ld	s1,8(sp)
    800010b6:	6105                	addi	sp,sp,32
    800010b8:	8082                	ret

00000000800010ba <allocproc>:
{
    800010ba:	1101                	addi	sp,sp,-32
    800010bc:	ec06                	sd	ra,24(sp)
    800010be:	e822                	sd	s0,16(sp)
    800010c0:	e426                	sd	s1,8(sp)
    800010c2:	e04a                	sd	s2,0(sp)
    800010c4:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800010c6:	00008497          	auipc	s1,0x8
    800010ca:	caa48493          	addi	s1,s1,-854 # 80008d70 <proc>
    800010ce:	0000d917          	auipc	s2,0xd
    800010d2:	6a290913          	addi	s2,s2,1698 # 8000e770 <tickslock>
    acquire(&p->lock);
    800010d6:	8526                	mv	a0,s1
    800010d8:	00005097          	auipc	ra,0x5
    800010dc:	04c080e7          	jalr	76(ra) # 80006124 <acquire>
    if(p->state == UNUSED) {
    800010e0:	4c9c                	lw	a5,24(s1)
    800010e2:	cf81                	beqz	a5,800010fa <allocproc+0x40>
      release(&p->lock);
    800010e4:	8526                	mv	a0,s1
    800010e6:	00005097          	auipc	ra,0x5
    800010ea:	0f2080e7          	jalr	242(ra) # 800061d8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800010ee:	16848493          	addi	s1,s1,360
    800010f2:	ff2492e3          	bne	s1,s2,800010d6 <allocproc+0x1c>
  return 0;
    800010f6:	4481                	li	s1,0
    800010f8:	a889                	j	8000114a <allocproc+0x90>
  p->pid = allocpid();
    800010fa:	00000097          	auipc	ra,0x0
    800010fe:	e34080e7          	jalr	-460(ra) # 80000f2e <allocpid>
    80001102:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001104:	4785                	li	a5,1
    80001106:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001108:	fffff097          	auipc	ra,0xfffff
    8000110c:	012080e7          	jalr	18(ra) # 8000011a <kalloc>
    80001110:	892a                	mv	s2,a0
    80001112:	eca8                	sd	a0,88(s1)
    80001114:	c131                	beqz	a0,80001158 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001116:	8526                	mv	a0,s1
    80001118:	00000097          	auipc	ra,0x0
    8000111c:	e5c080e7          	jalr	-420(ra) # 80000f74 <proc_pagetable>
    80001120:	892a                	mv	s2,a0
    80001122:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001124:	c531                	beqz	a0,80001170 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001126:	07000613          	li	a2,112
    8000112a:	4581                	li	a1,0
    8000112c:	06048513          	addi	a0,s1,96
    80001130:	fffff097          	auipc	ra,0xfffff
    80001134:	04a080e7          	jalr	74(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    80001138:	00000797          	auipc	a5,0x0
    8000113c:	dac78793          	addi	a5,a5,-596 # 80000ee4 <forkret>
    80001140:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001142:	60bc                	ld	a5,64(s1)
    80001144:	6705                	lui	a4,0x1
    80001146:	97ba                	add	a5,a5,a4
    80001148:	f4bc                	sd	a5,104(s1)
}
    8000114a:	8526                	mv	a0,s1
    8000114c:	60e2                	ld	ra,24(sp)
    8000114e:	6442                	ld	s0,16(sp)
    80001150:	64a2                	ld	s1,8(sp)
    80001152:	6902                	ld	s2,0(sp)
    80001154:	6105                	addi	sp,sp,32
    80001156:	8082                	ret
    freeproc(p);
    80001158:	8526                	mv	a0,s1
    8000115a:	00000097          	auipc	ra,0x0
    8000115e:	f08080e7          	jalr	-248(ra) # 80001062 <freeproc>
    release(&p->lock);
    80001162:	8526                	mv	a0,s1
    80001164:	00005097          	auipc	ra,0x5
    80001168:	074080e7          	jalr	116(ra) # 800061d8 <release>
    return 0;
    8000116c:	84ca                	mv	s1,s2
    8000116e:	bff1                	j	8000114a <allocproc+0x90>
    freeproc(p);
    80001170:	8526                	mv	a0,s1
    80001172:	00000097          	auipc	ra,0x0
    80001176:	ef0080e7          	jalr	-272(ra) # 80001062 <freeproc>
    release(&p->lock);
    8000117a:	8526                	mv	a0,s1
    8000117c:	00005097          	auipc	ra,0x5
    80001180:	05c080e7          	jalr	92(ra) # 800061d8 <release>
    return 0;
    80001184:	84ca                	mv	s1,s2
    80001186:	b7d1                	j	8000114a <allocproc+0x90>

0000000080001188 <userinit>:
{
    80001188:	1101                	addi	sp,sp,-32
    8000118a:	ec06                	sd	ra,24(sp)
    8000118c:	e822                	sd	s0,16(sp)
    8000118e:	e426                	sd	s1,8(sp)
    80001190:	1000                	addi	s0,sp,32
  p = allocproc();
    80001192:	00000097          	auipc	ra,0x0
    80001196:	f28080e7          	jalr	-216(ra) # 800010ba <allocproc>
    8000119a:	84aa                	mv	s1,a0
  initproc = p;
    8000119c:	00007797          	auipc	a5,0x7
    800011a0:	76a7b223          	sd	a0,1892(a5) # 80008900 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800011a4:	03400613          	li	a2,52
    800011a8:	00007597          	auipc	a1,0x7
    800011ac:	6e858593          	addi	a1,a1,1768 # 80008890 <initcode>
    800011b0:	6928                	ld	a0,80(a0)
    800011b2:	fffff097          	auipc	ra,0xfffff
    800011b6:	670080e7          	jalr	1648(ra) # 80000822 <uvmfirst>
  p->sz = PGSIZE;
    800011ba:	6785                	lui	a5,0x1
    800011bc:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800011be:	6cb8                	ld	a4,88(s1)
    800011c0:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800011c4:	6cb8                	ld	a4,88(s1)
    800011c6:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800011c8:	4641                	li	a2,16
    800011ca:	00007597          	auipc	a1,0x7
    800011ce:	ff658593          	addi	a1,a1,-10 # 800081c0 <etext+0x1c0>
    800011d2:	15848513          	addi	a0,s1,344
    800011d6:	fffff097          	auipc	ra,0xfffff
    800011da:	0ee080e7          	jalr	238(ra) # 800002c4 <safestrcpy>
  p->cwd = namei("/");
    800011de:	00007517          	auipc	a0,0x7
    800011e2:	ff250513          	addi	a0,a0,-14 # 800081d0 <etext+0x1d0>
    800011e6:	00002097          	auipc	ra,0x2
    800011ea:	104080e7          	jalr	260(ra) # 800032ea <namei>
    800011ee:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800011f2:	478d                	li	a5,3
    800011f4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800011f6:	8526                	mv	a0,s1
    800011f8:	00005097          	auipc	ra,0x5
    800011fc:	fe0080e7          	jalr	-32(ra) # 800061d8 <release>
}
    80001200:	60e2                	ld	ra,24(sp)
    80001202:	6442                	ld	s0,16(sp)
    80001204:	64a2                	ld	s1,8(sp)
    80001206:	6105                	addi	sp,sp,32
    80001208:	8082                	ret

000000008000120a <growproc>:
{
    8000120a:	1101                	addi	sp,sp,-32
    8000120c:	ec06                	sd	ra,24(sp)
    8000120e:	e822                	sd	s0,16(sp)
    80001210:	e426                	sd	s1,8(sp)
    80001212:	e04a                	sd	s2,0(sp)
    80001214:	1000                	addi	s0,sp,32
    80001216:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001218:	00000097          	auipc	ra,0x0
    8000121c:	c94080e7          	jalr	-876(ra) # 80000eac <myproc>
    80001220:	84aa                	mv	s1,a0
  sz = p->sz;
    80001222:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001224:	01204c63          	bgtz	s2,8000123c <growproc+0x32>
  } else if(n < 0){
    80001228:	02094663          	bltz	s2,80001254 <growproc+0x4a>
  p->sz = sz;
    8000122c:	e4ac                	sd	a1,72(s1)
  return 0;
    8000122e:	4501                	li	a0,0
}
    80001230:	60e2                	ld	ra,24(sp)
    80001232:	6442                	ld	s0,16(sp)
    80001234:	64a2                	ld	s1,8(sp)
    80001236:	6902                	ld	s2,0(sp)
    80001238:	6105                	addi	sp,sp,32
    8000123a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    8000123c:	4691                	li	a3,4
    8000123e:	00b90633          	add	a2,s2,a1
    80001242:	6928                	ld	a0,80(a0)
    80001244:	fffff097          	auipc	ra,0xfffff
    80001248:	698080e7          	jalr	1688(ra) # 800008dc <uvmalloc>
    8000124c:	85aa                	mv	a1,a0
    8000124e:	fd79                	bnez	a0,8000122c <growproc+0x22>
      return -1;
    80001250:	557d                	li	a0,-1
    80001252:	bff9                	j	80001230 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001254:	00b90633          	add	a2,s2,a1
    80001258:	6928                	ld	a0,80(a0)
    8000125a:	fffff097          	auipc	ra,0xfffff
    8000125e:	63a080e7          	jalr	1594(ra) # 80000894 <uvmdealloc>
    80001262:	85aa                	mv	a1,a0
    80001264:	b7e1                	j	8000122c <growproc+0x22>

0000000080001266 <fork>:
{
    80001266:	7139                	addi	sp,sp,-64
    80001268:	fc06                	sd	ra,56(sp)
    8000126a:	f822                	sd	s0,48(sp)
    8000126c:	f426                	sd	s1,40(sp)
    8000126e:	f04a                	sd	s2,32(sp)
    80001270:	ec4e                	sd	s3,24(sp)
    80001272:	e852                	sd	s4,16(sp)
    80001274:	e456                	sd	s5,8(sp)
    80001276:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	c34080e7          	jalr	-972(ra) # 80000eac <myproc>
    80001280:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001282:	00000097          	auipc	ra,0x0
    80001286:	e38080e7          	jalr	-456(ra) # 800010ba <allocproc>
    8000128a:	10050c63          	beqz	a0,800013a2 <fork+0x13c>
    8000128e:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001290:	048ab603          	ld	a2,72(s5)
    80001294:	692c                	ld	a1,80(a0)
    80001296:	050ab503          	ld	a0,80(s5)
    8000129a:	fffff097          	auipc	ra,0xfffff
    8000129e:	79a080e7          	jalr	1946(ra) # 80000a34 <uvmcopy>
    800012a2:	04054863          	bltz	a0,800012f2 <fork+0x8c>
  np->sz = p->sz;
    800012a6:	048ab783          	ld	a5,72(s5)
    800012aa:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800012ae:	058ab683          	ld	a3,88(s5)
    800012b2:	87b6                	mv	a5,a3
    800012b4:	058a3703          	ld	a4,88(s4)
    800012b8:	12068693          	addi	a3,a3,288
    800012bc:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800012c0:	6788                	ld	a0,8(a5)
    800012c2:	6b8c                	ld	a1,16(a5)
    800012c4:	6f90                	ld	a2,24(a5)
    800012c6:	01073023          	sd	a6,0(a4)
    800012ca:	e708                	sd	a0,8(a4)
    800012cc:	eb0c                	sd	a1,16(a4)
    800012ce:	ef10                	sd	a2,24(a4)
    800012d0:	02078793          	addi	a5,a5,32
    800012d4:	02070713          	addi	a4,a4,32
    800012d8:	fed792e3          	bne	a5,a3,800012bc <fork+0x56>
  np->trapframe->a0 = 0;
    800012dc:	058a3783          	ld	a5,88(s4)
    800012e0:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    800012e4:	0d0a8493          	addi	s1,s5,208
    800012e8:	0d0a0913          	addi	s2,s4,208
    800012ec:	150a8993          	addi	s3,s5,336
    800012f0:	a00d                	j	80001312 <fork+0xac>
    freeproc(np);
    800012f2:	8552                	mv	a0,s4
    800012f4:	00000097          	auipc	ra,0x0
    800012f8:	d6e080e7          	jalr	-658(ra) # 80001062 <freeproc>
    release(&np->lock);
    800012fc:	8552                	mv	a0,s4
    800012fe:	00005097          	auipc	ra,0x5
    80001302:	eda080e7          	jalr	-294(ra) # 800061d8 <release>
    return -1;
    80001306:	597d                	li	s2,-1
    80001308:	a059                	j	8000138e <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    8000130a:	04a1                	addi	s1,s1,8
    8000130c:	0921                	addi	s2,s2,8
    8000130e:	01348b63          	beq	s1,s3,80001324 <fork+0xbe>
    if(p->ofile[i])
    80001312:	6088                	ld	a0,0(s1)
    80001314:	d97d                	beqz	a0,8000130a <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001316:	00002097          	auipc	ra,0x2
    8000131a:	66a080e7          	jalr	1642(ra) # 80003980 <filedup>
    8000131e:	00a93023          	sd	a0,0(s2)
    80001322:	b7e5                	j	8000130a <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001324:	150ab503          	ld	a0,336(s5)
    80001328:	00001097          	auipc	ra,0x1
    8000132c:	7d8080e7          	jalr	2008(ra) # 80002b00 <idup>
    80001330:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001334:	4641                	li	a2,16
    80001336:	158a8593          	addi	a1,s5,344
    8000133a:	158a0513          	addi	a0,s4,344
    8000133e:	fffff097          	auipc	ra,0xfffff
    80001342:	f86080e7          	jalr	-122(ra) # 800002c4 <safestrcpy>
  pid = np->pid;
    80001346:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    8000134a:	8552                	mv	a0,s4
    8000134c:	00005097          	auipc	ra,0x5
    80001350:	e8c080e7          	jalr	-372(ra) # 800061d8 <release>
  acquire(&wait_lock);
    80001354:	00007497          	auipc	s1,0x7
    80001358:	60448493          	addi	s1,s1,1540 # 80008958 <wait_lock>
    8000135c:	8526                	mv	a0,s1
    8000135e:	00005097          	auipc	ra,0x5
    80001362:	dc6080e7          	jalr	-570(ra) # 80006124 <acquire>
  np->parent = p;
    80001366:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    8000136a:	8526                	mv	a0,s1
    8000136c:	00005097          	auipc	ra,0x5
    80001370:	e6c080e7          	jalr	-404(ra) # 800061d8 <release>
  acquire(&np->lock);
    80001374:	8552                	mv	a0,s4
    80001376:	00005097          	auipc	ra,0x5
    8000137a:	dae080e7          	jalr	-594(ra) # 80006124 <acquire>
  np->state = RUNNABLE;
    8000137e:	478d                	li	a5,3
    80001380:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001384:	8552                	mv	a0,s4
    80001386:	00005097          	auipc	ra,0x5
    8000138a:	e52080e7          	jalr	-430(ra) # 800061d8 <release>
}
    8000138e:	854a                	mv	a0,s2
    80001390:	70e2                	ld	ra,56(sp)
    80001392:	7442                	ld	s0,48(sp)
    80001394:	74a2                	ld	s1,40(sp)
    80001396:	7902                	ld	s2,32(sp)
    80001398:	69e2                	ld	s3,24(sp)
    8000139a:	6a42                	ld	s4,16(sp)
    8000139c:	6aa2                	ld	s5,8(sp)
    8000139e:	6121                	addi	sp,sp,64
    800013a0:	8082                	ret
    return -1;
    800013a2:	597d                	li	s2,-1
    800013a4:	b7ed                	j	8000138e <fork+0x128>

00000000800013a6 <scheduler>:
{
    800013a6:	7139                	addi	sp,sp,-64
    800013a8:	fc06                	sd	ra,56(sp)
    800013aa:	f822                	sd	s0,48(sp)
    800013ac:	f426                	sd	s1,40(sp)
    800013ae:	f04a                	sd	s2,32(sp)
    800013b0:	ec4e                	sd	s3,24(sp)
    800013b2:	e852                	sd	s4,16(sp)
    800013b4:	e456                	sd	s5,8(sp)
    800013b6:	e05a                	sd	s6,0(sp)
    800013b8:	0080                	addi	s0,sp,64
    800013ba:	8792                	mv	a5,tp
  int id = r_tp();
    800013bc:	2781                	sext.w	a5,a5
  c->proc = 0;
    800013be:	00779a93          	slli	s5,a5,0x7
    800013c2:	00007717          	auipc	a4,0x7
    800013c6:	57e70713          	addi	a4,a4,1406 # 80008940 <pid_lock>
    800013ca:	9756                	add	a4,a4,s5
    800013cc:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800013d0:	00007717          	auipc	a4,0x7
    800013d4:	5a870713          	addi	a4,a4,1448 # 80008978 <cpus+0x8>
    800013d8:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    800013da:	498d                	li	s3,3
        p->state = RUNNING;
    800013dc:	4b11                	li	s6,4
        c->proc = p;
    800013de:	079e                	slli	a5,a5,0x7
    800013e0:	00007a17          	auipc	s4,0x7
    800013e4:	560a0a13          	addi	s4,s4,1376 # 80008940 <pid_lock>
    800013e8:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800013ea:	0000d917          	auipc	s2,0xd
    800013ee:	38690913          	addi	s2,s2,902 # 8000e770 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800013f2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800013f6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800013fa:	10079073          	csrw	sstatus,a5
    800013fe:	00008497          	auipc	s1,0x8
    80001402:	97248493          	addi	s1,s1,-1678 # 80008d70 <proc>
    80001406:	a811                	j	8000141a <scheduler+0x74>
      release(&p->lock);
    80001408:	8526                	mv	a0,s1
    8000140a:	00005097          	auipc	ra,0x5
    8000140e:	dce080e7          	jalr	-562(ra) # 800061d8 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001412:	16848493          	addi	s1,s1,360
    80001416:	fd248ee3          	beq	s1,s2,800013f2 <scheduler+0x4c>
      acquire(&p->lock);
    8000141a:	8526                	mv	a0,s1
    8000141c:	00005097          	auipc	ra,0x5
    80001420:	d08080e7          	jalr	-760(ra) # 80006124 <acquire>
      if(p->state == RUNNABLE) {
    80001424:	4c9c                	lw	a5,24(s1)
    80001426:	ff3791e3          	bne	a5,s3,80001408 <scheduler+0x62>
        p->state = RUNNING;
    8000142a:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    8000142e:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001432:	06048593          	addi	a1,s1,96
    80001436:	8556                	mv	a0,s5
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	684080e7          	jalr	1668(ra) # 80001abc <swtch>
        c->proc = 0;
    80001440:	020a3823          	sd	zero,48(s4)
    80001444:	b7d1                	j	80001408 <scheduler+0x62>

0000000080001446 <sched>:
{
    80001446:	7179                	addi	sp,sp,-48
    80001448:	f406                	sd	ra,40(sp)
    8000144a:	f022                	sd	s0,32(sp)
    8000144c:	ec26                	sd	s1,24(sp)
    8000144e:	e84a                	sd	s2,16(sp)
    80001450:	e44e                	sd	s3,8(sp)
    80001452:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001454:	00000097          	auipc	ra,0x0
    80001458:	a58080e7          	jalr	-1448(ra) # 80000eac <myproc>
    8000145c:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000145e:	00005097          	auipc	ra,0x5
    80001462:	c4c080e7          	jalr	-948(ra) # 800060aa <holding>
    80001466:	c93d                	beqz	a0,800014dc <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001468:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000146a:	2781                	sext.w	a5,a5
    8000146c:	079e                	slli	a5,a5,0x7
    8000146e:	00007717          	auipc	a4,0x7
    80001472:	4d270713          	addi	a4,a4,1234 # 80008940 <pid_lock>
    80001476:	97ba                	add	a5,a5,a4
    80001478:	0a87a703          	lw	a4,168(a5)
    8000147c:	4785                	li	a5,1
    8000147e:	06f71763          	bne	a4,a5,800014ec <sched+0xa6>
  if(p->state == RUNNING)
    80001482:	4c98                	lw	a4,24(s1)
    80001484:	4791                	li	a5,4
    80001486:	06f70b63          	beq	a4,a5,800014fc <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000148a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000148e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001490:	efb5                	bnez	a5,8000150c <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001492:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001494:	00007917          	auipc	s2,0x7
    80001498:	4ac90913          	addi	s2,s2,1196 # 80008940 <pid_lock>
    8000149c:	2781                	sext.w	a5,a5
    8000149e:	079e                	slli	a5,a5,0x7
    800014a0:	97ca                	add	a5,a5,s2
    800014a2:	0ac7a983          	lw	s3,172(a5)
    800014a6:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800014a8:	2781                	sext.w	a5,a5
    800014aa:	079e                	slli	a5,a5,0x7
    800014ac:	00007597          	auipc	a1,0x7
    800014b0:	4cc58593          	addi	a1,a1,1228 # 80008978 <cpus+0x8>
    800014b4:	95be                	add	a1,a1,a5
    800014b6:	06048513          	addi	a0,s1,96
    800014ba:	00000097          	auipc	ra,0x0
    800014be:	602080e7          	jalr	1538(ra) # 80001abc <swtch>
    800014c2:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800014c4:	2781                	sext.w	a5,a5
    800014c6:	079e                	slli	a5,a5,0x7
    800014c8:	993e                	add	s2,s2,a5
    800014ca:	0b392623          	sw	s3,172(s2)
}
    800014ce:	70a2                	ld	ra,40(sp)
    800014d0:	7402                	ld	s0,32(sp)
    800014d2:	64e2                	ld	s1,24(sp)
    800014d4:	6942                	ld	s2,16(sp)
    800014d6:	69a2                	ld	s3,8(sp)
    800014d8:	6145                	addi	sp,sp,48
    800014da:	8082                	ret
    panic("sched p->lock");
    800014dc:	00007517          	auipc	a0,0x7
    800014e0:	cfc50513          	addi	a0,a0,-772 # 800081d8 <etext+0x1d8>
    800014e4:	00004097          	auipc	ra,0x4
    800014e8:	708080e7          	jalr	1800(ra) # 80005bec <panic>
    panic("sched locks");
    800014ec:	00007517          	auipc	a0,0x7
    800014f0:	cfc50513          	addi	a0,a0,-772 # 800081e8 <etext+0x1e8>
    800014f4:	00004097          	auipc	ra,0x4
    800014f8:	6f8080e7          	jalr	1784(ra) # 80005bec <panic>
    panic("sched running");
    800014fc:	00007517          	auipc	a0,0x7
    80001500:	cfc50513          	addi	a0,a0,-772 # 800081f8 <etext+0x1f8>
    80001504:	00004097          	auipc	ra,0x4
    80001508:	6e8080e7          	jalr	1768(ra) # 80005bec <panic>
    panic("sched interruptible");
    8000150c:	00007517          	auipc	a0,0x7
    80001510:	cfc50513          	addi	a0,a0,-772 # 80008208 <etext+0x208>
    80001514:	00004097          	auipc	ra,0x4
    80001518:	6d8080e7          	jalr	1752(ra) # 80005bec <panic>

000000008000151c <yield>:
{
    8000151c:	1101                	addi	sp,sp,-32
    8000151e:	ec06                	sd	ra,24(sp)
    80001520:	e822                	sd	s0,16(sp)
    80001522:	e426                	sd	s1,8(sp)
    80001524:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001526:	00000097          	auipc	ra,0x0
    8000152a:	986080e7          	jalr	-1658(ra) # 80000eac <myproc>
    8000152e:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001530:	00005097          	auipc	ra,0x5
    80001534:	bf4080e7          	jalr	-1036(ra) # 80006124 <acquire>
  p->state = RUNNABLE;
    80001538:	478d                	li	a5,3
    8000153a:	cc9c                	sw	a5,24(s1)
  sched();
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	f0a080e7          	jalr	-246(ra) # 80001446 <sched>
  release(&p->lock);
    80001544:	8526                	mv	a0,s1
    80001546:	00005097          	auipc	ra,0x5
    8000154a:	c92080e7          	jalr	-878(ra) # 800061d8 <release>
}
    8000154e:	60e2                	ld	ra,24(sp)
    80001550:	6442                	ld	s0,16(sp)
    80001552:	64a2                	ld	s1,8(sp)
    80001554:	6105                	addi	sp,sp,32
    80001556:	8082                	ret

0000000080001558 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001558:	7179                	addi	sp,sp,-48
    8000155a:	f406                	sd	ra,40(sp)
    8000155c:	f022                	sd	s0,32(sp)
    8000155e:	ec26                	sd	s1,24(sp)
    80001560:	e84a                	sd	s2,16(sp)
    80001562:	e44e                	sd	s3,8(sp)
    80001564:	1800                	addi	s0,sp,48
    80001566:	89aa                	mv	s3,a0
    80001568:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000156a:	00000097          	auipc	ra,0x0
    8000156e:	942080e7          	jalr	-1726(ra) # 80000eac <myproc>
    80001572:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001574:	00005097          	auipc	ra,0x5
    80001578:	bb0080e7          	jalr	-1104(ra) # 80006124 <acquire>
  release(lk);
    8000157c:	854a                	mv	a0,s2
    8000157e:	00005097          	auipc	ra,0x5
    80001582:	c5a080e7          	jalr	-934(ra) # 800061d8 <release>

  // Go to sleep.
  p->chan = chan;
    80001586:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000158a:	4789                	li	a5,2
    8000158c:	cc9c                	sw	a5,24(s1)

  sched();
    8000158e:	00000097          	auipc	ra,0x0
    80001592:	eb8080e7          	jalr	-328(ra) # 80001446 <sched>

  // Tidy up.
  p->chan = 0;
    80001596:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000159a:	8526                	mv	a0,s1
    8000159c:	00005097          	auipc	ra,0x5
    800015a0:	c3c080e7          	jalr	-964(ra) # 800061d8 <release>
  acquire(lk);
    800015a4:	854a                	mv	a0,s2
    800015a6:	00005097          	auipc	ra,0x5
    800015aa:	b7e080e7          	jalr	-1154(ra) # 80006124 <acquire>
}
    800015ae:	70a2                	ld	ra,40(sp)
    800015b0:	7402                	ld	s0,32(sp)
    800015b2:	64e2                	ld	s1,24(sp)
    800015b4:	6942                	ld	s2,16(sp)
    800015b6:	69a2                	ld	s3,8(sp)
    800015b8:	6145                	addi	sp,sp,48
    800015ba:	8082                	ret

00000000800015bc <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800015bc:	7139                	addi	sp,sp,-64
    800015be:	fc06                	sd	ra,56(sp)
    800015c0:	f822                	sd	s0,48(sp)
    800015c2:	f426                	sd	s1,40(sp)
    800015c4:	f04a                	sd	s2,32(sp)
    800015c6:	ec4e                	sd	s3,24(sp)
    800015c8:	e852                	sd	s4,16(sp)
    800015ca:	e456                	sd	s5,8(sp)
    800015cc:	0080                	addi	s0,sp,64
    800015ce:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800015d0:	00007497          	auipc	s1,0x7
    800015d4:	7a048493          	addi	s1,s1,1952 # 80008d70 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800015d8:	4989                	li	s3,2
        p->state = RUNNABLE;
    800015da:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800015dc:	0000d917          	auipc	s2,0xd
    800015e0:	19490913          	addi	s2,s2,404 # 8000e770 <tickslock>
    800015e4:	a811                	j	800015f8 <wakeup+0x3c>
      }
      release(&p->lock);
    800015e6:	8526                	mv	a0,s1
    800015e8:	00005097          	auipc	ra,0x5
    800015ec:	bf0080e7          	jalr	-1040(ra) # 800061d8 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800015f0:	16848493          	addi	s1,s1,360
    800015f4:	03248663          	beq	s1,s2,80001620 <wakeup+0x64>
    if(p != myproc()){
    800015f8:	00000097          	auipc	ra,0x0
    800015fc:	8b4080e7          	jalr	-1868(ra) # 80000eac <myproc>
    80001600:	fea488e3          	beq	s1,a0,800015f0 <wakeup+0x34>
      acquire(&p->lock);
    80001604:	8526                	mv	a0,s1
    80001606:	00005097          	auipc	ra,0x5
    8000160a:	b1e080e7          	jalr	-1250(ra) # 80006124 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000160e:	4c9c                	lw	a5,24(s1)
    80001610:	fd379be3          	bne	a5,s3,800015e6 <wakeup+0x2a>
    80001614:	709c                	ld	a5,32(s1)
    80001616:	fd4798e3          	bne	a5,s4,800015e6 <wakeup+0x2a>
        p->state = RUNNABLE;
    8000161a:	0154ac23          	sw	s5,24(s1)
    8000161e:	b7e1                	j	800015e6 <wakeup+0x2a>
    }
  }
}
    80001620:	70e2                	ld	ra,56(sp)
    80001622:	7442                	ld	s0,48(sp)
    80001624:	74a2                	ld	s1,40(sp)
    80001626:	7902                	ld	s2,32(sp)
    80001628:	69e2                	ld	s3,24(sp)
    8000162a:	6a42                	ld	s4,16(sp)
    8000162c:	6aa2                	ld	s5,8(sp)
    8000162e:	6121                	addi	sp,sp,64
    80001630:	8082                	ret

0000000080001632 <reparent>:
{
    80001632:	7179                	addi	sp,sp,-48
    80001634:	f406                	sd	ra,40(sp)
    80001636:	f022                	sd	s0,32(sp)
    80001638:	ec26                	sd	s1,24(sp)
    8000163a:	e84a                	sd	s2,16(sp)
    8000163c:	e44e                	sd	s3,8(sp)
    8000163e:	e052                	sd	s4,0(sp)
    80001640:	1800                	addi	s0,sp,48
    80001642:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001644:	00007497          	auipc	s1,0x7
    80001648:	72c48493          	addi	s1,s1,1836 # 80008d70 <proc>
      pp->parent = initproc;
    8000164c:	00007a17          	auipc	s4,0x7
    80001650:	2b4a0a13          	addi	s4,s4,692 # 80008900 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001654:	0000d997          	auipc	s3,0xd
    80001658:	11c98993          	addi	s3,s3,284 # 8000e770 <tickslock>
    8000165c:	a029                	j	80001666 <reparent+0x34>
    8000165e:	16848493          	addi	s1,s1,360
    80001662:	01348d63          	beq	s1,s3,8000167c <reparent+0x4a>
    if(pp->parent == p){
    80001666:	7c9c                	ld	a5,56(s1)
    80001668:	ff279be3          	bne	a5,s2,8000165e <reparent+0x2c>
      pp->parent = initproc;
    8000166c:	000a3503          	ld	a0,0(s4)
    80001670:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001672:	00000097          	auipc	ra,0x0
    80001676:	f4a080e7          	jalr	-182(ra) # 800015bc <wakeup>
    8000167a:	b7d5                	j	8000165e <reparent+0x2c>
}
    8000167c:	70a2                	ld	ra,40(sp)
    8000167e:	7402                	ld	s0,32(sp)
    80001680:	64e2                	ld	s1,24(sp)
    80001682:	6942                	ld	s2,16(sp)
    80001684:	69a2                	ld	s3,8(sp)
    80001686:	6a02                	ld	s4,0(sp)
    80001688:	6145                	addi	sp,sp,48
    8000168a:	8082                	ret

000000008000168c <exit>:
{
    8000168c:	7179                	addi	sp,sp,-48
    8000168e:	f406                	sd	ra,40(sp)
    80001690:	f022                	sd	s0,32(sp)
    80001692:	ec26                	sd	s1,24(sp)
    80001694:	e84a                	sd	s2,16(sp)
    80001696:	e44e                	sd	s3,8(sp)
    80001698:	e052                	sd	s4,0(sp)
    8000169a:	1800                	addi	s0,sp,48
    8000169c:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000169e:	00000097          	auipc	ra,0x0
    800016a2:	80e080e7          	jalr	-2034(ra) # 80000eac <myproc>
    800016a6:	89aa                	mv	s3,a0
  if(p == initproc)
    800016a8:	00007797          	auipc	a5,0x7
    800016ac:	2587b783          	ld	a5,600(a5) # 80008900 <initproc>
    800016b0:	0d050493          	addi	s1,a0,208
    800016b4:	15050913          	addi	s2,a0,336
    800016b8:	02a79363          	bne	a5,a0,800016de <exit+0x52>
    panic("init exiting");
    800016bc:	00007517          	auipc	a0,0x7
    800016c0:	b6450513          	addi	a0,a0,-1180 # 80008220 <etext+0x220>
    800016c4:	00004097          	auipc	ra,0x4
    800016c8:	528080e7          	jalr	1320(ra) # 80005bec <panic>
      fileclose(f);
    800016cc:	00002097          	auipc	ra,0x2
    800016d0:	306080e7          	jalr	774(ra) # 800039d2 <fileclose>
      p->ofile[fd] = 0;
    800016d4:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800016d8:	04a1                	addi	s1,s1,8
    800016da:	01248563          	beq	s1,s2,800016e4 <exit+0x58>
    if(p->ofile[fd]){
    800016de:	6088                	ld	a0,0(s1)
    800016e0:	f575                	bnez	a0,800016cc <exit+0x40>
    800016e2:	bfdd                	j	800016d8 <exit+0x4c>
  begin_op();
    800016e4:	00002097          	auipc	ra,0x2
    800016e8:	e26080e7          	jalr	-474(ra) # 8000350a <begin_op>
  iput(p->cwd);
    800016ec:	1509b503          	ld	a0,336(s3)
    800016f0:	00001097          	auipc	ra,0x1
    800016f4:	608080e7          	jalr	1544(ra) # 80002cf8 <iput>
  end_op();
    800016f8:	00002097          	auipc	ra,0x2
    800016fc:	e90080e7          	jalr	-368(ra) # 80003588 <end_op>
  p->cwd = 0;
    80001700:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001704:	00007497          	auipc	s1,0x7
    80001708:	25448493          	addi	s1,s1,596 # 80008958 <wait_lock>
    8000170c:	8526                	mv	a0,s1
    8000170e:	00005097          	auipc	ra,0x5
    80001712:	a16080e7          	jalr	-1514(ra) # 80006124 <acquire>
  reparent(p);
    80001716:	854e                	mv	a0,s3
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	f1a080e7          	jalr	-230(ra) # 80001632 <reparent>
  wakeup(p->parent);
    80001720:	0389b503          	ld	a0,56(s3)
    80001724:	00000097          	auipc	ra,0x0
    80001728:	e98080e7          	jalr	-360(ra) # 800015bc <wakeup>
  acquire(&p->lock);
    8000172c:	854e                	mv	a0,s3
    8000172e:	00005097          	auipc	ra,0x5
    80001732:	9f6080e7          	jalr	-1546(ra) # 80006124 <acquire>
  p->xstate = status;
    80001736:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000173a:	4795                	li	a5,5
    8000173c:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001740:	8526                	mv	a0,s1
    80001742:	00005097          	auipc	ra,0x5
    80001746:	a96080e7          	jalr	-1386(ra) # 800061d8 <release>
  sched();
    8000174a:	00000097          	auipc	ra,0x0
    8000174e:	cfc080e7          	jalr	-772(ra) # 80001446 <sched>
  panic("zombie exit");
    80001752:	00007517          	auipc	a0,0x7
    80001756:	ade50513          	addi	a0,a0,-1314 # 80008230 <etext+0x230>
    8000175a:	00004097          	auipc	ra,0x4
    8000175e:	492080e7          	jalr	1170(ra) # 80005bec <panic>

0000000080001762 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001762:	7179                	addi	sp,sp,-48
    80001764:	f406                	sd	ra,40(sp)
    80001766:	f022                	sd	s0,32(sp)
    80001768:	ec26                	sd	s1,24(sp)
    8000176a:	e84a                	sd	s2,16(sp)
    8000176c:	e44e                	sd	s3,8(sp)
    8000176e:	1800                	addi	s0,sp,48
    80001770:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001772:	00007497          	auipc	s1,0x7
    80001776:	5fe48493          	addi	s1,s1,1534 # 80008d70 <proc>
    8000177a:	0000d997          	auipc	s3,0xd
    8000177e:	ff698993          	addi	s3,s3,-10 # 8000e770 <tickslock>
    acquire(&p->lock);
    80001782:	8526                	mv	a0,s1
    80001784:	00005097          	auipc	ra,0x5
    80001788:	9a0080e7          	jalr	-1632(ra) # 80006124 <acquire>
    if(p->pid == pid){
    8000178c:	589c                	lw	a5,48(s1)
    8000178e:	01278d63          	beq	a5,s2,800017a8 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001792:	8526                	mv	a0,s1
    80001794:	00005097          	auipc	ra,0x5
    80001798:	a44080e7          	jalr	-1468(ra) # 800061d8 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000179c:	16848493          	addi	s1,s1,360
    800017a0:	ff3491e3          	bne	s1,s3,80001782 <kill+0x20>
  }
  return -1;
    800017a4:	557d                	li	a0,-1
    800017a6:	a829                	j	800017c0 <kill+0x5e>
      p->killed = 1;
    800017a8:	4785                	li	a5,1
    800017aa:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800017ac:	4c98                	lw	a4,24(s1)
    800017ae:	4789                	li	a5,2
    800017b0:	00f70f63          	beq	a4,a5,800017ce <kill+0x6c>
      release(&p->lock);
    800017b4:	8526                	mv	a0,s1
    800017b6:	00005097          	auipc	ra,0x5
    800017ba:	a22080e7          	jalr	-1502(ra) # 800061d8 <release>
      return 0;
    800017be:	4501                	li	a0,0
}
    800017c0:	70a2                	ld	ra,40(sp)
    800017c2:	7402                	ld	s0,32(sp)
    800017c4:	64e2                	ld	s1,24(sp)
    800017c6:	6942                	ld	s2,16(sp)
    800017c8:	69a2                	ld	s3,8(sp)
    800017ca:	6145                	addi	sp,sp,48
    800017cc:	8082                	ret
        p->state = RUNNABLE;
    800017ce:	478d                	li	a5,3
    800017d0:	cc9c                	sw	a5,24(s1)
    800017d2:	b7cd                	j	800017b4 <kill+0x52>

00000000800017d4 <setkilled>:

void
setkilled(struct proc *p)
{
    800017d4:	1101                	addi	sp,sp,-32
    800017d6:	ec06                	sd	ra,24(sp)
    800017d8:	e822                	sd	s0,16(sp)
    800017da:	e426                	sd	s1,8(sp)
    800017dc:	1000                	addi	s0,sp,32
    800017de:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800017e0:	00005097          	auipc	ra,0x5
    800017e4:	944080e7          	jalr	-1724(ra) # 80006124 <acquire>
  p->killed = 1;
    800017e8:	4785                	li	a5,1
    800017ea:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    800017ec:	8526                	mv	a0,s1
    800017ee:	00005097          	auipc	ra,0x5
    800017f2:	9ea080e7          	jalr	-1558(ra) # 800061d8 <release>
}
    800017f6:	60e2                	ld	ra,24(sp)
    800017f8:	6442                	ld	s0,16(sp)
    800017fa:	64a2                	ld	s1,8(sp)
    800017fc:	6105                	addi	sp,sp,32
    800017fe:	8082                	ret

0000000080001800 <killed>:

int
killed(struct proc *p)
{
    80001800:	1101                	addi	sp,sp,-32
    80001802:	ec06                	sd	ra,24(sp)
    80001804:	e822                	sd	s0,16(sp)
    80001806:	e426                	sd	s1,8(sp)
    80001808:	e04a                	sd	s2,0(sp)
    8000180a:	1000                	addi	s0,sp,32
    8000180c:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    8000180e:	00005097          	auipc	ra,0x5
    80001812:	916080e7          	jalr	-1770(ra) # 80006124 <acquire>
  k = p->killed;
    80001816:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    8000181a:	8526                	mv	a0,s1
    8000181c:	00005097          	auipc	ra,0x5
    80001820:	9bc080e7          	jalr	-1604(ra) # 800061d8 <release>
  return k;
}
    80001824:	854a                	mv	a0,s2
    80001826:	60e2                	ld	ra,24(sp)
    80001828:	6442                	ld	s0,16(sp)
    8000182a:	64a2                	ld	s1,8(sp)
    8000182c:	6902                	ld	s2,0(sp)
    8000182e:	6105                	addi	sp,sp,32
    80001830:	8082                	ret

0000000080001832 <wait>:
{
    80001832:	715d                	addi	sp,sp,-80
    80001834:	e486                	sd	ra,72(sp)
    80001836:	e0a2                	sd	s0,64(sp)
    80001838:	fc26                	sd	s1,56(sp)
    8000183a:	f84a                	sd	s2,48(sp)
    8000183c:	f44e                	sd	s3,40(sp)
    8000183e:	f052                	sd	s4,32(sp)
    80001840:	ec56                	sd	s5,24(sp)
    80001842:	e85a                	sd	s6,16(sp)
    80001844:	e45e                	sd	s7,8(sp)
    80001846:	e062                	sd	s8,0(sp)
    80001848:	0880                	addi	s0,sp,80
    8000184a:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    8000184c:	fffff097          	auipc	ra,0xfffff
    80001850:	660080e7          	jalr	1632(ra) # 80000eac <myproc>
    80001854:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001856:	00007517          	auipc	a0,0x7
    8000185a:	10250513          	addi	a0,a0,258 # 80008958 <wait_lock>
    8000185e:	00005097          	auipc	ra,0x5
    80001862:	8c6080e7          	jalr	-1850(ra) # 80006124 <acquire>
    havekids = 0;
    80001866:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    80001868:	4a15                	li	s4,5
        havekids = 1;
    8000186a:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000186c:	0000d997          	auipc	s3,0xd
    80001870:	f0498993          	addi	s3,s3,-252 # 8000e770 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001874:	00007c17          	auipc	s8,0x7
    80001878:	0e4c0c13          	addi	s8,s8,228 # 80008958 <wait_lock>
    havekids = 0;
    8000187c:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000187e:	00007497          	auipc	s1,0x7
    80001882:	4f248493          	addi	s1,s1,1266 # 80008d70 <proc>
    80001886:	a0bd                	j	800018f4 <wait+0xc2>
          pid = pp->pid;
    80001888:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    8000188c:	000b0e63          	beqz	s6,800018a8 <wait+0x76>
    80001890:	4691                	li	a3,4
    80001892:	02c48613          	addi	a2,s1,44
    80001896:	85da                	mv	a1,s6
    80001898:	05093503          	ld	a0,80(s2)
    8000189c:	fffff097          	auipc	ra,0xfffff
    800018a0:	29c080e7          	jalr	668(ra) # 80000b38 <copyout>
    800018a4:	02054563          	bltz	a0,800018ce <wait+0x9c>
          freeproc(pp);
    800018a8:	8526                	mv	a0,s1
    800018aa:	fffff097          	auipc	ra,0xfffff
    800018ae:	7b8080e7          	jalr	1976(ra) # 80001062 <freeproc>
          release(&pp->lock);
    800018b2:	8526                	mv	a0,s1
    800018b4:	00005097          	auipc	ra,0x5
    800018b8:	924080e7          	jalr	-1756(ra) # 800061d8 <release>
          release(&wait_lock);
    800018bc:	00007517          	auipc	a0,0x7
    800018c0:	09c50513          	addi	a0,a0,156 # 80008958 <wait_lock>
    800018c4:	00005097          	auipc	ra,0x5
    800018c8:	914080e7          	jalr	-1772(ra) # 800061d8 <release>
          return pid;
    800018cc:	a0b5                	j	80001938 <wait+0x106>
            release(&pp->lock);
    800018ce:	8526                	mv	a0,s1
    800018d0:	00005097          	auipc	ra,0x5
    800018d4:	908080e7          	jalr	-1784(ra) # 800061d8 <release>
            release(&wait_lock);
    800018d8:	00007517          	auipc	a0,0x7
    800018dc:	08050513          	addi	a0,a0,128 # 80008958 <wait_lock>
    800018e0:	00005097          	auipc	ra,0x5
    800018e4:	8f8080e7          	jalr	-1800(ra) # 800061d8 <release>
            return -1;
    800018e8:	59fd                	li	s3,-1
    800018ea:	a0b9                	j	80001938 <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800018ec:	16848493          	addi	s1,s1,360
    800018f0:	03348463          	beq	s1,s3,80001918 <wait+0xe6>
      if(pp->parent == p){
    800018f4:	7c9c                	ld	a5,56(s1)
    800018f6:	ff279be3          	bne	a5,s2,800018ec <wait+0xba>
        acquire(&pp->lock);
    800018fa:	8526                	mv	a0,s1
    800018fc:	00005097          	auipc	ra,0x5
    80001900:	828080e7          	jalr	-2008(ra) # 80006124 <acquire>
        if(pp->state == ZOMBIE){
    80001904:	4c9c                	lw	a5,24(s1)
    80001906:	f94781e3          	beq	a5,s4,80001888 <wait+0x56>
        release(&pp->lock);
    8000190a:	8526                	mv	a0,s1
    8000190c:	00005097          	auipc	ra,0x5
    80001910:	8cc080e7          	jalr	-1844(ra) # 800061d8 <release>
        havekids = 1;
    80001914:	8756                	mv	a4,s5
    80001916:	bfd9                	j	800018ec <wait+0xba>
    if(!havekids || killed(p)){
    80001918:	c719                	beqz	a4,80001926 <wait+0xf4>
    8000191a:	854a                	mv	a0,s2
    8000191c:	00000097          	auipc	ra,0x0
    80001920:	ee4080e7          	jalr	-284(ra) # 80001800 <killed>
    80001924:	c51d                	beqz	a0,80001952 <wait+0x120>
      release(&wait_lock);
    80001926:	00007517          	auipc	a0,0x7
    8000192a:	03250513          	addi	a0,a0,50 # 80008958 <wait_lock>
    8000192e:	00005097          	auipc	ra,0x5
    80001932:	8aa080e7          	jalr	-1878(ra) # 800061d8 <release>
      return -1;
    80001936:	59fd                	li	s3,-1
}
    80001938:	854e                	mv	a0,s3
    8000193a:	60a6                	ld	ra,72(sp)
    8000193c:	6406                	ld	s0,64(sp)
    8000193e:	74e2                	ld	s1,56(sp)
    80001940:	7942                	ld	s2,48(sp)
    80001942:	79a2                	ld	s3,40(sp)
    80001944:	7a02                	ld	s4,32(sp)
    80001946:	6ae2                	ld	s5,24(sp)
    80001948:	6b42                	ld	s6,16(sp)
    8000194a:	6ba2                	ld	s7,8(sp)
    8000194c:	6c02                	ld	s8,0(sp)
    8000194e:	6161                	addi	sp,sp,80
    80001950:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001952:	85e2                	mv	a1,s8
    80001954:	854a                	mv	a0,s2
    80001956:	00000097          	auipc	ra,0x0
    8000195a:	c02080e7          	jalr	-1022(ra) # 80001558 <sleep>
    havekids = 0;
    8000195e:	bf39                	j	8000187c <wait+0x4a>

0000000080001960 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001960:	7179                	addi	sp,sp,-48
    80001962:	f406                	sd	ra,40(sp)
    80001964:	f022                	sd	s0,32(sp)
    80001966:	ec26                	sd	s1,24(sp)
    80001968:	e84a                	sd	s2,16(sp)
    8000196a:	e44e                	sd	s3,8(sp)
    8000196c:	e052                	sd	s4,0(sp)
    8000196e:	1800                	addi	s0,sp,48
    80001970:	84aa                	mv	s1,a0
    80001972:	892e                	mv	s2,a1
    80001974:	89b2                	mv	s3,a2
    80001976:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001978:	fffff097          	auipc	ra,0xfffff
    8000197c:	534080e7          	jalr	1332(ra) # 80000eac <myproc>
  if(user_dst){
    80001980:	c08d                	beqz	s1,800019a2 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001982:	86d2                	mv	a3,s4
    80001984:	864e                	mv	a2,s3
    80001986:	85ca                	mv	a1,s2
    80001988:	6928                	ld	a0,80(a0)
    8000198a:	fffff097          	auipc	ra,0xfffff
    8000198e:	1ae080e7          	jalr	430(ra) # 80000b38 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001992:	70a2                	ld	ra,40(sp)
    80001994:	7402                	ld	s0,32(sp)
    80001996:	64e2                	ld	s1,24(sp)
    80001998:	6942                	ld	s2,16(sp)
    8000199a:	69a2                	ld	s3,8(sp)
    8000199c:	6a02                	ld	s4,0(sp)
    8000199e:	6145                	addi	sp,sp,48
    800019a0:	8082                	ret
    memmove((char *)dst, src, len);
    800019a2:	000a061b          	sext.w	a2,s4
    800019a6:	85ce                	mv	a1,s3
    800019a8:	854a                	mv	a0,s2
    800019aa:	fffff097          	auipc	ra,0xfffff
    800019ae:	82c080e7          	jalr	-2004(ra) # 800001d6 <memmove>
    return 0;
    800019b2:	8526                	mv	a0,s1
    800019b4:	bff9                	j	80001992 <either_copyout+0x32>

00000000800019b6 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800019b6:	7179                	addi	sp,sp,-48
    800019b8:	f406                	sd	ra,40(sp)
    800019ba:	f022                	sd	s0,32(sp)
    800019bc:	ec26                	sd	s1,24(sp)
    800019be:	e84a                	sd	s2,16(sp)
    800019c0:	e44e                	sd	s3,8(sp)
    800019c2:	e052                	sd	s4,0(sp)
    800019c4:	1800                	addi	s0,sp,48
    800019c6:	892a                	mv	s2,a0
    800019c8:	84ae                	mv	s1,a1
    800019ca:	89b2                	mv	s3,a2
    800019cc:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019ce:	fffff097          	auipc	ra,0xfffff
    800019d2:	4de080e7          	jalr	1246(ra) # 80000eac <myproc>
  if(user_src){
    800019d6:	c08d                	beqz	s1,800019f8 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800019d8:	86d2                	mv	a3,s4
    800019da:	864e                	mv	a2,s3
    800019dc:	85ca                	mv	a1,s2
    800019de:	6928                	ld	a0,80(a0)
    800019e0:	fffff097          	auipc	ra,0xfffff
    800019e4:	218080e7          	jalr	536(ra) # 80000bf8 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800019e8:	70a2                	ld	ra,40(sp)
    800019ea:	7402                	ld	s0,32(sp)
    800019ec:	64e2                	ld	s1,24(sp)
    800019ee:	6942                	ld	s2,16(sp)
    800019f0:	69a2                	ld	s3,8(sp)
    800019f2:	6a02                	ld	s4,0(sp)
    800019f4:	6145                	addi	sp,sp,48
    800019f6:	8082                	ret
    memmove(dst, (char*)src, len);
    800019f8:	000a061b          	sext.w	a2,s4
    800019fc:	85ce                	mv	a1,s3
    800019fe:	854a                	mv	a0,s2
    80001a00:	ffffe097          	auipc	ra,0xffffe
    80001a04:	7d6080e7          	jalr	2006(ra) # 800001d6 <memmove>
    return 0;
    80001a08:	8526                	mv	a0,s1
    80001a0a:	bff9                	j	800019e8 <either_copyin+0x32>

0000000080001a0c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a0c:	715d                	addi	sp,sp,-80
    80001a0e:	e486                	sd	ra,72(sp)
    80001a10:	e0a2                	sd	s0,64(sp)
    80001a12:	fc26                	sd	s1,56(sp)
    80001a14:	f84a                	sd	s2,48(sp)
    80001a16:	f44e                	sd	s3,40(sp)
    80001a18:	f052                	sd	s4,32(sp)
    80001a1a:	ec56                	sd	s5,24(sp)
    80001a1c:	e85a                	sd	s6,16(sp)
    80001a1e:	e45e                	sd	s7,8(sp)
    80001a20:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a22:	00006517          	auipc	a0,0x6
    80001a26:	62650513          	addi	a0,a0,1574 # 80008048 <etext+0x48>
    80001a2a:	00004097          	auipc	ra,0x4
    80001a2e:	20c080e7          	jalr	524(ra) # 80005c36 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a32:	00007497          	auipc	s1,0x7
    80001a36:	49648493          	addi	s1,s1,1174 # 80008ec8 <proc+0x158>
    80001a3a:	0000d917          	auipc	s2,0xd
    80001a3e:	e8e90913          	addi	s2,s2,-370 # 8000e8c8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a42:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001a44:	00006997          	auipc	s3,0x6
    80001a48:	7fc98993          	addi	s3,s3,2044 # 80008240 <etext+0x240>
    printf("%d %s %s", p->pid, state, p->name);
    80001a4c:	00006a97          	auipc	s5,0x6
    80001a50:	7fca8a93          	addi	s5,s5,2044 # 80008248 <etext+0x248>
    printf("\n");
    80001a54:	00006a17          	auipc	s4,0x6
    80001a58:	5f4a0a13          	addi	s4,s4,1524 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a5c:	00007b97          	auipc	s7,0x7
    80001a60:	82cb8b93          	addi	s7,s7,-2004 # 80008288 <states.0>
    80001a64:	a00d                	j	80001a86 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a66:	ed86a583          	lw	a1,-296(a3)
    80001a6a:	8556                	mv	a0,s5
    80001a6c:	00004097          	auipc	ra,0x4
    80001a70:	1ca080e7          	jalr	458(ra) # 80005c36 <printf>
    printf("\n");
    80001a74:	8552                	mv	a0,s4
    80001a76:	00004097          	auipc	ra,0x4
    80001a7a:	1c0080e7          	jalr	448(ra) # 80005c36 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a7e:	16848493          	addi	s1,s1,360
    80001a82:	03248263          	beq	s1,s2,80001aa6 <procdump+0x9a>
    if(p->state == UNUSED)
    80001a86:	86a6                	mv	a3,s1
    80001a88:	ec04a783          	lw	a5,-320(s1)
    80001a8c:	dbed                	beqz	a5,80001a7e <procdump+0x72>
      state = "???";
    80001a8e:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a90:	fcfb6be3          	bltu	s6,a5,80001a66 <procdump+0x5a>
    80001a94:	02079713          	slli	a4,a5,0x20
    80001a98:	01d75793          	srli	a5,a4,0x1d
    80001a9c:	97de                	add	a5,a5,s7
    80001a9e:	6390                	ld	a2,0(a5)
    80001aa0:	f279                	bnez	a2,80001a66 <procdump+0x5a>
      state = "???";
    80001aa2:	864e                	mv	a2,s3
    80001aa4:	b7c9                	j	80001a66 <procdump+0x5a>
  }
}
    80001aa6:	60a6                	ld	ra,72(sp)
    80001aa8:	6406                	ld	s0,64(sp)
    80001aaa:	74e2                	ld	s1,56(sp)
    80001aac:	7942                	ld	s2,48(sp)
    80001aae:	79a2                	ld	s3,40(sp)
    80001ab0:	7a02                	ld	s4,32(sp)
    80001ab2:	6ae2                	ld	s5,24(sp)
    80001ab4:	6b42                	ld	s6,16(sp)
    80001ab6:	6ba2                	ld	s7,8(sp)
    80001ab8:	6161                	addi	sp,sp,80
    80001aba:	8082                	ret

0000000080001abc <swtch>:
    80001abc:	00153023          	sd	ra,0(a0)
    80001ac0:	00253423          	sd	sp,8(a0)
    80001ac4:	e900                	sd	s0,16(a0)
    80001ac6:	ed04                	sd	s1,24(a0)
    80001ac8:	03253023          	sd	s2,32(a0)
    80001acc:	03353423          	sd	s3,40(a0)
    80001ad0:	03453823          	sd	s4,48(a0)
    80001ad4:	03553c23          	sd	s5,56(a0)
    80001ad8:	05653023          	sd	s6,64(a0)
    80001adc:	05753423          	sd	s7,72(a0)
    80001ae0:	05853823          	sd	s8,80(a0)
    80001ae4:	05953c23          	sd	s9,88(a0)
    80001ae8:	07a53023          	sd	s10,96(a0)
    80001aec:	07b53423          	sd	s11,104(a0)
    80001af0:	0005b083          	ld	ra,0(a1)
    80001af4:	0085b103          	ld	sp,8(a1)
    80001af8:	6980                	ld	s0,16(a1)
    80001afa:	6d84                	ld	s1,24(a1)
    80001afc:	0205b903          	ld	s2,32(a1)
    80001b00:	0285b983          	ld	s3,40(a1)
    80001b04:	0305ba03          	ld	s4,48(a1)
    80001b08:	0385ba83          	ld	s5,56(a1)
    80001b0c:	0405bb03          	ld	s6,64(a1)
    80001b10:	0485bb83          	ld	s7,72(a1)
    80001b14:	0505bc03          	ld	s8,80(a1)
    80001b18:	0585bc83          	ld	s9,88(a1)
    80001b1c:	0605bd03          	ld	s10,96(a1)
    80001b20:	0685bd83          	ld	s11,104(a1)
    80001b24:	8082                	ret

0000000080001b26 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001b26:	1141                	addi	sp,sp,-16
    80001b28:	e406                	sd	ra,8(sp)
    80001b2a:	e022                	sd	s0,0(sp)
    80001b2c:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001b2e:	00006597          	auipc	a1,0x6
    80001b32:	78a58593          	addi	a1,a1,1930 # 800082b8 <states.0+0x30>
    80001b36:	0000d517          	auipc	a0,0xd
    80001b3a:	c3a50513          	addi	a0,a0,-966 # 8000e770 <tickslock>
    80001b3e:	00004097          	auipc	ra,0x4
    80001b42:	556080e7          	jalr	1366(ra) # 80006094 <initlock>
}
    80001b46:	60a2                	ld	ra,8(sp)
    80001b48:	6402                	ld	s0,0(sp)
    80001b4a:	0141                	addi	sp,sp,16
    80001b4c:	8082                	ret

0000000080001b4e <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001b4e:	1141                	addi	sp,sp,-16
    80001b50:	e422                	sd	s0,8(sp)
    80001b52:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b54:	00003797          	auipc	a5,0x3
    80001b58:	4cc78793          	addi	a5,a5,1228 # 80005020 <kernelvec>
    80001b5c:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b60:	6422                	ld	s0,8(sp)
    80001b62:	0141                	addi	sp,sp,16
    80001b64:	8082                	ret

0000000080001b66 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b66:	1141                	addi	sp,sp,-16
    80001b68:	e406                	sd	ra,8(sp)
    80001b6a:	e022                	sd	s0,0(sp)
    80001b6c:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b6e:	fffff097          	auipc	ra,0xfffff
    80001b72:	33e080e7          	jalr	830(ra) # 80000eac <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b76:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b7a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b7c:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001b80:	00005697          	auipc	a3,0x5
    80001b84:	48068693          	addi	a3,a3,1152 # 80007000 <_trampoline>
    80001b88:	00005717          	auipc	a4,0x5
    80001b8c:	47870713          	addi	a4,a4,1144 # 80007000 <_trampoline>
    80001b90:	8f15                	sub	a4,a4,a3
    80001b92:	040007b7          	lui	a5,0x4000
    80001b96:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001b98:	07b2                	slli	a5,a5,0xc
    80001b9a:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b9c:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001ba0:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001ba2:	18002673          	csrr	a2,satp
    80001ba6:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001ba8:	6d30                	ld	a2,88(a0)
    80001baa:	6138                	ld	a4,64(a0)
    80001bac:	6585                	lui	a1,0x1
    80001bae:	972e                	add	a4,a4,a1
    80001bb0:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001bb2:	6d38                	ld	a4,88(a0)
    80001bb4:	00000617          	auipc	a2,0x0
    80001bb8:	13060613          	addi	a2,a2,304 # 80001ce4 <usertrap>
    80001bbc:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001bbe:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001bc0:	8612                	mv	a2,tp
    80001bc2:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001bc4:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001bc8:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001bcc:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bd0:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001bd4:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001bd6:	6f18                	ld	a4,24(a4)
    80001bd8:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001bdc:	6928                	ld	a0,80(a0)
    80001bde:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001be0:	00005717          	auipc	a4,0x5
    80001be4:	4bc70713          	addi	a4,a4,1212 # 8000709c <userret>
    80001be8:	8f15                	sub	a4,a4,a3
    80001bea:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001bec:	577d                	li	a4,-1
    80001bee:	177e                	slli	a4,a4,0x3f
    80001bf0:	8d59                	or	a0,a0,a4
    80001bf2:	9782                	jalr	a5
}
    80001bf4:	60a2                	ld	ra,8(sp)
    80001bf6:	6402                	ld	s0,0(sp)
    80001bf8:	0141                	addi	sp,sp,16
    80001bfa:	8082                	ret

0000000080001bfc <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001bfc:	1101                	addi	sp,sp,-32
    80001bfe:	ec06                	sd	ra,24(sp)
    80001c00:	e822                	sd	s0,16(sp)
    80001c02:	e426                	sd	s1,8(sp)
    80001c04:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001c06:	0000d497          	auipc	s1,0xd
    80001c0a:	b6a48493          	addi	s1,s1,-1174 # 8000e770 <tickslock>
    80001c0e:	8526                	mv	a0,s1
    80001c10:	00004097          	auipc	ra,0x4
    80001c14:	514080e7          	jalr	1300(ra) # 80006124 <acquire>
  ticks++;
    80001c18:	00007517          	auipc	a0,0x7
    80001c1c:	cf050513          	addi	a0,a0,-784 # 80008908 <ticks>
    80001c20:	411c                	lw	a5,0(a0)
    80001c22:	2785                	addiw	a5,a5,1
    80001c24:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001c26:	00000097          	auipc	ra,0x0
    80001c2a:	996080e7          	jalr	-1642(ra) # 800015bc <wakeup>
  release(&tickslock);
    80001c2e:	8526                	mv	a0,s1
    80001c30:	00004097          	auipc	ra,0x4
    80001c34:	5a8080e7          	jalr	1448(ra) # 800061d8 <release>
}
    80001c38:	60e2                	ld	ra,24(sp)
    80001c3a:	6442                	ld	s0,16(sp)
    80001c3c:	64a2                	ld	s1,8(sp)
    80001c3e:	6105                	addi	sp,sp,32
    80001c40:	8082                	ret

0000000080001c42 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001c42:	1101                	addi	sp,sp,-32
    80001c44:	ec06                	sd	ra,24(sp)
    80001c46:	e822                	sd	s0,16(sp)
    80001c48:	e426                	sd	s1,8(sp)
    80001c4a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c4c:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001c50:	00074d63          	bltz	a4,80001c6a <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001c54:	57fd                	li	a5,-1
    80001c56:	17fe                	slli	a5,a5,0x3f
    80001c58:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001c5a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001c5c:	06f70363          	beq	a4,a5,80001cc2 <devintr+0x80>
  }
}
    80001c60:	60e2                	ld	ra,24(sp)
    80001c62:	6442                	ld	s0,16(sp)
    80001c64:	64a2                	ld	s1,8(sp)
    80001c66:	6105                	addi	sp,sp,32
    80001c68:	8082                	ret
     (scause & 0xff) == 9){
    80001c6a:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    80001c6e:	46a5                	li	a3,9
    80001c70:	fed792e3          	bne	a5,a3,80001c54 <devintr+0x12>
    int irq = plic_claim();
    80001c74:	00003097          	auipc	ra,0x3
    80001c78:	4b4080e7          	jalr	1204(ra) # 80005128 <plic_claim>
    80001c7c:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001c7e:	47a9                	li	a5,10
    80001c80:	02f50763          	beq	a0,a5,80001cae <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001c84:	4785                	li	a5,1
    80001c86:	02f50963          	beq	a0,a5,80001cb8 <devintr+0x76>
    return 1;
    80001c8a:	4505                	li	a0,1
    } else if(irq){
    80001c8c:	d8f1                	beqz	s1,80001c60 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001c8e:	85a6                	mv	a1,s1
    80001c90:	00006517          	auipc	a0,0x6
    80001c94:	63050513          	addi	a0,a0,1584 # 800082c0 <states.0+0x38>
    80001c98:	00004097          	auipc	ra,0x4
    80001c9c:	f9e080e7          	jalr	-98(ra) # 80005c36 <printf>
      plic_complete(irq);
    80001ca0:	8526                	mv	a0,s1
    80001ca2:	00003097          	auipc	ra,0x3
    80001ca6:	4aa080e7          	jalr	1194(ra) # 8000514c <plic_complete>
    return 1;
    80001caa:	4505                	li	a0,1
    80001cac:	bf55                	j	80001c60 <devintr+0x1e>
      uartintr();
    80001cae:	00004097          	auipc	ra,0x4
    80001cb2:	396080e7          	jalr	918(ra) # 80006044 <uartintr>
    80001cb6:	b7ed                	j	80001ca0 <devintr+0x5e>
      virtio_disk_intr();
    80001cb8:	00004097          	auipc	ra,0x4
    80001cbc:	95c080e7          	jalr	-1700(ra) # 80005614 <virtio_disk_intr>
    80001cc0:	b7c5                	j	80001ca0 <devintr+0x5e>
    if(cpuid() == 0){
    80001cc2:	fffff097          	auipc	ra,0xfffff
    80001cc6:	1be080e7          	jalr	446(ra) # 80000e80 <cpuid>
    80001cca:	c901                	beqz	a0,80001cda <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001ccc:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001cd0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001cd2:	14479073          	csrw	sip,a5
    return 2;
    80001cd6:	4509                	li	a0,2
    80001cd8:	b761                	j	80001c60 <devintr+0x1e>
      clockintr();
    80001cda:	00000097          	auipc	ra,0x0
    80001cde:	f22080e7          	jalr	-222(ra) # 80001bfc <clockintr>
    80001ce2:	b7ed                	j	80001ccc <devintr+0x8a>

0000000080001ce4 <usertrap>:
{
    80001ce4:	1101                	addi	sp,sp,-32
    80001ce6:	ec06                	sd	ra,24(sp)
    80001ce8:	e822                	sd	s0,16(sp)
    80001cea:	e426                	sd	s1,8(sp)
    80001cec:	e04a                	sd	s2,0(sp)
    80001cee:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cf0:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001cf4:	1007f793          	andi	a5,a5,256
    80001cf8:	e3b1                	bnez	a5,80001d3c <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001cfa:	00003797          	auipc	a5,0x3
    80001cfe:	32678793          	addi	a5,a5,806 # 80005020 <kernelvec>
    80001d02:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001d06:	fffff097          	auipc	ra,0xfffff
    80001d0a:	1a6080e7          	jalr	422(ra) # 80000eac <myproc>
    80001d0e:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001d10:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d12:	14102773          	csrr	a4,sepc
    80001d16:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d18:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001d1c:	47a1                	li	a5,8
    80001d1e:	02f70763          	beq	a4,a5,80001d4c <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001d22:	00000097          	auipc	ra,0x0
    80001d26:	f20080e7          	jalr	-224(ra) # 80001c42 <devintr>
    80001d2a:	892a                	mv	s2,a0
    80001d2c:	c151                	beqz	a0,80001db0 <usertrap+0xcc>
  if(killed(p))
    80001d2e:	8526                	mv	a0,s1
    80001d30:	00000097          	auipc	ra,0x0
    80001d34:	ad0080e7          	jalr	-1328(ra) # 80001800 <killed>
    80001d38:	c929                	beqz	a0,80001d8a <usertrap+0xa6>
    80001d3a:	a099                	j	80001d80 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001d3c:	00006517          	auipc	a0,0x6
    80001d40:	5a450513          	addi	a0,a0,1444 # 800082e0 <states.0+0x58>
    80001d44:	00004097          	auipc	ra,0x4
    80001d48:	ea8080e7          	jalr	-344(ra) # 80005bec <panic>
    if(killed(p))
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	ab4080e7          	jalr	-1356(ra) # 80001800 <killed>
    80001d54:	e921                	bnez	a0,80001da4 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001d56:	6cb8                	ld	a4,88(s1)
    80001d58:	6f1c                	ld	a5,24(a4)
    80001d5a:	0791                	addi	a5,a5,4
    80001d5c:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d5e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d62:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d66:	10079073          	csrw	sstatus,a5
    syscall();
    80001d6a:	00000097          	auipc	ra,0x0
    80001d6e:	2d4080e7          	jalr	724(ra) # 8000203e <syscall>
  if(killed(p))
    80001d72:	8526                	mv	a0,s1
    80001d74:	00000097          	auipc	ra,0x0
    80001d78:	a8c080e7          	jalr	-1396(ra) # 80001800 <killed>
    80001d7c:	c911                	beqz	a0,80001d90 <usertrap+0xac>
    80001d7e:	4901                	li	s2,0
    exit(-1);
    80001d80:	557d                	li	a0,-1
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	90a080e7          	jalr	-1782(ra) # 8000168c <exit>
  if(which_dev == 2)
    80001d8a:	4789                	li	a5,2
    80001d8c:	04f90f63          	beq	s2,a5,80001dea <usertrap+0x106>
  usertrapret();
    80001d90:	00000097          	auipc	ra,0x0
    80001d94:	dd6080e7          	jalr	-554(ra) # 80001b66 <usertrapret>
}
    80001d98:	60e2                	ld	ra,24(sp)
    80001d9a:	6442                	ld	s0,16(sp)
    80001d9c:	64a2                	ld	s1,8(sp)
    80001d9e:	6902                	ld	s2,0(sp)
    80001da0:	6105                	addi	sp,sp,32
    80001da2:	8082                	ret
      exit(-1);
    80001da4:	557d                	li	a0,-1
    80001da6:	00000097          	auipc	ra,0x0
    80001daa:	8e6080e7          	jalr	-1818(ra) # 8000168c <exit>
    80001dae:	b765                	j	80001d56 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001db0:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001db4:	5890                	lw	a2,48(s1)
    80001db6:	00006517          	auipc	a0,0x6
    80001dba:	54a50513          	addi	a0,a0,1354 # 80008300 <states.0+0x78>
    80001dbe:	00004097          	auipc	ra,0x4
    80001dc2:	e78080e7          	jalr	-392(ra) # 80005c36 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dc6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001dca:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001dce:	00006517          	auipc	a0,0x6
    80001dd2:	56250513          	addi	a0,a0,1378 # 80008330 <states.0+0xa8>
    80001dd6:	00004097          	auipc	ra,0x4
    80001dda:	e60080e7          	jalr	-416(ra) # 80005c36 <printf>
    setkilled(p);
    80001dde:	8526                	mv	a0,s1
    80001de0:	00000097          	auipc	ra,0x0
    80001de4:	9f4080e7          	jalr	-1548(ra) # 800017d4 <setkilled>
    80001de8:	b769                	j	80001d72 <usertrap+0x8e>
    yield();
    80001dea:	fffff097          	auipc	ra,0xfffff
    80001dee:	732080e7          	jalr	1842(ra) # 8000151c <yield>
    80001df2:	bf79                	j	80001d90 <usertrap+0xac>

0000000080001df4 <kerneltrap>:
{
    80001df4:	7179                	addi	sp,sp,-48
    80001df6:	f406                	sd	ra,40(sp)
    80001df8:	f022                	sd	s0,32(sp)
    80001dfa:	ec26                	sd	s1,24(sp)
    80001dfc:	e84a                	sd	s2,16(sp)
    80001dfe:	e44e                	sd	s3,8(sp)
    80001e00:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e02:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e06:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e0a:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001e0e:	1004f793          	andi	a5,s1,256
    80001e12:	cb85                	beqz	a5,80001e42 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e14:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e18:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001e1a:	ef85                	bnez	a5,80001e52 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001e1c:	00000097          	auipc	ra,0x0
    80001e20:	e26080e7          	jalr	-474(ra) # 80001c42 <devintr>
    80001e24:	cd1d                	beqz	a0,80001e62 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e26:	4789                	li	a5,2
    80001e28:	06f50a63          	beq	a0,a5,80001e9c <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e2c:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e30:	10049073          	csrw	sstatus,s1
}
    80001e34:	70a2                	ld	ra,40(sp)
    80001e36:	7402                	ld	s0,32(sp)
    80001e38:	64e2                	ld	s1,24(sp)
    80001e3a:	6942                	ld	s2,16(sp)
    80001e3c:	69a2                	ld	s3,8(sp)
    80001e3e:	6145                	addi	sp,sp,48
    80001e40:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001e42:	00006517          	auipc	a0,0x6
    80001e46:	50e50513          	addi	a0,a0,1294 # 80008350 <states.0+0xc8>
    80001e4a:	00004097          	auipc	ra,0x4
    80001e4e:	da2080e7          	jalr	-606(ra) # 80005bec <panic>
    panic("kerneltrap: interrupts enabled");
    80001e52:	00006517          	auipc	a0,0x6
    80001e56:	52650513          	addi	a0,a0,1318 # 80008378 <states.0+0xf0>
    80001e5a:	00004097          	auipc	ra,0x4
    80001e5e:	d92080e7          	jalr	-622(ra) # 80005bec <panic>
    printf("scause %p\n", scause);
    80001e62:	85ce                	mv	a1,s3
    80001e64:	00006517          	auipc	a0,0x6
    80001e68:	53450513          	addi	a0,a0,1332 # 80008398 <states.0+0x110>
    80001e6c:	00004097          	auipc	ra,0x4
    80001e70:	dca080e7          	jalr	-566(ra) # 80005c36 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e74:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e78:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e7c:	00006517          	auipc	a0,0x6
    80001e80:	52c50513          	addi	a0,a0,1324 # 800083a8 <states.0+0x120>
    80001e84:	00004097          	auipc	ra,0x4
    80001e88:	db2080e7          	jalr	-590(ra) # 80005c36 <printf>
    panic("kerneltrap");
    80001e8c:	00006517          	auipc	a0,0x6
    80001e90:	53450513          	addi	a0,a0,1332 # 800083c0 <states.0+0x138>
    80001e94:	00004097          	auipc	ra,0x4
    80001e98:	d58080e7          	jalr	-680(ra) # 80005bec <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e9c:	fffff097          	auipc	ra,0xfffff
    80001ea0:	010080e7          	jalr	16(ra) # 80000eac <myproc>
    80001ea4:	d541                	beqz	a0,80001e2c <kerneltrap+0x38>
    80001ea6:	fffff097          	auipc	ra,0xfffff
    80001eaa:	006080e7          	jalr	6(ra) # 80000eac <myproc>
    80001eae:	4d18                	lw	a4,24(a0)
    80001eb0:	4791                	li	a5,4
    80001eb2:	f6f71de3          	bne	a4,a5,80001e2c <kerneltrap+0x38>
    yield();
    80001eb6:	fffff097          	auipc	ra,0xfffff
    80001eba:	666080e7          	jalr	1638(ra) # 8000151c <yield>
    80001ebe:	b7bd                	j	80001e2c <kerneltrap+0x38>

0000000080001ec0 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001ec0:	1101                	addi	sp,sp,-32
    80001ec2:	ec06                	sd	ra,24(sp)
    80001ec4:	e822                	sd	s0,16(sp)
    80001ec6:	e426                	sd	s1,8(sp)
    80001ec8:	1000                	addi	s0,sp,32
    80001eca:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001ecc:	fffff097          	auipc	ra,0xfffff
    80001ed0:	fe0080e7          	jalr	-32(ra) # 80000eac <myproc>
  switch (n) {
    80001ed4:	4795                	li	a5,5
    80001ed6:	0497e163          	bltu	a5,s1,80001f18 <argraw+0x58>
    80001eda:	048a                	slli	s1,s1,0x2
    80001edc:	00006717          	auipc	a4,0x6
    80001ee0:	51c70713          	addi	a4,a4,1308 # 800083f8 <states.0+0x170>
    80001ee4:	94ba                	add	s1,s1,a4
    80001ee6:	409c                	lw	a5,0(s1)
    80001ee8:	97ba                	add	a5,a5,a4
    80001eea:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001eec:	6d3c                	ld	a5,88(a0)
    80001eee:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001ef0:	60e2                	ld	ra,24(sp)
    80001ef2:	6442                	ld	s0,16(sp)
    80001ef4:	64a2                	ld	s1,8(sp)
    80001ef6:	6105                	addi	sp,sp,32
    80001ef8:	8082                	ret
    return p->trapframe->a1;
    80001efa:	6d3c                	ld	a5,88(a0)
    80001efc:	7fa8                	ld	a0,120(a5)
    80001efe:	bfcd                	j	80001ef0 <argraw+0x30>
    return p->trapframe->a2;
    80001f00:	6d3c                	ld	a5,88(a0)
    80001f02:	63c8                	ld	a0,128(a5)
    80001f04:	b7f5                	j	80001ef0 <argraw+0x30>
    return p->trapframe->a3;
    80001f06:	6d3c                	ld	a5,88(a0)
    80001f08:	67c8                	ld	a0,136(a5)
    80001f0a:	b7dd                	j	80001ef0 <argraw+0x30>
    return p->trapframe->a4;
    80001f0c:	6d3c                	ld	a5,88(a0)
    80001f0e:	6bc8                	ld	a0,144(a5)
    80001f10:	b7c5                	j	80001ef0 <argraw+0x30>
    return p->trapframe->a5;
    80001f12:	6d3c                	ld	a5,88(a0)
    80001f14:	6fc8                	ld	a0,152(a5)
    80001f16:	bfe9                	j	80001ef0 <argraw+0x30>
  panic("argraw");
    80001f18:	00006517          	auipc	a0,0x6
    80001f1c:	4b850513          	addi	a0,a0,1208 # 800083d0 <states.0+0x148>
    80001f20:	00004097          	auipc	ra,0x4
    80001f24:	ccc080e7          	jalr	-820(ra) # 80005bec <panic>

0000000080001f28 <fetchaddr>:
{
    80001f28:	1101                	addi	sp,sp,-32
    80001f2a:	ec06                	sd	ra,24(sp)
    80001f2c:	e822                	sd	s0,16(sp)
    80001f2e:	e426                	sd	s1,8(sp)
    80001f30:	e04a                	sd	s2,0(sp)
    80001f32:	1000                	addi	s0,sp,32
    80001f34:	84aa                	mv	s1,a0
    80001f36:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	f74080e7          	jalr	-140(ra) # 80000eac <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001f40:	653c                	ld	a5,72(a0)
    80001f42:	02f4f863          	bgeu	s1,a5,80001f72 <fetchaddr+0x4a>
    80001f46:	00848713          	addi	a4,s1,8
    80001f4a:	02e7e663          	bltu	a5,a4,80001f76 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001f4e:	46a1                	li	a3,8
    80001f50:	8626                	mv	a2,s1
    80001f52:	85ca                	mv	a1,s2
    80001f54:	6928                	ld	a0,80(a0)
    80001f56:	fffff097          	auipc	ra,0xfffff
    80001f5a:	ca2080e7          	jalr	-862(ra) # 80000bf8 <copyin>
    80001f5e:	00a03533          	snez	a0,a0
    80001f62:	40a00533          	neg	a0,a0
}
    80001f66:	60e2                	ld	ra,24(sp)
    80001f68:	6442                	ld	s0,16(sp)
    80001f6a:	64a2                	ld	s1,8(sp)
    80001f6c:	6902                	ld	s2,0(sp)
    80001f6e:	6105                	addi	sp,sp,32
    80001f70:	8082                	ret
    return -1;
    80001f72:	557d                	li	a0,-1
    80001f74:	bfcd                	j	80001f66 <fetchaddr+0x3e>
    80001f76:	557d                	li	a0,-1
    80001f78:	b7fd                	j	80001f66 <fetchaddr+0x3e>

0000000080001f7a <fetchstr>:
{
    80001f7a:	7179                	addi	sp,sp,-48
    80001f7c:	f406                	sd	ra,40(sp)
    80001f7e:	f022                	sd	s0,32(sp)
    80001f80:	ec26                	sd	s1,24(sp)
    80001f82:	e84a                	sd	s2,16(sp)
    80001f84:	e44e                	sd	s3,8(sp)
    80001f86:	1800                	addi	s0,sp,48
    80001f88:	892a                	mv	s2,a0
    80001f8a:	84ae                	mv	s1,a1
    80001f8c:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001f8e:	fffff097          	auipc	ra,0xfffff
    80001f92:	f1e080e7          	jalr	-226(ra) # 80000eac <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001f96:	86ce                	mv	a3,s3
    80001f98:	864a                	mv	a2,s2
    80001f9a:	85a6                	mv	a1,s1
    80001f9c:	6928                	ld	a0,80(a0)
    80001f9e:	fffff097          	auipc	ra,0xfffff
    80001fa2:	ce8080e7          	jalr	-792(ra) # 80000c86 <copyinstr>
    80001fa6:	00054e63          	bltz	a0,80001fc2 <fetchstr+0x48>
  return strlen(buf);
    80001faa:	8526                	mv	a0,s1
    80001fac:	ffffe097          	auipc	ra,0xffffe
    80001fb0:	34a080e7          	jalr	842(ra) # 800002f6 <strlen>
}
    80001fb4:	70a2                	ld	ra,40(sp)
    80001fb6:	7402                	ld	s0,32(sp)
    80001fb8:	64e2                	ld	s1,24(sp)
    80001fba:	6942                	ld	s2,16(sp)
    80001fbc:	69a2                	ld	s3,8(sp)
    80001fbe:	6145                	addi	sp,sp,48
    80001fc0:	8082                	ret
    return -1;
    80001fc2:	557d                	li	a0,-1
    80001fc4:	bfc5                	j	80001fb4 <fetchstr+0x3a>

0000000080001fc6 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001fc6:	1101                	addi	sp,sp,-32
    80001fc8:	ec06                	sd	ra,24(sp)
    80001fca:	e822                	sd	s0,16(sp)
    80001fcc:	e426                	sd	s1,8(sp)
    80001fce:	1000                	addi	s0,sp,32
    80001fd0:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001fd2:	00000097          	auipc	ra,0x0
    80001fd6:	eee080e7          	jalr	-274(ra) # 80001ec0 <argraw>
    80001fda:	c088                	sw	a0,0(s1)
}
    80001fdc:	60e2                	ld	ra,24(sp)
    80001fde:	6442                	ld	s0,16(sp)
    80001fe0:	64a2                	ld	s1,8(sp)
    80001fe2:	6105                	addi	sp,sp,32
    80001fe4:	8082                	ret

0000000080001fe6 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001fe6:	1101                	addi	sp,sp,-32
    80001fe8:	ec06                	sd	ra,24(sp)
    80001fea:	e822                	sd	s0,16(sp)
    80001fec:	e426                	sd	s1,8(sp)
    80001fee:	1000                	addi	s0,sp,32
    80001ff0:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001ff2:	00000097          	auipc	ra,0x0
    80001ff6:	ece080e7          	jalr	-306(ra) # 80001ec0 <argraw>
    80001ffa:	e088                	sd	a0,0(s1)
}
    80001ffc:	60e2                	ld	ra,24(sp)
    80001ffe:	6442                	ld	s0,16(sp)
    80002000:	64a2                	ld	s1,8(sp)
    80002002:	6105                	addi	sp,sp,32
    80002004:	8082                	ret

0000000080002006 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002006:	7179                	addi	sp,sp,-48
    80002008:	f406                	sd	ra,40(sp)
    8000200a:	f022                	sd	s0,32(sp)
    8000200c:	ec26                	sd	s1,24(sp)
    8000200e:	e84a                	sd	s2,16(sp)
    80002010:	1800                	addi	s0,sp,48
    80002012:	84ae                	mv	s1,a1
    80002014:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80002016:	fd840593          	addi	a1,s0,-40
    8000201a:	00000097          	auipc	ra,0x0
    8000201e:	fcc080e7          	jalr	-52(ra) # 80001fe6 <argaddr>
  return fetchstr(addr, buf, max);
    80002022:	864a                	mv	a2,s2
    80002024:	85a6                	mv	a1,s1
    80002026:	fd843503          	ld	a0,-40(s0)
    8000202a:	00000097          	auipc	ra,0x0
    8000202e:	f50080e7          	jalr	-176(ra) # 80001f7a <fetchstr>
}
    80002032:	70a2                	ld	ra,40(sp)
    80002034:	7402                	ld	s0,32(sp)
    80002036:	64e2                	ld	s1,24(sp)
    80002038:	6942                	ld	s2,16(sp)
    8000203a:	6145                	addi	sp,sp,48
    8000203c:	8082                	ret

000000008000203e <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    8000203e:	1101                	addi	sp,sp,-32
    80002040:	ec06                	sd	ra,24(sp)
    80002042:	e822                	sd	s0,16(sp)
    80002044:	e426                	sd	s1,8(sp)
    80002046:	e04a                	sd	s2,0(sp)
    80002048:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    8000204a:	fffff097          	auipc	ra,0xfffff
    8000204e:	e62080e7          	jalr	-414(ra) # 80000eac <myproc>
    80002052:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002054:	05853903          	ld	s2,88(a0)
    80002058:	0a893783          	ld	a5,168(s2)
    8000205c:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002060:	37fd                	addiw	a5,a5,-1
    80002062:	4751                	li	a4,20
    80002064:	00f76f63          	bltu	a4,a5,80002082 <syscall+0x44>
    80002068:	00369713          	slli	a4,a3,0x3
    8000206c:	00006797          	auipc	a5,0x6
    80002070:	3a478793          	addi	a5,a5,932 # 80008410 <syscalls>
    80002074:	97ba                	add	a5,a5,a4
    80002076:	639c                	ld	a5,0(a5)
    80002078:	c789                	beqz	a5,80002082 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    8000207a:	9782                	jalr	a5
    8000207c:	06a93823          	sd	a0,112(s2)
    80002080:	a839                	j	8000209e <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002082:	15848613          	addi	a2,s1,344
    80002086:	588c                	lw	a1,48(s1)
    80002088:	00006517          	auipc	a0,0x6
    8000208c:	35050513          	addi	a0,a0,848 # 800083d8 <states.0+0x150>
    80002090:	00004097          	auipc	ra,0x4
    80002094:	ba6080e7          	jalr	-1114(ra) # 80005c36 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002098:	6cbc                	ld	a5,88(s1)
    8000209a:	577d                	li	a4,-1
    8000209c:	fbb8                	sd	a4,112(a5)
  }
}
    8000209e:	60e2                	ld	ra,24(sp)
    800020a0:	6442                	ld	s0,16(sp)
    800020a2:	64a2                	ld	s1,8(sp)
    800020a4:	6902                	ld	s2,0(sp)
    800020a6:	6105                	addi	sp,sp,32
    800020a8:	8082                	ret

00000000800020aa <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800020aa:	1101                	addi	sp,sp,-32
    800020ac:	ec06                	sd	ra,24(sp)
    800020ae:	e822                	sd	s0,16(sp)
    800020b0:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    800020b2:	fec40593          	addi	a1,s0,-20
    800020b6:	4501                	li	a0,0
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	f0e080e7          	jalr	-242(ra) # 80001fc6 <argint>
  exit(n);
    800020c0:	fec42503          	lw	a0,-20(s0)
    800020c4:	fffff097          	auipc	ra,0xfffff
    800020c8:	5c8080e7          	jalr	1480(ra) # 8000168c <exit>
  return 0;  // not reached
}
    800020cc:	4501                	li	a0,0
    800020ce:	60e2                	ld	ra,24(sp)
    800020d0:	6442                	ld	s0,16(sp)
    800020d2:	6105                	addi	sp,sp,32
    800020d4:	8082                	ret

00000000800020d6 <sys_getpid>:

uint64
sys_getpid(void)
{
    800020d6:	1141                	addi	sp,sp,-16
    800020d8:	e406                	sd	ra,8(sp)
    800020da:	e022                	sd	s0,0(sp)
    800020dc:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800020de:	fffff097          	auipc	ra,0xfffff
    800020e2:	dce080e7          	jalr	-562(ra) # 80000eac <myproc>
}
    800020e6:	5908                	lw	a0,48(a0)
    800020e8:	60a2                	ld	ra,8(sp)
    800020ea:	6402                	ld	s0,0(sp)
    800020ec:	0141                	addi	sp,sp,16
    800020ee:	8082                	ret

00000000800020f0 <sys_fork>:

uint64
sys_fork(void)
{
    800020f0:	1141                	addi	sp,sp,-16
    800020f2:	e406                	sd	ra,8(sp)
    800020f4:	e022                	sd	s0,0(sp)
    800020f6:	0800                	addi	s0,sp,16
  return fork();
    800020f8:	fffff097          	auipc	ra,0xfffff
    800020fc:	16e080e7          	jalr	366(ra) # 80001266 <fork>
}
    80002100:	60a2                	ld	ra,8(sp)
    80002102:	6402                	ld	s0,0(sp)
    80002104:	0141                	addi	sp,sp,16
    80002106:	8082                	ret

0000000080002108 <sys_wait>:

uint64
sys_wait(void)
{
    80002108:	1101                	addi	sp,sp,-32
    8000210a:	ec06                	sd	ra,24(sp)
    8000210c:	e822                	sd	s0,16(sp)
    8000210e:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80002110:	fe840593          	addi	a1,s0,-24
    80002114:	4501                	li	a0,0
    80002116:	00000097          	auipc	ra,0x0
    8000211a:	ed0080e7          	jalr	-304(ra) # 80001fe6 <argaddr>
  return wait(p);
    8000211e:	fe843503          	ld	a0,-24(s0)
    80002122:	fffff097          	auipc	ra,0xfffff
    80002126:	710080e7          	jalr	1808(ra) # 80001832 <wait>
}
    8000212a:	60e2                	ld	ra,24(sp)
    8000212c:	6442                	ld	s0,16(sp)
    8000212e:	6105                	addi	sp,sp,32
    80002130:	8082                	ret

0000000080002132 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002132:	7179                	addi	sp,sp,-48
    80002134:	f406                	sd	ra,40(sp)
    80002136:	f022                	sd	s0,32(sp)
    80002138:	ec26                	sd	s1,24(sp)
    8000213a:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    8000213c:	fdc40593          	addi	a1,s0,-36
    80002140:	4501                	li	a0,0
    80002142:	00000097          	auipc	ra,0x0
    80002146:	e84080e7          	jalr	-380(ra) # 80001fc6 <argint>
  addr = myproc()->sz;
    8000214a:	fffff097          	auipc	ra,0xfffff
    8000214e:	d62080e7          	jalr	-670(ra) # 80000eac <myproc>
    80002152:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    80002154:	fdc42503          	lw	a0,-36(s0)
    80002158:	fffff097          	auipc	ra,0xfffff
    8000215c:	0b2080e7          	jalr	178(ra) # 8000120a <growproc>
    80002160:	00054863          	bltz	a0,80002170 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002164:	8526                	mv	a0,s1
    80002166:	70a2                	ld	ra,40(sp)
    80002168:	7402                	ld	s0,32(sp)
    8000216a:	64e2                	ld	s1,24(sp)
    8000216c:	6145                	addi	sp,sp,48
    8000216e:	8082                	ret
    return -1;
    80002170:	54fd                	li	s1,-1
    80002172:	bfcd                	j	80002164 <sys_sbrk+0x32>

0000000080002174 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002174:	7139                	addi	sp,sp,-64
    80002176:	fc06                	sd	ra,56(sp)
    80002178:	f822                	sd	s0,48(sp)
    8000217a:	f426                	sd	s1,40(sp)
    8000217c:	f04a                	sd	s2,32(sp)
    8000217e:	ec4e                	sd	s3,24(sp)
    80002180:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002182:	fcc40593          	addi	a1,s0,-52
    80002186:	4501                	li	a0,0
    80002188:	00000097          	auipc	ra,0x0
    8000218c:	e3e080e7          	jalr	-450(ra) # 80001fc6 <argint>
  if(n < 0)
    80002190:	fcc42783          	lw	a5,-52(s0)
    80002194:	0607cf63          	bltz	a5,80002212 <sys_sleep+0x9e>
    n = 0;
  acquire(&tickslock);
    80002198:	0000c517          	auipc	a0,0xc
    8000219c:	5d850513          	addi	a0,a0,1496 # 8000e770 <tickslock>
    800021a0:	00004097          	auipc	ra,0x4
    800021a4:	f84080e7          	jalr	-124(ra) # 80006124 <acquire>
  ticks0 = ticks;
    800021a8:	00006917          	auipc	s2,0x6
    800021ac:	76092903          	lw	s2,1888(s2) # 80008908 <ticks>
  while(ticks - ticks0 < n){
    800021b0:	fcc42783          	lw	a5,-52(s0)
    800021b4:	cf9d                	beqz	a5,800021f2 <sys_sleep+0x7e>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800021b6:	0000c997          	auipc	s3,0xc
    800021ba:	5ba98993          	addi	s3,s3,1466 # 8000e770 <tickslock>
    800021be:	00006497          	auipc	s1,0x6
    800021c2:	74a48493          	addi	s1,s1,1866 # 80008908 <ticks>
    if(killed(myproc())){
    800021c6:	fffff097          	auipc	ra,0xfffff
    800021ca:	ce6080e7          	jalr	-794(ra) # 80000eac <myproc>
    800021ce:	fffff097          	auipc	ra,0xfffff
    800021d2:	632080e7          	jalr	1586(ra) # 80001800 <killed>
    800021d6:	e129                	bnez	a0,80002218 <sys_sleep+0xa4>
    sleep(&ticks, &tickslock);
    800021d8:	85ce                	mv	a1,s3
    800021da:	8526                	mv	a0,s1
    800021dc:	fffff097          	auipc	ra,0xfffff
    800021e0:	37c080e7          	jalr	892(ra) # 80001558 <sleep>
  while(ticks - ticks0 < n){
    800021e4:	409c                	lw	a5,0(s1)
    800021e6:	412787bb          	subw	a5,a5,s2
    800021ea:	fcc42703          	lw	a4,-52(s0)
    800021ee:	fce7ece3          	bltu	a5,a4,800021c6 <sys_sleep+0x52>
  }
  release(&tickslock);
    800021f2:	0000c517          	auipc	a0,0xc
    800021f6:	57e50513          	addi	a0,a0,1406 # 8000e770 <tickslock>
    800021fa:	00004097          	auipc	ra,0x4
    800021fe:	fde080e7          	jalr	-34(ra) # 800061d8 <release>
  return 0;
    80002202:	4501                	li	a0,0
}
    80002204:	70e2                	ld	ra,56(sp)
    80002206:	7442                	ld	s0,48(sp)
    80002208:	74a2                	ld	s1,40(sp)
    8000220a:	7902                	ld	s2,32(sp)
    8000220c:	69e2                	ld	s3,24(sp)
    8000220e:	6121                	addi	sp,sp,64
    80002210:	8082                	ret
    n = 0;
    80002212:	fc042623          	sw	zero,-52(s0)
    80002216:	b749                	j	80002198 <sys_sleep+0x24>
      release(&tickslock);
    80002218:	0000c517          	auipc	a0,0xc
    8000221c:	55850513          	addi	a0,a0,1368 # 8000e770 <tickslock>
    80002220:	00004097          	auipc	ra,0x4
    80002224:	fb8080e7          	jalr	-72(ra) # 800061d8 <release>
      return -1;
    80002228:	557d                	li	a0,-1
    8000222a:	bfe9                	j	80002204 <sys_sleep+0x90>

000000008000222c <sys_kill>:

uint64
sys_kill(void)
{
    8000222c:	1101                	addi	sp,sp,-32
    8000222e:	ec06                	sd	ra,24(sp)
    80002230:	e822                	sd	s0,16(sp)
    80002232:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80002234:	fec40593          	addi	a1,s0,-20
    80002238:	4501                	li	a0,0
    8000223a:	00000097          	auipc	ra,0x0
    8000223e:	d8c080e7          	jalr	-628(ra) # 80001fc6 <argint>
  return kill(pid);
    80002242:	fec42503          	lw	a0,-20(s0)
    80002246:	fffff097          	auipc	ra,0xfffff
    8000224a:	51c080e7          	jalr	1308(ra) # 80001762 <kill>
}
    8000224e:	60e2                	ld	ra,24(sp)
    80002250:	6442                	ld	s0,16(sp)
    80002252:	6105                	addi	sp,sp,32
    80002254:	8082                	ret

0000000080002256 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002256:	1101                	addi	sp,sp,-32
    80002258:	ec06                	sd	ra,24(sp)
    8000225a:	e822                	sd	s0,16(sp)
    8000225c:	e426                	sd	s1,8(sp)
    8000225e:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002260:	0000c517          	auipc	a0,0xc
    80002264:	51050513          	addi	a0,a0,1296 # 8000e770 <tickslock>
    80002268:	00004097          	auipc	ra,0x4
    8000226c:	ebc080e7          	jalr	-324(ra) # 80006124 <acquire>
  xticks = ticks;
    80002270:	00006497          	auipc	s1,0x6
    80002274:	6984a483          	lw	s1,1688(s1) # 80008908 <ticks>
  release(&tickslock);
    80002278:	0000c517          	auipc	a0,0xc
    8000227c:	4f850513          	addi	a0,a0,1272 # 8000e770 <tickslock>
    80002280:	00004097          	auipc	ra,0x4
    80002284:	f58080e7          	jalr	-168(ra) # 800061d8 <release>
  return xticks;
}
    80002288:	02049513          	slli	a0,s1,0x20
    8000228c:	9101                	srli	a0,a0,0x20
    8000228e:	60e2                	ld	ra,24(sp)
    80002290:	6442                	ld	s0,16(sp)
    80002292:	64a2                	ld	s1,8(sp)
    80002294:	6105                	addi	sp,sp,32
    80002296:	8082                	ret

0000000080002298 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002298:	7179                	addi	sp,sp,-48
    8000229a:	f406                	sd	ra,40(sp)
    8000229c:	f022                	sd	s0,32(sp)
    8000229e:	ec26                	sd	s1,24(sp)
    800022a0:	e84a                	sd	s2,16(sp)
    800022a2:	e44e                	sd	s3,8(sp)
    800022a4:	e052                	sd	s4,0(sp)
    800022a6:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800022a8:	00006597          	auipc	a1,0x6
    800022ac:	21858593          	addi	a1,a1,536 # 800084c0 <syscalls+0xb0>
    800022b0:	0000c517          	auipc	a0,0xc
    800022b4:	4d850513          	addi	a0,a0,1240 # 8000e788 <bcache>
    800022b8:	00004097          	auipc	ra,0x4
    800022bc:	ddc080e7          	jalr	-548(ra) # 80006094 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800022c0:	00014797          	auipc	a5,0x14
    800022c4:	4c878793          	addi	a5,a5,1224 # 80016788 <bcache+0x8000>
    800022c8:	00014717          	auipc	a4,0x14
    800022cc:	72870713          	addi	a4,a4,1832 # 800169f0 <bcache+0x8268>
    800022d0:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800022d4:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800022d8:	0000c497          	auipc	s1,0xc
    800022dc:	4c848493          	addi	s1,s1,1224 # 8000e7a0 <bcache+0x18>
    b->next = bcache.head.next;
    800022e0:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800022e2:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800022e4:	00006a17          	auipc	s4,0x6
    800022e8:	1e4a0a13          	addi	s4,s4,484 # 800084c8 <syscalls+0xb8>
    b->next = bcache.head.next;
    800022ec:	2b893783          	ld	a5,696(s2)
    800022f0:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800022f2:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800022f6:	85d2                	mv	a1,s4
    800022f8:	01048513          	addi	a0,s1,16
    800022fc:	00001097          	auipc	ra,0x1
    80002300:	4c8080e7          	jalr	1224(ra) # 800037c4 <initsleeplock>
    bcache.head.next->prev = b;
    80002304:	2b893783          	ld	a5,696(s2)
    80002308:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000230a:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000230e:	45848493          	addi	s1,s1,1112
    80002312:	fd349de3          	bne	s1,s3,800022ec <binit+0x54>
  }
}
    80002316:	70a2                	ld	ra,40(sp)
    80002318:	7402                	ld	s0,32(sp)
    8000231a:	64e2                	ld	s1,24(sp)
    8000231c:	6942                	ld	s2,16(sp)
    8000231e:	69a2                	ld	s3,8(sp)
    80002320:	6a02                	ld	s4,0(sp)
    80002322:	6145                	addi	sp,sp,48
    80002324:	8082                	ret

0000000080002326 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002326:	7179                	addi	sp,sp,-48
    80002328:	f406                	sd	ra,40(sp)
    8000232a:	f022                	sd	s0,32(sp)
    8000232c:	ec26                	sd	s1,24(sp)
    8000232e:	e84a                	sd	s2,16(sp)
    80002330:	e44e                	sd	s3,8(sp)
    80002332:	1800                	addi	s0,sp,48
    80002334:	892a                	mv	s2,a0
    80002336:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002338:	0000c517          	auipc	a0,0xc
    8000233c:	45050513          	addi	a0,a0,1104 # 8000e788 <bcache>
    80002340:	00004097          	auipc	ra,0x4
    80002344:	de4080e7          	jalr	-540(ra) # 80006124 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002348:	00014497          	auipc	s1,0x14
    8000234c:	6f84b483          	ld	s1,1784(s1) # 80016a40 <bcache+0x82b8>
    80002350:	00014797          	auipc	a5,0x14
    80002354:	6a078793          	addi	a5,a5,1696 # 800169f0 <bcache+0x8268>
    80002358:	02f48f63          	beq	s1,a5,80002396 <bread+0x70>
    8000235c:	873e                	mv	a4,a5
    8000235e:	a021                	j	80002366 <bread+0x40>
    80002360:	68a4                	ld	s1,80(s1)
    80002362:	02e48a63          	beq	s1,a4,80002396 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002366:	449c                	lw	a5,8(s1)
    80002368:	ff279ce3          	bne	a5,s2,80002360 <bread+0x3a>
    8000236c:	44dc                	lw	a5,12(s1)
    8000236e:	ff3799e3          	bne	a5,s3,80002360 <bread+0x3a>
      b->refcnt++;
    80002372:	40bc                	lw	a5,64(s1)
    80002374:	2785                	addiw	a5,a5,1
    80002376:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002378:	0000c517          	auipc	a0,0xc
    8000237c:	41050513          	addi	a0,a0,1040 # 8000e788 <bcache>
    80002380:	00004097          	auipc	ra,0x4
    80002384:	e58080e7          	jalr	-424(ra) # 800061d8 <release>
      acquiresleep(&b->lock);
    80002388:	01048513          	addi	a0,s1,16
    8000238c:	00001097          	auipc	ra,0x1
    80002390:	472080e7          	jalr	1138(ra) # 800037fe <acquiresleep>
      return b;
    80002394:	a8b9                	j	800023f2 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002396:	00014497          	auipc	s1,0x14
    8000239a:	6a24b483          	ld	s1,1698(s1) # 80016a38 <bcache+0x82b0>
    8000239e:	00014797          	auipc	a5,0x14
    800023a2:	65278793          	addi	a5,a5,1618 # 800169f0 <bcache+0x8268>
    800023a6:	00f48863          	beq	s1,a5,800023b6 <bread+0x90>
    800023aa:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800023ac:	40bc                	lw	a5,64(s1)
    800023ae:	cf81                	beqz	a5,800023c6 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800023b0:	64a4                	ld	s1,72(s1)
    800023b2:	fee49de3          	bne	s1,a4,800023ac <bread+0x86>
  panic("bget: no buffers");
    800023b6:	00006517          	auipc	a0,0x6
    800023ba:	11a50513          	addi	a0,a0,282 # 800084d0 <syscalls+0xc0>
    800023be:	00004097          	auipc	ra,0x4
    800023c2:	82e080e7          	jalr	-2002(ra) # 80005bec <panic>
      b->dev = dev;
    800023c6:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800023ca:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800023ce:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800023d2:	4785                	li	a5,1
    800023d4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800023d6:	0000c517          	auipc	a0,0xc
    800023da:	3b250513          	addi	a0,a0,946 # 8000e788 <bcache>
    800023de:	00004097          	auipc	ra,0x4
    800023e2:	dfa080e7          	jalr	-518(ra) # 800061d8 <release>
      acquiresleep(&b->lock);
    800023e6:	01048513          	addi	a0,s1,16
    800023ea:	00001097          	auipc	ra,0x1
    800023ee:	414080e7          	jalr	1044(ra) # 800037fe <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800023f2:	409c                	lw	a5,0(s1)
    800023f4:	cb89                	beqz	a5,80002406 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800023f6:	8526                	mv	a0,s1
    800023f8:	70a2                	ld	ra,40(sp)
    800023fa:	7402                	ld	s0,32(sp)
    800023fc:	64e2                	ld	s1,24(sp)
    800023fe:	6942                	ld	s2,16(sp)
    80002400:	69a2                	ld	s3,8(sp)
    80002402:	6145                	addi	sp,sp,48
    80002404:	8082                	ret
    virtio_disk_rw(b, 0);
    80002406:	4581                	li	a1,0
    80002408:	8526                	mv	a0,s1
    8000240a:	00003097          	auipc	ra,0x3
    8000240e:	fd8080e7          	jalr	-40(ra) # 800053e2 <virtio_disk_rw>
    b->valid = 1;
    80002412:	4785                	li	a5,1
    80002414:	c09c                	sw	a5,0(s1)
  return b;
    80002416:	b7c5                	j	800023f6 <bread+0xd0>

0000000080002418 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002418:	1101                	addi	sp,sp,-32
    8000241a:	ec06                	sd	ra,24(sp)
    8000241c:	e822                	sd	s0,16(sp)
    8000241e:	e426                	sd	s1,8(sp)
    80002420:	1000                	addi	s0,sp,32
    80002422:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002424:	0541                	addi	a0,a0,16
    80002426:	00001097          	auipc	ra,0x1
    8000242a:	472080e7          	jalr	1138(ra) # 80003898 <holdingsleep>
    8000242e:	cd01                	beqz	a0,80002446 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002430:	4585                	li	a1,1
    80002432:	8526                	mv	a0,s1
    80002434:	00003097          	auipc	ra,0x3
    80002438:	fae080e7          	jalr	-82(ra) # 800053e2 <virtio_disk_rw>
}
    8000243c:	60e2                	ld	ra,24(sp)
    8000243e:	6442                	ld	s0,16(sp)
    80002440:	64a2                	ld	s1,8(sp)
    80002442:	6105                	addi	sp,sp,32
    80002444:	8082                	ret
    panic("bwrite");
    80002446:	00006517          	auipc	a0,0x6
    8000244a:	0a250513          	addi	a0,a0,162 # 800084e8 <syscalls+0xd8>
    8000244e:	00003097          	auipc	ra,0x3
    80002452:	79e080e7          	jalr	1950(ra) # 80005bec <panic>

0000000080002456 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002456:	1101                	addi	sp,sp,-32
    80002458:	ec06                	sd	ra,24(sp)
    8000245a:	e822                	sd	s0,16(sp)
    8000245c:	e426                	sd	s1,8(sp)
    8000245e:	e04a                	sd	s2,0(sp)
    80002460:	1000                	addi	s0,sp,32
    80002462:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002464:	01050913          	addi	s2,a0,16
    80002468:	854a                	mv	a0,s2
    8000246a:	00001097          	auipc	ra,0x1
    8000246e:	42e080e7          	jalr	1070(ra) # 80003898 <holdingsleep>
    80002472:	c92d                	beqz	a0,800024e4 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002474:	854a                	mv	a0,s2
    80002476:	00001097          	auipc	ra,0x1
    8000247a:	3de080e7          	jalr	990(ra) # 80003854 <releasesleep>

  acquire(&bcache.lock);
    8000247e:	0000c517          	auipc	a0,0xc
    80002482:	30a50513          	addi	a0,a0,778 # 8000e788 <bcache>
    80002486:	00004097          	auipc	ra,0x4
    8000248a:	c9e080e7          	jalr	-866(ra) # 80006124 <acquire>
  b->refcnt--;
    8000248e:	40bc                	lw	a5,64(s1)
    80002490:	37fd                	addiw	a5,a5,-1
    80002492:	0007871b          	sext.w	a4,a5
    80002496:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002498:	eb05                	bnez	a4,800024c8 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000249a:	68bc                	ld	a5,80(s1)
    8000249c:	64b8                	ld	a4,72(s1)
    8000249e:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800024a0:	64bc                	ld	a5,72(s1)
    800024a2:	68b8                	ld	a4,80(s1)
    800024a4:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800024a6:	00014797          	auipc	a5,0x14
    800024aa:	2e278793          	addi	a5,a5,738 # 80016788 <bcache+0x8000>
    800024ae:	2b87b703          	ld	a4,696(a5)
    800024b2:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800024b4:	00014717          	auipc	a4,0x14
    800024b8:	53c70713          	addi	a4,a4,1340 # 800169f0 <bcache+0x8268>
    800024bc:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800024be:	2b87b703          	ld	a4,696(a5)
    800024c2:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800024c4:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800024c8:	0000c517          	auipc	a0,0xc
    800024cc:	2c050513          	addi	a0,a0,704 # 8000e788 <bcache>
    800024d0:	00004097          	auipc	ra,0x4
    800024d4:	d08080e7          	jalr	-760(ra) # 800061d8 <release>
}
    800024d8:	60e2                	ld	ra,24(sp)
    800024da:	6442                	ld	s0,16(sp)
    800024dc:	64a2                	ld	s1,8(sp)
    800024de:	6902                	ld	s2,0(sp)
    800024e0:	6105                	addi	sp,sp,32
    800024e2:	8082                	ret
    panic("brelse");
    800024e4:	00006517          	auipc	a0,0x6
    800024e8:	00c50513          	addi	a0,a0,12 # 800084f0 <syscalls+0xe0>
    800024ec:	00003097          	auipc	ra,0x3
    800024f0:	700080e7          	jalr	1792(ra) # 80005bec <panic>

00000000800024f4 <bpin>:

void
bpin(struct buf *b) {
    800024f4:	1101                	addi	sp,sp,-32
    800024f6:	ec06                	sd	ra,24(sp)
    800024f8:	e822                	sd	s0,16(sp)
    800024fa:	e426                	sd	s1,8(sp)
    800024fc:	1000                	addi	s0,sp,32
    800024fe:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002500:	0000c517          	auipc	a0,0xc
    80002504:	28850513          	addi	a0,a0,648 # 8000e788 <bcache>
    80002508:	00004097          	auipc	ra,0x4
    8000250c:	c1c080e7          	jalr	-996(ra) # 80006124 <acquire>
  b->refcnt++;
    80002510:	40bc                	lw	a5,64(s1)
    80002512:	2785                	addiw	a5,a5,1
    80002514:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002516:	0000c517          	auipc	a0,0xc
    8000251a:	27250513          	addi	a0,a0,626 # 8000e788 <bcache>
    8000251e:	00004097          	auipc	ra,0x4
    80002522:	cba080e7          	jalr	-838(ra) # 800061d8 <release>
}
    80002526:	60e2                	ld	ra,24(sp)
    80002528:	6442                	ld	s0,16(sp)
    8000252a:	64a2                	ld	s1,8(sp)
    8000252c:	6105                	addi	sp,sp,32
    8000252e:	8082                	ret

0000000080002530 <bunpin>:

void
bunpin(struct buf *b) {
    80002530:	1101                	addi	sp,sp,-32
    80002532:	ec06                	sd	ra,24(sp)
    80002534:	e822                	sd	s0,16(sp)
    80002536:	e426                	sd	s1,8(sp)
    80002538:	1000                	addi	s0,sp,32
    8000253a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000253c:	0000c517          	auipc	a0,0xc
    80002540:	24c50513          	addi	a0,a0,588 # 8000e788 <bcache>
    80002544:	00004097          	auipc	ra,0x4
    80002548:	be0080e7          	jalr	-1056(ra) # 80006124 <acquire>
  b->refcnt--;
    8000254c:	40bc                	lw	a5,64(s1)
    8000254e:	37fd                	addiw	a5,a5,-1
    80002550:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002552:	0000c517          	auipc	a0,0xc
    80002556:	23650513          	addi	a0,a0,566 # 8000e788 <bcache>
    8000255a:	00004097          	auipc	ra,0x4
    8000255e:	c7e080e7          	jalr	-898(ra) # 800061d8 <release>
}
    80002562:	60e2                	ld	ra,24(sp)
    80002564:	6442                	ld	s0,16(sp)
    80002566:	64a2                	ld	s1,8(sp)
    80002568:	6105                	addi	sp,sp,32
    8000256a:	8082                	ret

000000008000256c <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000256c:	1101                	addi	sp,sp,-32
    8000256e:	ec06                	sd	ra,24(sp)
    80002570:	e822                	sd	s0,16(sp)
    80002572:	e426                	sd	s1,8(sp)
    80002574:	e04a                	sd	s2,0(sp)
    80002576:	1000                	addi	s0,sp,32
    80002578:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000257a:	00d5d59b          	srliw	a1,a1,0xd
    8000257e:	00015797          	auipc	a5,0x15
    80002582:	8e67a783          	lw	a5,-1818(a5) # 80016e64 <sb+0x1c>
    80002586:	9dbd                	addw	a1,a1,a5
    80002588:	00000097          	auipc	ra,0x0
    8000258c:	d9e080e7          	jalr	-610(ra) # 80002326 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002590:	0074f713          	andi	a4,s1,7
    80002594:	4785                	li	a5,1
    80002596:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000259a:	14ce                	slli	s1,s1,0x33
    8000259c:	90d9                	srli	s1,s1,0x36
    8000259e:	00950733          	add	a4,a0,s1
    800025a2:	05874703          	lbu	a4,88(a4)
    800025a6:	00e7f6b3          	and	a3,a5,a4
    800025aa:	c69d                	beqz	a3,800025d8 <bfree+0x6c>
    800025ac:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800025ae:	94aa                	add	s1,s1,a0
    800025b0:	fff7c793          	not	a5,a5
    800025b4:	8f7d                	and	a4,a4,a5
    800025b6:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800025ba:	00001097          	auipc	ra,0x1
    800025be:	126080e7          	jalr	294(ra) # 800036e0 <log_write>
  brelse(bp);
    800025c2:	854a                	mv	a0,s2
    800025c4:	00000097          	auipc	ra,0x0
    800025c8:	e92080e7          	jalr	-366(ra) # 80002456 <brelse>
}
    800025cc:	60e2                	ld	ra,24(sp)
    800025ce:	6442                	ld	s0,16(sp)
    800025d0:	64a2                	ld	s1,8(sp)
    800025d2:	6902                	ld	s2,0(sp)
    800025d4:	6105                	addi	sp,sp,32
    800025d6:	8082                	ret
    panic("freeing free block");
    800025d8:	00006517          	auipc	a0,0x6
    800025dc:	f2050513          	addi	a0,a0,-224 # 800084f8 <syscalls+0xe8>
    800025e0:	00003097          	auipc	ra,0x3
    800025e4:	60c080e7          	jalr	1548(ra) # 80005bec <panic>

00000000800025e8 <balloc>:
{
    800025e8:	711d                	addi	sp,sp,-96
    800025ea:	ec86                	sd	ra,88(sp)
    800025ec:	e8a2                	sd	s0,80(sp)
    800025ee:	e4a6                	sd	s1,72(sp)
    800025f0:	e0ca                	sd	s2,64(sp)
    800025f2:	fc4e                	sd	s3,56(sp)
    800025f4:	f852                	sd	s4,48(sp)
    800025f6:	f456                	sd	s5,40(sp)
    800025f8:	f05a                	sd	s6,32(sp)
    800025fa:	ec5e                	sd	s7,24(sp)
    800025fc:	e862                	sd	s8,16(sp)
    800025fe:	e466                	sd	s9,8(sp)
    80002600:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002602:	00015797          	auipc	a5,0x15
    80002606:	84a7a783          	lw	a5,-1974(a5) # 80016e4c <sb+0x4>
    8000260a:	cff5                	beqz	a5,80002706 <balloc+0x11e>
    8000260c:	8baa                	mv	s7,a0
    8000260e:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002610:	00015b17          	auipc	s6,0x15
    80002614:	838b0b13          	addi	s6,s6,-1992 # 80016e48 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002618:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000261a:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000261c:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    8000261e:	6c89                	lui	s9,0x2
    80002620:	a061                	j	800026a8 <balloc+0xc0>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002622:	97ca                	add	a5,a5,s2
    80002624:	8e55                	or	a2,a2,a3
    80002626:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    8000262a:	854a                	mv	a0,s2
    8000262c:	00001097          	auipc	ra,0x1
    80002630:	0b4080e7          	jalr	180(ra) # 800036e0 <log_write>
        brelse(bp);
    80002634:	854a                	mv	a0,s2
    80002636:	00000097          	auipc	ra,0x0
    8000263a:	e20080e7          	jalr	-480(ra) # 80002456 <brelse>
  bp = bread(dev, bno);
    8000263e:	85a6                	mv	a1,s1
    80002640:	855e                	mv	a0,s7
    80002642:	00000097          	auipc	ra,0x0
    80002646:	ce4080e7          	jalr	-796(ra) # 80002326 <bread>
    8000264a:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000264c:	40000613          	li	a2,1024
    80002650:	4581                	li	a1,0
    80002652:	05850513          	addi	a0,a0,88
    80002656:	ffffe097          	auipc	ra,0xffffe
    8000265a:	b24080e7          	jalr	-1244(ra) # 8000017a <memset>
  log_write(bp);
    8000265e:	854a                	mv	a0,s2
    80002660:	00001097          	auipc	ra,0x1
    80002664:	080080e7          	jalr	128(ra) # 800036e0 <log_write>
  brelse(bp);
    80002668:	854a                	mv	a0,s2
    8000266a:	00000097          	auipc	ra,0x0
    8000266e:	dec080e7          	jalr	-532(ra) # 80002456 <brelse>
}
    80002672:	8526                	mv	a0,s1
    80002674:	60e6                	ld	ra,88(sp)
    80002676:	6446                	ld	s0,80(sp)
    80002678:	64a6                	ld	s1,72(sp)
    8000267a:	6906                	ld	s2,64(sp)
    8000267c:	79e2                	ld	s3,56(sp)
    8000267e:	7a42                	ld	s4,48(sp)
    80002680:	7aa2                	ld	s5,40(sp)
    80002682:	7b02                	ld	s6,32(sp)
    80002684:	6be2                	ld	s7,24(sp)
    80002686:	6c42                	ld	s8,16(sp)
    80002688:	6ca2                	ld	s9,8(sp)
    8000268a:	6125                	addi	sp,sp,96
    8000268c:	8082                	ret
    brelse(bp);
    8000268e:	854a                	mv	a0,s2
    80002690:	00000097          	auipc	ra,0x0
    80002694:	dc6080e7          	jalr	-570(ra) # 80002456 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002698:	015c87bb          	addw	a5,s9,s5
    8000269c:	00078a9b          	sext.w	s5,a5
    800026a0:	004b2703          	lw	a4,4(s6)
    800026a4:	06eaf163          	bgeu	s5,a4,80002706 <balloc+0x11e>
    bp = bread(dev, BBLOCK(b, sb));
    800026a8:	41fad79b          	sraiw	a5,s5,0x1f
    800026ac:	0137d79b          	srliw	a5,a5,0x13
    800026b0:	015787bb          	addw	a5,a5,s5
    800026b4:	40d7d79b          	sraiw	a5,a5,0xd
    800026b8:	01cb2583          	lw	a1,28(s6)
    800026bc:	9dbd                	addw	a1,a1,a5
    800026be:	855e                	mv	a0,s7
    800026c0:	00000097          	auipc	ra,0x0
    800026c4:	c66080e7          	jalr	-922(ra) # 80002326 <bread>
    800026c8:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026ca:	004b2503          	lw	a0,4(s6)
    800026ce:	000a849b          	sext.w	s1,s5
    800026d2:	8762                	mv	a4,s8
    800026d4:	faa4fde3          	bgeu	s1,a0,8000268e <balloc+0xa6>
      m = 1 << (bi % 8);
    800026d8:	00777693          	andi	a3,a4,7
    800026dc:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800026e0:	41f7579b          	sraiw	a5,a4,0x1f
    800026e4:	01d7d79b          	srliw	a5,a5,0x1d
    800026e8:	9fb9                	addw	a5,a5,a4
    800026ea:	4037d79b          	sraiw	a5,a5,0x3
    800026ee:	00f90633          	add	a2,s2,a5
    800026f2:	05864603          	lbu	a2,88(a2)
    800026f6:	00c6f5b3          	and	a1,a3,a2
    800026fa:	d585                	beqz	a1,80002622 <balloc+0x3a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026fc:	2705                	addiw	a4,a4,1
    800026fe:	2485                	addiw	s1,s1,1
    80002700:	fd471ae3          	bne	a4,s4,800026d4 <balloc+0xec>
    80002704:	b769                	j	8000268e <balloc+0xa6>
  printf("balloc: out of blocks\n");
    80002706:	00006517          	auipc	a0,0x6
    8000270a:	e0a50513          	addi	a0,a0,-502 # 80008510 <syscalls+0x100>
    8000270e:	00003097          	auipc	ra,0x3
    80002712:	528080e7          	jalr	1320(ra) # 80005c36 <printf>
  return 0;
    80002716:	4481                	li	s1,0
    80002718:	bfa9                	j	80002672 <balloc+0x8a>

000000008000271a <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    8000271a:	7179                	addi	sp,sp,-48
    8000271c:	f406                	sd	ra,40(sp)
    8000271e:	f022                	sd	s0,32(sp)
    80002720:	ec26                	sd	s1,24(sp)
    80002722:	e84a                	sd	s2,16(sp)
    80002724:	e44e                	sd	s3,8(sp)
    80002726:	e052                	sd	s4,0(sp)
    80002728:	1800                	addi	s0,sp,48
    8000272a:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000272c:	47ad                	li	a5,11
    8000272e:	02b7e863          	bltu	a5,a1,8000275e <bmap+0x44>
    if((addr = ip->addrs[bn]) == 0){
    80002732:	02059793          	slli	a5,a1,0x20
    80002736:	01e7d593          	srli	a1,a5,0x1e
    8000273a:	00b504b3          	add	s1,a0,a1
    8000273e:	0504a903          	lw	s2,80(s1)
    80002742:	06091e63          	bnez	s2,800027be <bmap+0xa4>
      addr = balloc(ip->dev);
    80002746:	4108                	lw	a0,0(a0)
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	ea0080e7          	jalr	-352(ra) # 800025e8 <balloc>
    80002750:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002754:	06090563          	beqz	s2,800027be <bmap+0xa4>
        return 0;
      ip->addrs[bn] = addr;
    80002758:	0524a823          	sw	s2,80(s1)
    8000275c:	a08d                	j	800027be <bmap+0xa4>
    }
    return addr;
  }
  bn -= NDIRECT;
    8000275e:	ff45849b          	addiw	s1,a1,-12
    80002762:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    80002766:	0ff00793          	li	a5,255
    8000276a:	08e7e563          	bltu	a5,a4,800027f4 <bmap+0xda>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    8000276e:	08052903          	lw	s2,128(a0)
    80002772:	00091d63          	bnez	s2,8000278c <bmap+0x72>
      addr = balloc(ip->dev);
    80002776:	4108                	lw	a0,0(a0)
    80002778:	00000097          	auipc	ra,0x0
    8000277c:	e70080e7          	jalr	-400(ra) # 800025e8 <balloc>
    80002780:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002784:	02090d63          	beqz	s2,800027be <bmap+0xa4>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002788:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    8000278c:	85ca                	mv	a1,s2
    8000278e:	0009a503          	lw	a0,0(s3)
    80002792:	00000097          	auipc	ra,0x0
    80002796:	b94080e7          	jalr	-1132(ra) # 80002326 <bread>
    8000279a:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000279c:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800027a0:	02049713          	slli	a4,s1,0x20
    800027a4:	01e75593          	srli	a1,a4,0x1e
    800027a8:	00b784b3          	add	s1,a5,a1
    800027ac:	0004a903          	lw	s2,0(s1)
    800027b0:	02090063          	beqz	s2,800027d0 <bmap+0xb6>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    800027b4:	8552                	mv	a0,s4
    800027b6:	00000097          	auipc	ra,0x0
    800027ba:	ca0080e7          	jalr	-864(ra) # 80002456 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800027be:	854a                	mv	a0,s2
    800027c0:	70a2                	ld	ra,40(sp)
    800027c2:	7402                	ld	s0,32(sp)
    800027c4:	64e2                	ld	s1,24(sp)
    800027c6:	6942                	ld	s2,16(sp)
    800027c8:	69a2                	ld	s3,8(sp)
    800027ca:	6a02                	ld	s4,0(sp)
    800027cc:	6145                	addi	sp,sp,48
    800027ce:	8082                	ret
      addr = balloc(ip->dev);
    800027d0:	0009a503          	lw	a0,0(s3)
    800027d4:	00000097          	auipc	ra,0x0
    800027d8:	e14080e7          	jalr	-492(ra) # 800025e8 <balloc>
    800027dc:	0005091b          	sext.w	s2,a0
      if(addr){
    800027e0:	fc090ae3          	beqz	s2,800027b4 <bmap+0x9a>
        a[bn] = addr;
    800027e4:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    800027e8:	8552                	mv	a0,s4
    800027ea:	00001097          	auipc	ra,0x1
    800027ee:	ef6080e7          	jalr	-266(ra) # 800036e0 <log_write>
    800027f2:	b7c9                	j	800027b4 <bmap+0x9a>
  panic("bmap: out of range");
    800027f4:	00006517          	auipc	a0,0x6
    800027f8:	d3450513          	addi	a0,a0,-716 # 80008528 <syscalls+0x118>
    800027fc:	00003097          	auipc	ra,0x3
    80002800:	3f0080e7          	jalr	1008(ra) # 80005bec <panic>

0000000080002804 <iget>:
{
    80002804:	7179                	addi	sp,sp,-48
    80002806:	f406                	sd	ra,40(sp)
    80002808:	f022                	sd	s0,32(sp)
    8000280a:	ec26                	sd	s1,24(sp)
    8000280c:	e84a                	sd	s2,16(sp)
    8000280e:	e44e                	sd	s3,8(sp)
    80002810:	e052                	sd	s4,0(sp)
    80002812:	1800                	addi	s0,sp,48
    80002814:	89aa                	mv	s3,a0
    80002816:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002818:	00014517          	auipc	a0,0x14
    8000281c:	65050513          	addi	a0,a0,1616 # 80016e68 <itable>
    80002820:	00004097          	auipc	ra,0x4
    80002824:	904080e7          	jalr	-1788(ra) # 80006124 <acquire>
  empty = 0;
    80002828:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000282a:	00014497          	auipc	s1,0x14
    8000282e:	65648493          	addi	s1,s1,1622 # 80016e80 <itable+0x18>
    80002832:	00016697          	auipc	a3,0x16
    80002836:	0de68693          	addi	a3,a3,222 # 80018910 <log>
    8000283a:	a039                	j	80002848 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000283c:	02090b63          	beqz	s2,80002872 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002840:	08848493          	addi	s1,s1,136
    80002844:	02d48a63          	beq	s1,a3,80002878 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002848:	449c                	lw	a5,8(s1)
    8000284a:	fef059e3          	blez	a5,8000283c <iget+0x38>
    8000284e:	4098                	lw	a4,0(s1)
    80002850:	ff3716e3          	bne	a4,s3,8000283c <iget+0x38>
    80002854:	40d8                	lw	a4,4(s1)
    80002856:	ff4713e3          	bne	a4,s4,8000283c <iget+0x38>
      ip->ref++;
    8000285a:	2785                	addiw	a5,a5,1
    8000285c:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    8000285e:	00014517          	auipc	a0,0x14
    80002862:	60a50513          	addi	a0,a0,1546 # 80016e68 <itable>
    80002866:	00004097          	auipc	ra,0x4
    8000286a:	972080e7          	jalr	-1678(ra) # 800061d8 <release>
      return ip;
    8000286e:	8926                	mv	s2,s1
    80002870:	a03d                	j	8000289e <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002872:	f7f9                	bnez	a5,80002840 <iget+0x3c>
    80002874:	8926                	mv	s2,s1
    80002876:	b7e9                	j	80002840 <iget+0x3c>
  if(empty == 0)
    80002878:	02090c63          	beqz	s2,800028b0 <iget+0xac>
  ip->dev = dev;
    8000287c:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002880:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002884:	4785                	li	a5,1
    80002886:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000288a:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    8000288e:	00014517          	auipc	a0,0x14
    80002892:	5da50513          	addi	a0,a0,1498 # 80016e68 <itable>
    80002896:	00004097          	auipc	ra,0x4
    8000289a:	942080e7          	jalr	-1726(ra) # 800061d8 <release>
}
    8000289e:	854a                	mv	a0,s2
    800028a0:	70a2                	ld	ra,40(sp)
    800028a2:	7402                	ld	s0,32(sp)
    800028a4:	64e2                	ld	s1,24(sp)
    800028a6:	6942                	ld	s2,16(sp)
    800028a8:	69a2                	ld	s3,8(sp)
    800028aa:	6a02                	ld	s4,0(sp)
    800028ac:	6145                	addi	sp,sp,48
    800028ae:	8082                	ret
    panic("iget: no inodes");
    800028b0:	00006517          	auipc	a0,0x6
    800028b4:	c9050513          	addi	a0,a0,-880 # 80008540 <syscalls+0x130>
    800028b8:	00003097          	auipc	ra,0x3
    800028bc:	334080e7          	jalr	820(ra) # 80005bec <panic>

00000000800028c0 <fsinit>:
fsinit(int dev) {
    800028c0:	7179                	addi	sp,sp,-48
    800028c2:	f406                	sd	ra,40(sp)
    800028c4:	f022                	sd	s0,32(sp)
    800028c6:	ec26                	sd	s1,24(sp)
    800028c8:	e84a                	sd	s2,16(sp)
    800028ca:	e44e                	sd	s3,8(sp)
    800028cc:	1800                	addi	s0,sp,48
    800028ce:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800028d0:	4585                	li	a1,1
    800028d2:	00000097          	auipc	ra,0x0
    800028d6:	a54080e7          	jalr	-1452(ra) # 80002326 <bread>
    800028da:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800028dc:	00014997          	auipc	s3,0x14
    800028e0:	56c98993          	addi	s3,s3,1388 # 80016e48 <sb>
    800028e4:	02000613          	li	a2,32
    800028e8:	05850593          	addi	a1,a0,88
    800028ec:	854e                	mv	a0,s3
    800028ee:	ffffe097          	auipc	ra,0xffffe
    800028f2:	8e8080e7          	jalr	-1816(ra) # 800001d6 <memmove>
  brelse(bp);
    800028f6:	8526                	mv	a0,s1
    800028f8:	00000097          	auipc	ra,0x0
    800028fc:	b5e080e7          	jalr	-1186(ra) # 80002456 <brelse>
  if(sb.magic != FSMAGIC)
    80002900:	0009a703          	lw	a4,0(s3)
    80002904:	102037b7          	lui	a5,0x10203
    80002908:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000290c:	02f71263          	bne	a4,a5,80002930 <fsinit+0x70>
  initlog(dev, &sb);
    80002910:	00014597          	auipc	a1,0x14
    80002914:	53858593          	addi	a1,a1,1336 # 80016e48 <sb>
    80002918:	854a                	mv	a0,s2
    8000291a:	00001097          	auipc	ra,0x1
    8000291e:	b4a080e7          	jalr	-1206(ra) # 80003464 <initlog>
}
    80002922:	70a2                	ld	ra,40(sp)
    80002924:	7402                	ld	s0,32(sp)
    80002926:	64e2                	ld	s1,24(sp)
    80002928:	6942                	ld	s2,16(sp)
    8000292a:	69a2                	ld	s3,8(sp)
    8000292c:	6145                	addi	sp,sp,48
    8000292e:	8082                	ret
    panic("invalid file system");
    80002930:	00006517          	auipc	a0,0x6
    80002934:	c2050513          	addi	a0,a0,-992 # 80008550 <syscalls+0x140>
    80002938:	00003097          	auipc	ra,0x3
    8000293c:	2b4080e7          	jalr	692(ra) # 80005bec <panic>

0000000080002940 <iinit>:
{
    80002940:	7179                	addi	sp,sp,-48
    80002942:	f406                	sd	ra,40(sp)
    80002944:	f022                	sd	s0,32(sp)
    80002946:	ec26                	sd	s1,24(sp)
    80002948:	e84a                	sd	s2,16(sp)
    8000294a:	e44e                	sd	s3,8(sp)
    8000294c:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    8000294e:	00006597          	auipc	a1,0x6
    80002952:	c1a58593          	addi	a1,a1,-998 # 80008568 <syscalls+0x158>
    80002956:	00014517          	auipc	a0,0x14
    8000295a:	51250513          	addi	a0,a0,1298 # 80016e68 <itable>
    8000295e:	00003097          	auipc	ra,0x3
    80002962:	736080e7          	jalr	1846(ra) # 80006094 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002966:	00014497          	auipc	s1,0x14
    8000296a:	52a48493          	addi	s1,s1,1322 # 80016e90 <itable+0x28>
    8000296e:	00016997          	auipc	s3,0x16
    80002972:	fb298993          	addi	s3,s3,-78 # 80018920 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002976:	00006917          	auipc	s2,0x6
    8000297a:	bfa90913          	addi	s2,s2,-1030 # 80008570 <syscalls+0x160>
    8000297e:	85ca                	mv	a1,s2
    80002980:	8526                	mv	a0,s1
    80002982:	00001097          	auipc	ra,0x1
    80002986:	e42080e7          	jalr	-446(ra) # 800037c4 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    8000298a:	08848493          	addi	s1,s1,136
    8000298e:	ff3498e3          	bne	s1,s3,8000297e <iinit+0x3e>
}
    80002992:	70a2                	ld	ra,40(sp)
    80002994:	7402                	ld	s0,32(sp)
    80002996:	64e2                	ld	s1,24(sp)
    80002998:	6942                	ld	s2,16(sp)
    8000299a:	69a2                	ld	s3,8(sp)
    8000299c:	6145                	addi	sp,sp,48
    8000299e:	8082                	ret

00000000800029a0 <ialloc>:
{
    800029a0:	715d                	addi	sp,sp,-80
    800029a2:	e486                	sd	ra,72(sp)
    800029a4:	e0a2                	sd	s0,64(sp)
    800029a6:	fc26                	sd	s1,56(sp)
    800029a8:	f84a                	sd	s2,48(sp)
    800029aa:	f44e                	sd	s3,40(sp)
    800029ac:	f052                	sd	s4,32(sp)
    800029ae:	ec56                	sd	s5,24(sp)
    800029b0:	e85a                	sd	s6,16(sp)
    800029b2:	e45e                	sd	s7,8(sp)
    800029b4:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    800029b6:	00014717          	auipc	a4,0x14
    800029ba:	49e72703          	lw	a4,1182(a4) # 80016e54 <sb+0xc>
    800029be:	4785                	li	a5,1
    800029c0:	04e7fa63          	bgeu	a5,a4,80002a14 <ialloc+0x74>
    800029c4:	8aaa                	mv	s5,a0
    800029c6:	8bae                	mv	s7,a1
    800029c8:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800029ca:	00014a17          	auipc	s4,0x14
    800029ce:	47ea0a13          	addi	s4,s4,1150 # 80016e48 <sb>
    800029d2:	00048b1b          	sext.w	s6,s1
    800029d6:	0044d593          	srli	a1,s1,0x4
    800029da:	018a2783          	lw	a5,24(s4)
    800029de:	9dbd                	addw	a1,a1,a5
    800029e0:	8556                	mv	a0,s5
    800029e2:	00000097          	auipc	ra,0x0
    800029e6:	944080e7          	jalr	-1724(ra) # 80002326 <bread>
    800029ea:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800029ec:	05850993          	addi	s3,a0,88
    800029f0:	00f4f793          	andi	a5,s1,15
    800029f4:	079a                	slli	a5,a5,0x6
    800029f6:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800029f8:	00099783          	lh	a5,0(s3)
    800029fc:	c3a1                	beqz	a5,80002a3c <ialloc+0x9c>
    brelse(bp);
    800029fe:	00000097          	auipc	ra,0x0
    80002a02:	a58080e7          	jalr	-1448(ra) # 80002456 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a06:	0485                	addi	s1,s1,1
    80002a08:	00ca2703          	lw	a4,12(s4)
    80002a0c:	0004879b          	sext.w	a5,s1
    80002a10:	fce7e1e3          	bltu	a5,a4,800029d2 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    80002a14:	00006517          	auipc	a0,0x6
    80002a18:	b6450513          	addi	a0,a0,-1180 # 80008578 <syscalls+0x168>
    80002a1c:	00003097          	auipc	ra,0x3
    80002a20:	21a080e7          	jalr	538(ra) # 80005c36 <printf>
  return 0;
    80002a24:	4501                	li	a0,0
}
    80002a26:	60a6                	ld	ra,72(sp)
    80002a28:	6406                	ld	s0,64(sp)
    80002a2a:	74e2                	ld	s1,56(sp)
    80002a2c:	7942                	ld	s2,48(sp)
    80002a2e:	79a2                	ld	s3,40(sp)
    80002a30:	7a02                	ld	s4,32(sp)
    80002a32:	6ae2                	ld	s5,24(sp)
    80002a34:	6b42                	ld	s6,16(sp)
    80002a36:	6ba2                	ld	s7,8(sp)
    80002a38:	6161                	addi	sp,sp,80
    80002a3a:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002a3c:	04000613          	li	a2,64
    80002a40:	4581                	li	a1,0
    80002a42:	854e                	mv	a0,s3
    80002a44:	ffffd097          	auipc	ra,0xffffd
    80002a48:	736080e7          	jalr	1846(ra) # 8000017a <memset>
      dip->type = type;
    80002a4c:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002a50:	854a                	mv	a0,s2
    80002a52:	00001097          	auipc	ra,0x1
    80002a56:	c8e080e7          	jalr	-882(ra) # 800036e0 <log_write>
      brelse(bp);
    80002a5a:	854a                	mv	a0,s2
    80002a5c:	00000097          	auipc	ra,0x0
    80002a60:	9fa080e7          	jalr	-1542(ra) # 80002456 <brelse>
      return iget(dev, inum);
    80002a64:	85da                	mv	a1,s6
    80002a66:	8556                	mv	a0,s5
    80002a68:	00000097          	auipc	ra,0x0
    80002a6c:	d9c080e7          	jalr	-612(ra) # 80002804 <iget>
    80002a70:	bf5d                	j	80002a26 <ialloc+0x86>

0000000080002a72 <iupdate>:
{
    80002a72:	1101                	addi	sp,sp,-32
    80002a74:	ec06                	sd	ra,24(sp)
    80002a76:	e822                	sd	s0,16(sp)
    80002a78:	e426                	sd	s1,8(sp)
    80002a7a:	e04a                	sd	s2,0(sp)
    80002a7c:	1000                	addi	s0,sp,32
    80002a7e:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a80:	415c                	lw	a5,4(a0)
    80002a82:	0047d79b          	srliw	a5,a5,0x4
    80002a86:	00014597          	auipc	a1,0x14
    80002a8a:	3da5a583          	lw	a1,986(a1) # 80016e60 <sb+0x18>
    80002a8e:	9dbd                	addw	a1,a1,a5
    80002a90:	4108                	lw	a0,0(a0)
    80002a92:	00000097          	auipc	ra,0x0
    80002a96:	894080e7          	jalr	-1900(ra) # 80002326 <bread>
    80002a9a:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002a9c:	05850793          	addi	a5,a0,88
    80002aa0:	40d8                	lw	a4,4(s1)
    80002aa2:	8b3d                	andi	a4,a4,15
    80002aa4:	071a                	slli	a4,a4,0x6
    80002aa6:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002aa8:	04449703          	lh	a4,68(s1)
    80002aac:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002ab0:	04649703          	lh	a4,70(s1)
    80002ab4:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002ab8:	04849703          	lh	a4,72(s1)
    80002abc:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002ac0:	04a49703          	lh	a4,74(s1)
    80002ac4:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ac8:	44f8                	lw	a4,76(s1)
    80002aca:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002acc:	03400613          	li	a2,52
    80002ad0:	05048593          	addi	a1,s1,80
    80002ad4:	00c78513          	addi	a0,a5,12
    80002ad8:	ffffd097          	auipc	ra,0xffffd
    80002adc:	6fe080e7          	jalr	1790(ra) # 800001d6 <memmove>
  log_write(bp);
    80002ae0:	854a                	mv	a0,s2
    80002ae2:	00001097          	auipc	ra,0x1
    80002ae6:	bfe080e7          	jalr	-1026(ra) # 800036e0 <log_write>
  brelse(bp);
    80002aea:	854a                	mv	a0,s2
    80002aec:	00000097          	auipc	ra,0x0
    80002af0:	96a080e7          	jalr	-1686(ra) # 80002456 <brelse>
}
    80002af4:	60e2                	ld	ra,24(sp)
    80002af6:	6442                	ld	s0,16(sp)
    80002af8:	64a2                	ld	s1,8(sp)
    80002afa:	6902                	ld	s2,0(sp)
    80002afc:	6105                	addi	sp,sp,32
    80002afe:	8082                	ret

0000000080002b00 <idup>:
{
    80002b00:	1101                	addi	sp,sp,-32
    80002b02:	ec06                	sd	ra,24(sp)
    80002b04:	e822                	sd	s0,16(sp)
    80002b06:	e426                	sd	s1,8(sp)
    80002b08:	1000                	addi	s0,sp,32
    80002b0a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002b0c:	00014517          	auipc	a0,0x14
    80002b10:	35c50513          	addi	a0,a0,860 # 80016e68 <itable>
    80002b14:	00003097          	auipc	ra,0x3
    80002b18:	610080e7          	jalr	1552(ra) # 80006124 <acquire>
  ip->ref++;
    80002b1c:	449c                	lw	a5,8(s1)
    80002b1e:	2785                	addiw	a5,a5,1
    80002b20:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002b22:	00014517          	auipc	a0,0x14
    80002b26:	34650513          	addi	a0,a0,838 # 80016e68 <itable>
    80002b2a:	00003097          	auipc	ra,0x3
    80002b2e:	6ae080e7          	jalr	1710(ra) # 800061d8 <release>
}
    80002b32:	8526                	mv	a0,s1
    80002b34:	60e2                	ld	ra,24(sp)
    80002b36:	6442                	ld	s0,16(sp)
    80002b38:	64a2                	ld	s1,8(sp)
    80002b3a:	6105                	addi	sp,sp,32
    80002b3c:	8082                	ret

0000000080002b3e <ilock>:
{
    80002b3e:	1101                	addi	sp,sp,-32
    80002b40:	ec06                	sd	ra,24(sp)
    80002b42:	e822                	sd	s0,16(sp)
    80002b44:	e426                	sd	s1,8(sp)
    80002b46:	e04a                	sd	s2,0(sp)
    80002b48:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002b4a:	c115                	beqz	a0,80002b6e <ilock+0x30>
    80002b4c:	84aa                	mv	s1,a0
    80002b4e:	451c                	lw	a5,8(a0)
    80002b50:	00f05f63          	blez	a5,80002b6e <ilock+0x30>
  acquiresleep(&ip->lock);
    80002b54:	0541                	addi	a0,a0,16
    80002b56:	00001097          	auipc	ra,0x1
    80002b5a:	ca8080e7          	jalr	-856(ra) # 800037fe <acquiresleep>
  if(ip->valid == 0){
    80002b5e:	40bc                	lw	a5,64(s1)
    80002b60:	cf99                	beqz	a5,80002b7e <ilock+0x40>
}
    80002b62:	60e2                	ld	ra,24(sp)
    80002b64:	6442                	ld	s0,16(sp)
    80002b66:	64a2                	ld	s1,8(sp)
    80002b68:	6902                	ld	s2,0(sp)
    80002b6a:	6105                	addi	sp,sp,32
    80002b6c:	8082                	ret
    panic("ilock");
    80002b6e:	00006517          	auipc	a0,0x6
    80002b72:	a2250513          	addi	a0,a0,-1502 # 80008590 <syscalls+0x180>
    80002b76:	00003097          	auipc	ra,0x3
    80002b7a:	076080e7          	jalr	118(ra) # 80005bec <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b7e:	40dc                	lw	a5,4(s1)
    80002b80:	0047d79b          	srliw	a5,a5,0x4
    80002b84:	00014597          	auipc	a1,0x14
    80002b88:	2dc5a583          	lw	a1,732(a1) # 80016e60 <sb+0x18>
    80002b8c:	9dbd                	addw	a1,a1,a5
    80002b8e:	4088                	lw	a0,0(s1)
    80002b90:	fffff097          	auipc	ra,0xfffff
    80002b94:	796080e7          	jalr	1942(ra) # 80002326 <bread>
    80002b98:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b9a:	05850593          	addi	a1,a0,88
    80002b9e:	40dc                	lw	a5,4(s1)
    80002ba0:	8bbd                	andi	a5,a5,15
    80002ba2:	079a                	slli	a5,a5,0x6
    80002ba4:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002ba6:	00059783          	lh	a5,0(a1)
    80002baa:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002bae:	00259783          	lh	a5,2(a1)
    80002bb2:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002bb6:	00459783          	lh	a5,4(a1)
    80002bba:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002bbe:	00659783          	lh	a5,6(a1)
    80002bc2:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002bc6:	459c                	lw	a5,8(a1)
    80002bc8:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002bca:	03400613          	li	a2,52
    80002bce:	05b1                	addi	a1,a1,12
    80002bd0:	05048513          	addi	a0,s1,80
    80002bd4:	ffffd097          	auipc	ra,0xffffd
    80002bd8:	602080e7          	jalr	1538(ra) # 800001d6 <memmove>
    brelse(bp);
    80002bdc:	854a                	mv	a0,s2
    80002bde:	00000097          	auipc	ra,0x0
    80002be2:	878080e7          	jalr	-1928(ra) # 80002456 <brelse>
    ip->valid = 1;
    80002be6:	4785                	li	a5,1
    80002be8:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002bea:	04449783          	lh	a5,68(s1)
    80002bee:	fbb5                	bnez	a5,80002b62 <ilock+0x24>
      panic("ilock: no type");
    80002bf0:	00006517          	auipc	a0,0x6
    80002bf4:	9a850513          	addi	a0,a0,-1624 # 80008598 <syscalls+0x188>
    80002bf8:	00003097          	auipc	ra,0x3
    80002bfc:	ff4080e7          	jalr	-12(ra) # 80005bec <panic>

0000000080002c00 <iunlock>:
{
    80002c00:	1101                	addi	sp,sp,-32
    80002c02:	ec06                	sd	ra,24(sp)
    80002c04:	e822                	sd	s0,16(sp)
    80002c06:	e426                	sd	s1,8(sp)
    80002c08:	e04a                	sd	s2,0(sp)
    80002c0a:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c0c:	c905                	beqz	a0,80002c3c <iunlock+0x3c>
    80002c0e:	84aa                	mv	s1,a0
    80002c10:	01050913          	addi	s2,a0,16
    80002c14:	854a                	mv	a0,s2
    80002c16:	00001097          	auipc	ra,0x1
    80002c1a:	c82080e7          	jalr	-894(ra) # 80003898 <holdingsleep>
    80002c1e:	cd19                	beqz	a0,80002c3c <iunlock+0x3c>
    80002c20:	449c                	lw	a5,8(s1)
    80002c22:	00f05d63          	blez	a5,80002c3c <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002c26:	854a                	mv	a0,s2
    80002c28:	00001097          	auipc	ra,0x1
    80002c2c:	c2c080e7          	jalr	-980(ra) # 80003854 <releasesleep>
}
    80002c30:	60e2                	ld	ra,24(sp)
    80002c32:	6442                	ld	s0,16(sp)
    80002c34:	64a2                	ld	s1,8(sp)
    80002c36:	6902                	ld	s2,0(sp)
    80002c38:	6105                	addi	sp,sp,32
    80002c3a:	8082                	ret
    panic("iunlock");
    80002c3c:	00006517          	auipc	a0,0x6
    80002c40:	96c50513          	addi	a0,a0,-1684 # 800085a8 <syscalls+0x198>
    80002c44:	00003097          	auipc	ra,0x3
    80002c48:	fa8080e7          	jalr	-88(ra) # 80005bec <panic>

0000000080002c4c <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002c4c:	7179                	addi	sp,sp,-48
    80002c4e:	f406                	sd	ra,40(sp)
    80002c50:	f022                	sd	s0,32(sp)
    80002c52:	ec26                	sd	s1,24(sp)
    80002c54:	e84a                	sd	s2,16(sp)
    80002c56:	e44e                	sd	s3,8(sp)
    80002c58:	e052                	sd	s4,0(sp)
    80002c5a:	1800                	addi	s0,sp,48
    80002c5c:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002c5e:	05050493          	addi	s1,a0,80
    80002c62:	08050913          	addi	s2,a0,128
    80002c66:	a021                	j	80002c6e <itrunc+0x22>
    80002c68:	0491                	addi	s1,s1,4
    80002c6a:	01248d63          	beq	s1,s2,80002c84 <itrunc+0x38>
    if(ip->addrs[i]){
    80002c6e:	408c                	lw	a1,0(s1)
    80002c70:	dde5                	beqz	a1,80002c68 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002c72:	0009a503          	lw	a0,0(s3)
    80002c76:	00000097          	auipc	ra,0x0
    80002c7a:	8f6080e7          	jalr	-1802(ra) # 8000256c <bfree>
      ip->addrs[i] = 0;
    80002c7e:	0004a023          	sw	zero,0(s1)
    80002c82:	b7dd                	j	80002c68 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002c84:	0809a583          	lw	a1,128(s3)
    80002c88:	e185                	bnez	a1,80002ca8 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002c8a:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002c8e:	854e                	mv	a0,s3
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	de2080e7          	jalr	-542(ra) # 80002a72 <iupdate>
}
    80002c98:	70a2                	ld	ra,40(sp)
    80002c9a:	7402                	ld	s0,32(sp)
    80002c9c:	64e2                	ld	s1,24(sp)
    80002c9e:	6942                	ld	s2,16(sp)
    80002ca0:	69a2                	ld	s3,8(sp)
    80002ca2:	6a02                	ld	s4,0(sp)
    80002ca4:	6145                	addi	sp,sp,48
    80002ca6:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002ca8:	0009a503          	lw	a0,0(s3)
    80002cac:	fffff097          	auipc	ra,0xfffff
    80002cb0:	67a080e7          	jalr	1658(ra) # 80002326 <bread>
    80002cb4:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002cb6:	05850493          	addi	s1,a0,88
    80002cba:	45850913          	addi	s2,a0,1112
    80002cbe:	a021                	j	80002cc6 <itrunc+0x7a>
    80002cc0:	0491                	addi	s1,s1,4
    80002cc2:	01248b63          	beq	s1,s2,80002cd8 <itrunc+0x8c>
      if(a[j])
    80002cc6:	408c                	lw	a1,0(s1)
    80002cc8:	dde5                	beqz	a1,80002cc0 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80002cca:	0009a503          	lw	a0,0(s3)
    80002cce:	00000097          	auipc	ra,0x0
    80002cd2:	89e080e7          	jalr	-1890(ra) # 8000256c <bfree>
    80002cd6:	b7ed                	j	80002cc0 <itrunc+0x74>
    brelse(bp);
    80002cd8:	8552                	mv	a0,s4
    80002cda:	fffff097          	auipc	ra,0xfffff
    80002cde:	77c080e7          	jalr	1916(ra) # 80002456 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002ce2:	0809a583          	lw	a1,128(s3)
    80002ce6:	0009a503          	lw	a0,0(s3)
    80002cea:	00000097          	auipc	ra,0x0
    80002cee:	882080e7          	jalr	-1918(ra) # 8000256c <bfree>
    ip->addrs[NDIRECT] = 0;
    80002cf2:	0809a023          	sw	zero,128(s3)
    80002cf6:	bf51                	j	80002c8a <itrunc+0x3e>

0000000080002cf8 <iput>:
{
    80002cf8:	1101                	addi	sp,sp,-32
    80002cfa:	ec06                	sd	ra,24(sp)
    80002cfc:	e822                	sd	s0,16(sp)
    80002cfe:	e426                	sd	s1,8(sp)
    80002d00:	e04a                	sd	s2,0(sp)
    80002d02:	1000                	addi	s0,sp,32
    80002d04:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002d06:	00014517          	auipc	a0,0x14
    80002d0a:	16250513          	addi	a0,a0,354 # 80016e68 <itable>
    80002d0e:	00003097          	auipc	ra,0x3
    80002d12:	416080e7          	jalr	1046(ra) # 80006124 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002d16:	4498                	lw	a4,8(s1)
    80002d18:	4785                	li	a5,1
    80002d1a:	02f70363          	beq	a4,a5,80002d40 <iput+0x48>
  ip->ref--;
    80002d1e:	449c                	lw	a5,8(s1)
    80002d20:	37fd                	addiw	a5,a5,-1
    80002d22:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d24:	00014517          	auipc	a0,0x14
    80002d28:	14450513          	addi	a0,a0,324 # 80016e68 <itable>
    80002d2c:	00003097          	auipc	ra,0x3
    80002d30:	4ac080e7          	jalr	1196(ra) # 800061d8 <release>
}
    80002d34:	60e2                	ld	ra,24(sp)
    80002d36:	6442                	ld	s0,16(sp)
    80002d38:	64a2                	ld	s1,8(sp)
    80002d3a:	6902                	ld	s2,0(sp)
    80002d3c:	6105                	addi	sp,sp,32
    80002d3e:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002d40:	40bc                	lw	a5,64(s1)
    80002d42:	dff1                	beqz	a5,80002d1e <iput+0x26>
    80002d44:	04a49783          	lh	a5,74(s1)
    80002d48:	fbf9                	bnez	a5,80002d1e <iput+0x26>
    acquiresleep(&ip->lock);
    80002d4a:	01048913          	addi	s2,s1,16
    80002d4e:	854a                	mv	a0,s2
    80002d50:	00001097          	auipc	ra,0x1
    80002d54:	aae080e7          	jalr	-1362(ra) # 800037fe <acquiresleep>
    release(&itable.lock);
    80002d58:	00014517          	auipc	a0,0x14
    80002d5c:	11050513          	addi	a0,a0,272 # 80016e68 <itable>
    80002d60:	00003097          	auipc	ra,0x3
    80002d64:	478080e7          	jalr	1144(ra) # 800061d8 <release>
    itrunc(ip);
    80002d68:	8526                	mv	a0,s1
    80002d6a:	00000097          	auipc	ra,0x0
    80002d6e:	ee2080e7          	jalr	-286(ra) # 80002c4c <itrunc>
    ip->type = 0;
    80002d72:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002d76:	8526                	mv	a0,s1
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	cfa080e7          	jalr	-774(ra) # 80002a72 <iupdate>
    ip->valid = 0;
    80002d80:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002d84:	854a                	mv	a0,s2
    80002d86:	00001097          	auipc	ra,0x1
    80002d8a:	ace080e7          	jalr	-1330(ra) # 80003854 <releasesleep>
    acquire(&itable.lock);
    80002d8e:	00014517          	auipc	a0,0x14
    80002d92:	0da50513          	addi	a0,a0,218 # 80016e68 <itable>
    80002d96:	00003097          	auipc	ra,0x3
    80002d9a:	38e080e7          	jalr	910(ra) # 80006124 <acquire>
    80002d9e:	b741                	j	80002d1e <iput+0x26>

0000000080002da0 <iunlockput>:
{
    80002da0:	1101                	addi	sp,sp,-32
    80002da2:	ec06                	sd	ra,24(sp)
    80002da4:	e822                	sd	s0,16(sp)
    80002da6:	e426                	sd	s1,8(sp)
    80002da8:	1000                	addi	s0,sp,32
    80002daa:	84aa                	mv	s1,a0
  iunlock(ip);
    80002dac:	00000097          	auipc	ra,0x0
    80002db0:	e54080e7          	jalr	-428(ra) # 80002c00 <iunlock>
  iput(ip);
    80002db4:	8526                	mv	a0,s1
    80002db6:	00000097          	auipc	ra,0x0
    80002dba:	f42080e7          	jalr	-190(ra) # 80002cf8 <iput>
}
    80002dbe:	60e2                	ld	ra,24(sp)
    80002dc0:	6442                	ld	s0,16(sp)
    80002dc2:	64a2                	ld	s1,8(sp)
    80002dc4:	6105                	addi	sp,sp,32
    80002dc6:	8082                	ret

0000000080002dc8 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002dc8:	1141                	addi	sp,sp,-16
    80002dca:	e422                	sd	s0,8(sp)
    80002dcc:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002dce:	411c                	lw	a5,0(a0)
    80002dd0:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002dd2:	415c                	lw	a5,4(a0)
    80002dd4:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002dd6:	04451783          	lh	a5,68(a0)
    80002dda:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002dde:	04a51783          	lh	a5,74(a0)
    80002de2:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002de6:	04c56783          	lwu	a5,76(a0)
    80002dea:	e99c                	sd	a5,16(a1)
}
    80002dec:	6422                	ld	s0,8(sp)
    80002dee:	0141                	addi	sp,sp,16
    80002df0:	8082                	ret

0000000080002df2 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002df2:	457c                	lw	a5,76(a0)
    80002df4:	0ed7e963          	bltu	a5,a3,80002ee6 <readi+0xf4>
{
    80002df8:	7159                	addi	sp,sp,-112
    80002dfa:	f486                	sd	ra,104(sp)
    80002dfc:	f0a2                	sd	s0,96(sp)
    80002dfe:	eca6                	sd	s1,88(sp)
    80002e00:	e8ca                	sd	s2,80(sp)
    80002e02:	e4ce                	sd	s3,72(sp)
    80002e04:	e0d2                	sd	s4,64(sp)
    80002e06:	fc56                	sd	s5,56(sp)
    80002e08:	f85a                	sd	s6,48(sp)
    80002e0a:	f45e                	sd	s7,40(sp)
    80002e0c:	f062                	sd	s8,32(sp)
    80002e0e:	ec66                	sd	s9,24(sp)
    80002e10:	e86a                	sd	s10,16(sp)
    80002e12:	e46e                	sd	s11,8(sp)
    80002e14:	1880                	addi	s0,sp,112
    80002e16:	8b2a                	mv	s6,a0
    80002e18:	8bae                	mv	s7,a1
    80002e1a:	8a32                	mv	s4,a2
    80002e1c:	84b6                	mv	s1,a3
    80002e1e:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002e20:	9f35                	addw	a4,a4,a3
    return 0;
    80002e22:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002e24:	0ad76063          	bltu	a4,a3,80002ec4 <readi+0xd2>
  if(off + n > ip->size)
    80002e28:	00e7f463          	bgeu	a5,a4,80002e30 <readi+0x3e>
    n = ip->size - off;
    80002e2c:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e30:	0a0a8963          	beqz	s5,80002ee2 <readi+0xf0>
    80002e34:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e36:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002e3a:	5c7d                	li	s8,-1
    80002e3c:	a82d                	j	80002e76 <readi+0x84>
    80002e3e:	020d1d93          	slli	s11,s10,0x20
    80002e42:	020ddd93          	srli	s11,s11,0x20
    80002e46:	05890613          	addi	a2,s2,88
    80002e4a:	86ee                	mv	a3,s11
    80002e4c:	963a                	add	a2,a2,a4
    80002e4e:	85d2                	mv	a1,s4
    80002e50:	855e                	mv	a0,s7
    80002e52:	fffff097          	auipc	ra,0xfffff
    80002e56:	b0e080e7          	jalr	-1266(ra) # 80001960 <either_copyout>
    80002e5a:	05850d63          	beq	a0,s8,80002eb4 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002e5e:	854a                	mv	a0,s2
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	5f6080e7          	jalr	1526(ra) # 80002456 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e68:	013d09bb          	addw	s3,s10,s3
    80002e6c:	009d04bb          	addw	s1,s10,s1
    80002e70:	9a6e                	add	s4,s4,s11
    80002e72:	0559f763          	bgeu	s3,s5,80002ec0 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80002e76:	00a4d59b          	srliw	a1,s1,0xa
    80002e7a:	855a                	mv	a0,s6
    80002e7c:	00000097          	auipc	ra,0x0
    80002e80:	89e080e7          	jalr	-1890(ra) # 8000271a <bmap>
    80002e84:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002e88:	cd85                	beqz	a1,80002ec0 <readi+0xce>
    bp = bread(ip->dev, addr);
    80002e8a:	000b2503          	lw	a0,0(s6)
    80002e8e:	fffff097          	auipc	ra,0xfffff
    80002e92:	498080e7          	jalr	1176(ra) # 80002326 <bread>
    80002e96:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e98:	3ff4f713          	andi	a4,s1,1023
    80002e9c:	40ec87bb          	subw	a5,s9,a4
    80002ea0:	413a86bb          	subw	a3,s5,s3
    80002ea4:	8d3e                	mv	s10,a5
    80002ea6:	2781                	sext.w	a5,a5
    80002ea8:	0006861b          	sext.w	a2,a3
    80002eac:	f8f679e3          	bgeu	a2,a5,80002e3e <readi+0x4c>
    80002eb0:	8d36                	mv	s10,a3
    80002eb2:	b771                	j	80002e3e <readi+0x4c>
      brelse(bp);
    80002eb4:	854a                	mv	a0,s2
    80002eb6:	fffff097          	auipc	ra,0xfffff
    80002eba:	5a0080e7          	jalr	1440(ra) # 80002456 <brelse>
      tot = -1;
    80002ebe:	59fd                	li	s3,-1
  }
  return tot;
    80002ec0:	0009851b          	sext.w	a0,s3
}
    80002ec4:	70a6                	ld	ra,104(sp)
    80002ec6:	7406                	ld	s0,96(sp)
    80002ec8:	64e6                	ld	s1,88(sp)
    80002eca:	6946                	ld	s2,80(sp)
    80002ecc:	69a6                	ld	s3,72(sp)
    80002ece:	6a06                	ld	s4,64(sp)
    80002ed0:	7ae2                	ld	s5,56(sp)
    80002ed2:	7b42                	ld	s6,48(sp)
    80002ed4:	7ba2                	ld	s7,40(sp)
    80002ed6:	7c02                	ld	s8,32(sp)
    80002ed8:	6ce2                	ld	s9,24(sp)
    80002eda:	6d42                	ld	s10,16(sp)
    80002edc:	6da2                	ld	s11,8(sp)
    80002ede:	6165                	addi	sp,sp,112
    80002ee0:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002ee2:	89d6                	mv	s3,s5
    80002ee4:	bff1                	j	80002ec0 <readi+0xce>
    return 0;
    80002ee6:	4501                	li	a0,0
}
    80002ee8:	8082                	ret

0000000080002eea <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002eea:	457c                	lw	a5,76(a0)
    80002eec:	10d7e863          	bltu	a5,a3,80002ffc <writei+0x112>
{
    80002ef0:	7159                	addi	sp,sp,-112
    80002ef2:	f486                	sd	ra,104(sp)
    80002ef4:	f0a2                	sd	s0,96(sp)
    80002ef6:	eca6                	sd	s1,88(sp)
    80002ef8:	e8ca                	sd	s2,80(sp)
    80002efa:	e4ce                	sd	s3,72(sp)
    80002efc:	e0d2                	sd	s4,64(sp)
    80002efe:	fc56                	sd	s5,56(sp)
    80002f00:	f85a                	sd	s6,48(sp)
    80002f02:	f45e                	sd	s7,40(sp)
    80002f04:	f062                	sd	s8,32(sp)
    80002f06:	ec66                	sd	s9,24(sp)
    80002f08:	e86a                	sd	s10,16(sp)
    80002f0a:	e46e                	sd	s11,8(sp)
    80002f0c:	1880                	addi	s0,sp,112
    80002f0e:	8aaa                	mv	s5,a0
    80002f10:	8bae                	mv	s7,a1
    80002f12:	8a32                	mv	s4,a2
    80002f14:	8936                	mv	s2,a3
    80002f16:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002f18:	00e687bb          	addw	a5,a3,a4
    80002f1c:	0ed7e263          	bltu	a5,a3,80003000 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002f20:	00043737          	lui	a4,0x43
    80002f24:	0ef76063          	bltu	a4,a5,80003004 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f28:	0c0b0863          	beqz	s6,80002ff8 <writei+0x10e>
    80002f2c:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f2e:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002f32:	5c7d                	li	s8,-1
    80002f34:	a091                	j	80002f78 <writei+0x8e>
    80002f36:	020d1d93          	slli	s11,s10,0x20
    80002f3a:	020ddd93          	srli	s11,s11,0x20
    80002f3e:	05848513          	addi	a0,s1,88
    80002f42:	86ee                	mv	a3,s11
    80002f44:	8652                	mv	a2,s4
    80002f46:	85de                	mv	a1,s7
    80002f48:	953a                	add	a0,a0,a4
    80002f4a:	fffff097          	auipc	ra,0xfffff
    80002f4e:	a6c080e7          	jalr	-1428(ra) # 800019b6 <either_copyin>
    80002f52:	07850263          	beq	a0,s8,80002fb6 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002f56:	8526                	mv	a0,s1
    80002f58:	00000097          	auipc	ra,0x0
    80002f5c:	788080e7          	jalr	1928(ra) # 800036e0 <log_write>
    brelse(bp);
    80002f60:	8526                	mv	a0,s1
    80002f62:	fffff097          	auipc	ra,0xfffff
    80002f66:	4f4080e7          	jalr	1268(ra) # 80002456 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f6a:	013d09bb          	addw	s3,s10,s3
    80002f6e:	012d093b          	addw	s2,s10,s2
    80002f72:	9a6e                	add	s4,s4,s11
    80002f74:	0569f663          	bgeu	s3,s6,80002fc0 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80002f78:	00a9559b          	srliw	a1,s2,0xa
    80002f7c:	8556                	mv	a0,s5
    80002f7e:	fffff097          	auipc	ra,0xfffff
    80002f82:	79c080e7          	jalr	1948(ra) # 8000271a <bmap>
    80002f86:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002f8a:	c99d                	beqz	a1,80002fc0 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80002f8c:	000aa503          	lw	a0,0(s5)
    80002f90:	fffff097          	auipc	ra,0xfffff
    80002f94:	396080e7          	jalr	918(ra) # 80002326 <bread>
    80002f98:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f9a:	3ff97713          	andi	a4,s2,1023
    80002f9e:	40ec87bb          	subw	a5,s9,a4
    80002fa2:	413b06bb          	subw	a3,s6,s3
    80002fa6:	8d3e                	mv	s10,a5
    80002fa8:	2781                	sext.w	a5,a5
    80002faa:	0006861b          	sext.w	a2,a3
    80002fae:	f8f674e3          	bgeu	a2,a5,80002f36 <writei+0x4c>
    80002fb2:	8d36                	mv	s10,a3
    80002fb4:	b749                	j	80002f36 <writei+0x4c>
      brelse(bp);
    80002fb6:	8526                	mv	a0,s1
    80002fb8:	fffff097          	auipc	ra,0xfffff
    80002fbc:	49e080e7          	jalr	1182(ra) # 80002456 <brelse>
  }

  if(off > ip->size)
    80002fc0:	04caa783          	lw	a5,76(s5)
    80002fc4:	0127f463          	bgeu	a5,s2,80002fcc <writei+0xe2>
    ip->size = off;
    80002fc8:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002fcc:	8556                	mv	a0,s5
    80002fce:	00000097          	auipc	ra,0x0
    80002fd2:	aa4080e7          	jalr	-1372(ra) # 80002a72 <iupdate>

  return tot;
    80002fd6:	0009851b          	sext.w	a0,s3
}
    80002fda:	70a6                	ld	ra,104(sp)
    80002fdc:	7406                	ld	s0,96(sp)
    80002fde:	64e6                	ld	s1,88(sp)
    80002fe0:	6946                	ld	s2,80(sp)
    80002fe2:	69a6                	ld	s3,72(sp)
    80002fe4:	6a06                	ld	s4,64(sp)
    80002fe6:	7ae2                	ld	s5,56(sp)
    80002fe8:	7b42                	ld	s6,48(sp)
    80002fea:	7ba2                	ld	s7,40(sp)
    80002fec:	7c02                	ld	s8,32(sp)
    80002fee:	6ce2                	ld	s9,24(sp)
    80002ff0:	6d42                	ld	s10,16(sp)
    80002ff2:	6da2                	ld	s11,8(sp)
    80002ff4:	6165                	addi	sp,sp,112
    80002ff6:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002ff8:	89da                	mv	s3,s6
    80002ffa:	bfc9                	j	80002fcc <writei+0xe2>
    return -1;
    80002ffc:	557d                	li	a0,-1
}
    80002ffe:	8082                	ret
    return -1;
    80003000:	557d                	li	a0,-1
    80003002:	bfe1                	j	80002fda <writei+0xf0>
    return -1;
    80003004:	557d                	li	a0,-1
    80003006:	bfd1                	j	80002fda <writei+0xf0>

0000000080003008 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003008:	1141                	addi	sp,sp,-16
    8000300a:	e406                	sd	ra,8(sp)
    8000300c:	e022                	sd	s0,0(sp)
    8000300e:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003010:	4639                	li	a2,14
    80003012:	ffffd097          	auipc	ra,0xffffd
    80003016:	238080e7          	jalr	568(ra) # 8000024a <strncmp>
}
    8000301a:	60a2                	ld	ra,8(sp)
    8000301c:	6402                	ld	s0,0(sp)
    8000301e:	0141                	addi	sp,sp,16
    80003020:	8082                	ret

0000000080003022 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003022:	7139                	addi	sp,sp,-64
    80003024:	fc06                	sd	ra,56(sp)
    80003026:	f822                	sd	s0,48(sp)
    80003028:	f426                	sd	s1,40(sp)
    8000302a:	f04a                	sd	s2,32(sp)
    8000302c:	ec4e                	sd	s3,24(sp)
    8000302e:	e852                	sd	s4,16(sp)
    80003030:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003032:	04451703          	lh	a4,68(a0)
    80003036:	4785                	li	a5,1
    80003038:	00f71a63          	bne	a4,a5,8000304c <dirlookup+0x2a>
    8000303c:	892a                	mv	s2,a0
    8000303e:	89ae                	mv	s3,a1
    80003040:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003042:	457c                	lw	a5,76(a0)
    80003044:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003046:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003048:	e79d                	bnez	a5,80003076 <dirlookup+0x54>
    8000304a:	a8a5                	j	800030c2 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    8000304c:	00005517          	auipc	a0,0x5
    80003050:	56450513          	addi	a0,a0,1380 # 800085b0 <syscalls+0x1a0>
    80003054:	00003097          	auipc	ra,0x3
    80003058:	b98080e7          	jalr	-1128(ra) # 80005bec <panic>
      panic("dirlookup read");
    8000305c:	00005517          	auipc	a0,0x5
    80003060:	56c50513          	addi	a0,a0,1388 # 800085c8 <syscalls+0x1b8>
    80003064:	00003097          	auipc	ra,0x3
    80003068:	b88080e7          	jalr	-1144(ra) # 80005bec <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000306c:	24c1                	addiw	s1,s1,16
    8000306e:	04c92783          	lw	a5,76(s2)
    80003072:	04f4f763          	bgeu	s1,a5,800030c0 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003076:	4741                	li	a4,16
    80003078:	86a6                	mv	a3,s1
    8000307a:	fc040613          	addi	a2,s0,-64
    8000307e:	4581                	li	a1,0
    80003080:	854a                	mv	a0,s2
    80003082:	00000097          	auipc	ra,0x0
    80003086:	d70080e7          	jalr	-656(ra) # 80002df2 <readi>
    8000308a:	47c1                	li	a5,16
    8000308c:	fcf518e3          	bne	a0,a5,8000305c <dirlookup+0x3a>
    if(de.inum == 0)
    80003090:	fc045783          	lhu	a5,-64(s0)
    80003094:	dfe1                	beqz	a5,8000306c <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003096:	fc240593          	addi	a1,s0,-62
    8000309a:	854e                	mv	a0,s3
    8000309c:	00000097          	auipc	ra,0x0
    800030a0:	f6c080e7          	jalr	-148(ra) # 80003008 <namecmp>
    800030a4:	f561                	bnez	a0,8000306c <dirlookup+0x4a>
      if(poff)
    800030a6:	000a0463          	beqz	s4,800030ae <dirlookup+0x8c>
        *poff = off;
    800030aa:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800030ae:	fc045583          	lhu	a1,-64(s0)
    800030b2:	00092503          	lw	a0,0(s2)
    800030b6:	fffff097          	auipc	ra,0xfffff
    800030ba:	74e080e7          	jalr	1870(ra) # 80002804 <iget>
    800030be:	a011                	j	800030c2 <dirlookup+0xa0>
  return 0;
    800030c0:	4501                	li	a0,0
}
    800030c2:	70e2                	ld	ra,56(sp)
    800030c4:	7442                	ld	s0,48(sp)
    800030c6:	74a2                	ld	s1,40(sp)
    800030c8:	7902                	ld	s2,32(sp)
    800030ca:	69e2                	ld	s3,24(sp)
    800030cc:	6a42                	ld	s4,16(sp)
    800030ce:	6121                	addi	sp,sp,64
    800030d0:	8082                	ret

00000000800030d2 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800030d2:	711d                	addi	sp,sp,-96
    800030d4:	ec86                	sd	ra,88(sp)
    800030d6:	e8a2                	sd	s0,80(sp)
    800030d8:	e4a6                	sd	s1,72(sp)
    800030da:	e0ca                	sd	s2,64(sp)
    800030dc:	fc4e                	sd	s3,56(sp)
    800030de:	f852                	sd	s4,48(sp)
    800030e0:	f456                	sd	s5,40(sp)
    800030e2:	f05a                	sd	s6,32(sp)
    800030e4:	ec5e                	sd	s7,24(sp)
    800030e6:	e862                	sd	s8,16(sp)
    800030e8:	e466                	sd	s9,8(sp)
    800030ea:	e06a                	sd	s10,0(sp)
    800030ec:	1080                	addi	s0,sp,96
    800030ee:	84aa                	mv	s1,a0
    800030f0:	8b2e                	mv	s6,a1
    800030f2:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800030f4:	00054703          	lbu	a4,0(a0)
    800030f8:	02f00793          	li	a5,47
    800030fc:	02f70363          	beq	a4,a5,80003122 <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003100:	ffffe097          	auipc	ra,0xffffe
    80003104:	dac080e7          	jalr	-596(ra) # 80000eac <myproc>
    80003108:	15053503          	ld	a0,336(a0)
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	9f4080e7          	jalr	-1548(ra) # 80002b00 <idup>
    80003114:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003116:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    8000311a:	4cb5                	li	s9,13
  len = path - s;
    8000311c:	4b81                	li	s7,0

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000311e:	4c05                	li	s8,1
    80003120:	a87d                	j	800031de <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    80003122:	4585                	li	a1,1
    80003124:	4505                	li	a0,1
    80003126:	fffff097          	auipc	ra,0xfffff
    8000312a:	6de080e7          	jalr	1758(ra) # 80002804 <iget>
    8000312e:	8a2a                	mv	s4,a0
    80003130:	b7dd                	j	80003116 <namex+0x44>
      iunlockput(ip);
    80003132:	8552                	mv	a0,s4
    80003134:	00000097          	auipc	ra,0x0
    80003138:	c6c080e7          	jalr	-916(ra) # 80002da0 <iunlockput>
      return 0;
    8000313c:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    8000313e:	8552                	mv	a0,s4
    80003140:	60e6                	ld	ra,88(sp)
    80003142:	6446                	ld	s0,80(sp)
    80003144:	64a6                	ld	s1,72(sp)
    80003146:	6906                	ld	s2,64(sp)
    80003148:	79e2                	ld	s3,56(sp)
    8000314a:	7a42                	ld	s4,48(sp)
    8000314c:	7aa2                	ld	s5,40(sp)
    8000314e:	7b02                	ld	s6,32(sp)
    80003150:	6be2                	ld	s7,24(sp)
    80003152:	6c42                	ld	s8,16(sp)
    80003154:	6ca2                	ld	s9,8(sp)
    80003156:	6d02                	ld	s10,0(sp)
    80003158:	6125                	addi	sp,sp,96
    8000315a:	8082                	ret
      iunlock(ip);
    8000315c:	8552                	mv	a0,s4
    8000315e:	00000097          	auipc	ra,0x0
    80003162:	aa2080e7          	jalr	-1374(ra) # 80002c00 <iunlock>
      return ip;
    80003166:	bfe1                	j	8000313e <namex+0x6c>
      iunlockput(ip);
    80003168:	8552                	mv	a0,s4
    8000316a:	00000097          	auipc	ra,0x0
    8000316e:	c36080e7          	jalr	-970(ra) # 80002da0 <iunlockput>
      return 0;
    80003172:	8a4e                	mv	s4,s3
    80003174:	b7e9                	j	8000313e <namex+0x6c>
  len = path - s;
    80003176:	40998633          	sub	a2,s3,s1
    8000317a:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    8000317e:	09acd863          	bge	s9,s10,8000320e <namex+0x13c>
    memmove(name, s, DIRSIZ);
    80003182:	4639                	li	a2,14
    80003184:	85a6                	mv	a1,s1
    80003186:	8556                	mv	a0,s5
    80003188:	ffffd097          	auipc	ra,0xffffd
    8000318c:	04e080e7          	jalr	78(ra) # 800001d6 <memmove>
    80003190:	84ce                	mv	s1,s3
  while(*path == '/')
    80003192:	0004c783          	lbu	a5,0(s1)
    80003196:	01279763          	bne	a5,s2,800031a4 <namex+0xd2>
    path++;
    8000319a:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000319c:	0004c783          	lbu	a5,0(s1)
    800031a0:	ff278de3          	beq	a5,s2,8000319a <namex+0xc8>
    ilock(ip);
    800031a4:	8552                	mv	a0,s4
    800031a6:	00000097          	auipc	ra,0x0
    800031aa:	998080e7          	jalr	-1640(ra) # 80002b3e <ilock>
    if(ip->type != T_DIR){
    800031ae:	044a1783          	lh	a5,68(s4)
    800031b2:	f98790e3          	bne	a5,s8,80003132 <namex+0x60>
    if(nameiparent && *path == '\0'){
    800031b6:	000b0563          	beqz	s6,800031c0 <namex+0xee>
    800031ba:	0004c783          	lbu	a5,0(s1)
    800031be:	dfd9                	beqz	a5,8000315c <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    800031c0:	865e                	mv	a2,s7
    800031c2:	85d6                	mv	a1,s5
    800031c4:	8552                	mv	a0,s4
    800031c6:	00000097          	auipc	ra,0x0
    800031ca:	e5c080e7          	jalr	-420(ra) # 80003022 <dirlookup>
    800031ce:	89aa                	mv	s3,a0
    800031d0:	dd41                	beqz	a0,80003168 <namex+0x96>
    iunlockput(ip);
    800031d2:	8552                	mv	a0,s4
    800031d4:	00000097          	auipc	ra,0x0
    800031d8:	bcc080e7          	jalr	-1076(ra) # 80002da0 <iunlockput>
    ip = next;
    800031dc:	8a4e                	mv	s4,s3
  while(*path == '/')
    800031de:	0004c783          	lbu	a5,0(s1)
    800031e2:	01279763          	bne	a5,s2,800031f0 <namex+0x11e>
    path++;
    800031e6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800031e8:	0004c783          	lbu	a5,0(s1)
    800031ec:	ff278de3          	beq	a5,s2,800031e6 <namex+0x114>
  if(*path == 0)
    800031f0:	cb9d                	beqz	a5,80003226 <namex+0x154>
  while(*path != '/' && *path != 0)
    800031f2:	0004c783          	lbu	a5,0(s1)
    800031f6:	89a6                	mv	s3,s1
  len = path - s;
    800031f8:	8d5e                	mv	s10,s7
    800031fa:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    800031fc:	01278963          	beq	a5,s2,8000320e <namex+0x13c>
    80003200:	dbbd                	beqz	a5,80003176 <namex+0xa4>
    path++;
    80003202:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80003204:	0009c783          	lbu	a5,0(s3)
    80003208:	ff279ce3          	bne	a5,s2,80003200 <namex+0x12e>
    8000320c:	b7ad                	j	80003176 <namex+0xa4>
    memmove(name, s, len);
    8000320e:	2601                	sext.w	a2,a2
    80003210:	85a6                	mv	a1,s1
    80003212:	8556                	mv	a0,s5
    80003214:	ffffd097          	auipc	ra,0xffffd
    80003218:	fc2080e7          	jalr	-62(ra) # 800001d6 <memmove>
    name[len] = 0;
    8000321c:	9d56                	add	s10,s10,s5
    8000321e:	000d0023          	sb	zero,0(s10) # 1000 <_entry-0x7ffff000>
    80003222:	84ce                	mv	s1,s3
    80003224:	b7bd                	j	80003192 <namex+0xc0>
  if(nameiparent){
    80003226:	f00b0ce3          	beqz	s6,8000313e <namex+0x6c>
    iput(ip);
    8000322a:	8552                	mv	a0,s4
    8000322c:	00000097          	auipc	ra,0x0
    80003230:	acc080e7          	jalr	-1332(ra) # 80002cf8 <iput>
    return 0;
    80003234:	4a01                	li	s4,0
    80003236:	b721                	j	8000313e <namex+0x6c>

0000000080003238 <dirlink>:
{
    80003238:	7139                	addi	sp,sp,-64
    8000323a:	fc06                	sd	ra,56(sp)
    8000323c:	f822                	sd	s0,48(sp)
    8000323e:	f426                	sd	s1,40(sp)
    80003240:	f04a                	sd	s2,32(sp)
    80003242:	ec4e                	sd	s3,24(sp)
    80003244:	e852                	sd	s4,16(sp)
    80003246:	0080                	addi	s0,sp,64
    80003248:	892a                	mv	s2,a0
    8000324a:	8a2e                	mv	s4,a1
    8000324c:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    8000324e:	4601                	li	a2,0
    80003250:	00000097          	auipc	ra,0x0
    80003254:	dd2080e7          	jalr	-558(ra) # 80003022 <dirlookup>
    80003258:	e93d                	bnez	a0,800032ce <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000325a:	04c92483          	lw	s1,76(s2)
    8000325e:	c49d                	beqz	s1,8000328c <dirlink+0x54>
    80003260:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003262:	4741                	li	a4,16
    80003264:	86a6                	mv	a3,s1
    80003266:	fc040613          	addi	a2,s0,-64
    8000326a:	4581                	li	a1,0
    8000326c:	854a                	mv	a0,s2
    8000326e:	00000097          	auipc	ra,0x0
    80003272:	b84080e7          	jalr	-1148(ra) # 80002df2 <readi>
    80003276:	47c1                	li	a5,16
    80003278:	06f51163          	bne	a0,a5,800032da <dirlink+0xa2>
    if(de.inum == 0)
    8000327c:	fc045783          	lhu	a5,-64(s0)
    80003280:	c791                	beqz	a5,8000328c <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003282:	24c1                	addiw	s1,s1,16
    80003284:	04c92783          	lw	a5,76(s2)
    80003288:	fcf4ede3          	bltu	s1,a5,80003262 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000328c:	4639                	li	a2,14
    8000328e:	85d2                	mv	a1,s4
    80003290:	fc240513          	addi	a0,s0,-62
    80003294:	ffffd097          	auipc	ra,0xffffd
    80003298:	ff2080e7          	jalr	-14(ra) # 80000286 <strncpy>
  de.inum = inum;
    8000329c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032a0:	4741                	li	a4,16
    800032a2:	86a6                	mv	a3,s1
    800032a4:	fc040613          	addi	a2,s0,-64
    800032a8:	4581                	li	a1,0
    800032aa:	854a                	mv	a0,s2
    800032ac:	00000097          	auipc	ra,0x0
    800032b0:	c3e080e7          	jalr	-962(ra) # 80002eea <writei>
    800032b4:	1541                	addi	a0,a0,-16
    800032b6:	00a03533          	snez	a0,a0
    800032ba:	40a00533          	neg	a0,a0
}
    800032be:	70e2                	ld	ra,56(sp)
    800032c0:	7442                	ld	s0,48(sp)
    800032c2:	74a2                	ld	s1,40(sp)
    800032c4:	7902                	ld	s2,32(sp)
    800032c6:	69e2                	ld	s3,24(sp)
    800032c8:	6a42                	ld	s4,16(sp)
    800032ca:	6121                	addi	sp,sp,64
    800032cc:	8082                	ret
    iput(ip);
    800032ce:	00000097          	auipc	ra,0x0
    800032d2:	a2a080e7          	jalr	-1494(ra) # 80002cf8 <iput>
    return -1;
    800032d6:	557d                	li	a0,-1
    800032d8:	b7dd                	j	800032be <dirlink+0x86>
      panic("dirlink read");
    800032da:	00005517          	auipc	a0,0x5
    800032de:	2fe50513          	addi	a0,a0,766 # 800085d8 <syscalls+0x1c8>
    800032e2:	00003097          	auipc	ra,0x3
    800032e6:	90a080e7          	jalr	-1782(ra) # 80005bec <panic>

00000000800032ea <namei>:

struct inode*
namei(char *path)
{
    800032ea:	1101                	addi	sp,sp,-32
    800032ec:	ec06                	sd	ra,24(sp)
    800032ee:	e822                	sd	s0,16(sp)
    800032f0:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800032f2:	fe040613          	addi	a2,s0,-32
    800032f6:	4581                	li	a1,0
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	dda080e7          	jalr	-550(ra) # 800030d2 <namex>
}
    80003300:	60e2                	ld	ra,24(sp)
    80003302:	6442                	ld	s0,16(sp)
    80003304:	6105                	addi	sp,sp,32
    80003306:	8082                	ret

0000000080003308 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003308:	1141                	addi	sp,sp,-16
    8000330a:	e406                	sd	ra,8(sp)
    8000330c:	e022                	sd	s0,0(sp)
    8000330e:	0800                	addi	s0,sp,16
    80003310:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003312:	4585                	li	a1,1
    80003314:	00000097          	auipc	ra,0x0
    80003318:	dbe080e7          	jalr	-578(ra) # 800030d2 <namex>
}
    8000331c:	60a2                	ld	ra,8(sp)
    8000331e:	6402                	ld	s0,0(sp)
    80003320:	0141                	addi	sp,sp,16
    80003322:	8082                	ret

0000000080003324 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003324:	1101                	addi	sp,sp,-32
    80003326:	ec06                	sd	ra,24(sp)
    80003328:	e822                	sd	s0,16(sp)
    8000332a:	e426                	sd	s1,8(sp)
    8000332c:	e04a                	sd	s2,0(sp)
    8000332e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003330:	00015917          	auipc	s2,0x15
    80003334:	5e090913          	addi	s2,s2,1504 # 80018910 <log>
    80003338:	01892583          	lw	a1,24(s2)
    8000333c:	02892503          	lw	a0,40(s2)
    80003340:	fffff097          	auipc	ra,0xfffff
    80003344:	fe6080e7          	jalr	-26(ra) # 80002326 <bread>
    80003348:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    8000334a:	02c92683          	lw	a3,44(s2)
    8000334e:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003350:	02d05863          	blez	a3,80003380 <write_head+0x5c>
    80003354:	00015797          	auipc	a5,0x15
    80003358:	5ec78793          	addi	a5,a5,1516 # 80018940 <log+0x30>
    8000335c:	05c50713          	addi	a4,a0,92
    80003360:	36fd                	addiw	a3,a3,-1
    80003362:	02069613          	slli	a2,a3,0x20
    80003366:	01e65693          	srli	a3,a2,0x1e
    8000336a:	00015617          	auipc	a2,0x15
    8000336e:	5da60613          	addi	a2,a2,1498 # 80018944 <log+0x34>
    80003372:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003374:	4390                	lw	a2,0(a5)
    80003376:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003378:	0791                	addi	a5,a5,4
    8000337a:	0711                	addi	a4,a4,4 # 43004 <_entry-0x7ffbcffc>
    8000337c:	fed79ce3          	bne	a5,a3,80003374 <write_head+0x50>
  }
  bwrite(buf);
    80003380:	8526                	mv	a0,s1
    80003382:	fffff097          	auipc	ra,0xfffff
    80003386:	096080e7          	jalr	150(ra) # 80002418 <bwrite>
  brelse(buf);
    8000338a:	8526                	mv	a0,s1
    8000338c:	fffff097          	auipc	ra,0xfffff
    80003390:	0ca080e7          	jalr	202(ra) # 80002456 <brelse>
}
    80003394:	60e2                	ld	ra,24(sp)
    80003396:	6442                	ld	s0,16(sp)
    80003398:	64a2                	ld	s1,8(sp)
    8000339a:	6902                	ld	s2,0(sp)
    8000339c:	6105                	addi	sp,sp,32
    8000339e:	8082                	ret

00000000800033a0 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800033a0:	00015797          	auipc	a5,0x15
    800033a4:	59c7a783          	lw	a5,1436(a5) # 8001893c <log+0x2c>
    800033a8:	0af05d63          	blez	a5,80003462 <install_trans+0xc2>
{
    800033ac:	7139                	addi	sp,sp,-64
    800033ae:	fc06                	sd	ra,56(sp)
    800033b0:	f822                	sd	s0,48(sp)
    800033b2:	f426                	sd	s1,40(sp)
    800033b4:	f04a                	sd	s2,32(sp)
    800033b6:	ec4e                	sd	s3,24(sp)
    800033b8:	e852                	sd	s4,16(sp)
    800033ba:	e456                	sd	s5,8(sp)
    800033bc:	e05a                	sd	s6,0(sp)
    800033be:	0080                	addi	s0,sp,64
    800033c0:	8b2a                	mv	s6,a0
    800033c2:	00015a97          	auipc	s5,0x15
    800033c6:	57ea8a93          	addi	s5,s5,1406 # 80018940 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800033ca:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800033cc:	00015997          	auipc	s3,0x15
    800033d0:	54498993          	addi	s3,s3,1348 # 80018910 <log>
    800033d4:	a00d                	j	800033f6 <install_trans+0x56>
    brelse(lbuf);
    800033d6:	854a                	mv	a0,s2
    800033d8:	fffff097          	auipc	ra,0xfffff
    800033dc:	07e080e7          	jalr	126(ra) # 80002456 <brelse>
    brelse(dbuf);
    800033e0:	8526                	mv	a0,s1
    800033e2:	fffff097          	auipc	ra,0xfffff
    800033e6:	074080e7          	jalr	116(ra) # 80002456 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800033ea:	2a05                	addiw	s4,s4,1
    800033ec:	0a91                	addi	s5,s5,4
    800033ee:	02c9a783          	lw	a5,44(s3)
    800033f2:	04fa5e63          	bge	s4,a5,8000344e <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800033f6:	0189a583          	lw	a1,24(s3)
    800033fa:	014585bb          	addw	a1,a1,s4
    800033fe:	2585                	addiw	a1,a1,1
    80003400:	0289a503          	lw	a0,40(s3)
    80003404:	fffff097          	auipc	ra,0xfffff
    80003408:	f22080e7          	jalr	-222(ra) # 80002326 <bread>
    8000340c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000340e:	000aa583          	lw	a1,0(s5)
    80003412:	0289a503          	lw	a0,40(s3)
    80003416:	fffff097          	auipc	ra,0xfffff
    8000341a:	f10080e7          	jalr	-240(ra) # 80002326 <bread>
    8000341e:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003420:	40000613          	li	a2,1024
    80003424:	05890593          	addi	a1,s2,88
    80003428:	05850513          	addi	a0,a0,88
    8000342c:	ffffd097          	auipc	ra,0xffffd
    80003430:	daa080e7          	jalr	-598(ra) # 800001d6 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003434:	8526                	mv	a0,s1
    80003436:	fffff097          	auipc	ra,0xfffff
    8000343a:	fe2080e7          	jalr	-30(ra) # 80002418 <bwrite>
    if(recovering == 0)
    8000343e:	f80b1ce3          	bnez	s6,800033d6 <install_trans+0x36>
      bunpin(dbuf);
    80003442:	8526                	mv	a0,s1
    80003444:	fffff097          	auipc	ra,0xfffff
    80003448:	0ec080e7          	jalr	236(ra) # 80002530 <bunpin>
    8000344c:	b769                	j	800033d6 <install_trans+0x36>
}
    8000344e:	70e2                	ld	ra,56(sp)
    80003450:	7442                	ld	s0,48(sp)
    80003452:	74a2                	ld	s1,40(sp)
    80003454:	7902                	ld	s2,32(sp)
    80003456:	69e2                	ld	s3,24(sp)
    80003458:	6a42                	ld	s4,16(sp)
    8000345a:	6aa2                	ld	s5,8(sp)
    8000345c:	6b02                	ld	s6,0(sp)
    8000345e:	6121                	addi	sp,sp,64
    80003460:	8082                	ret
    80003462:	8082                	ret

0000000080003464 <initlog>:
{
    80003464:	7179                	addi	sp,sp,-48
    80003466:	f406                	sd	ra,40(sp)
    80003468:	f022                	sd	s0,32(sp)
    8000346a:	ec26                	sd	s1,24(sp)
    8000346c:	e84a                	sd	s2,16(sp)
    8000346e:	e44e                	sd	s3,8(sp)
    80003470:	1800                	addi	s0,sp,48
    80003472:	892a                	mv	s2,a0
    80003474:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003476:	00015497          	auipc	s1,0x15
    8000347a:	49a48493          	addi	s1,s1,1178 # 80018910 <log>
    8000347e:	00005597          	auipc	a1,0x5
    80003482:	16a58593          	addi	a1,a1,362 # 800085e8 <syscalls+0x1d8>
    80003486:	8526                	mv	a0,s1
    80003488:	00003097          	auipc	ra,0x3
    8000348c:	c0c080e7          	jalr	-1012(ra) # 80006094 <initlock>
  log.start = sb->logstart;
    80003490:	0149a583          	lw	a1,20(s3)
    80003494:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003496:	0109a783          	lw	a5,16(s3)
    8000349a:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000349c:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800034a0:	854a                	mv	a0,s2
    800034a2:	fffff097          	auipc	ra,0xfffff
    800034a6:	e84080e7          	jalr	-380(ra) # 80002326 <bread>
  log.lh.n = lh->n;
    800034aa:	4d34                	lw	a3,88(a0)
    800034ac:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800034ae:	02d05663          	blez	a3,800034da <initlog+0x76>
    800034b2:	05c50793          	addi	a5,a0,92
    800034b6:	00015717          	auipc	a4,0x15
    800034ba:	48a70713          	addi	a4,a4,1162 # 80018940 <log+0x30>
    800034be:	36fd                	addiw	a3,a3,-1
    800034c0:	02069613          	slli	a2,a3,0x20
    800034c4:	01e65693          	srli	a3,a2,0x1e
    800034c8:	06050613          	addi	a2,a0,96
    800034cc:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    800034ce:	4390                	lw	a2,0(a5)
    800034d0:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800034d2:	0791                	addi	a5,a5,4
    800034d4:	0711                	addi	a4,a4,4
    800034d6:	fed79ce3          	bne	a5,a3,800034ce <initlog+0x6a>
  brelse(buf);
    800034da:	fffff097          	auipc	ra,0xfffff
    800034de:	f7c080e7          	jalr	-132(ra) # 80002456 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800034e2:	4505                	li	a0,1
    800034e4:	00000097          	auipc	ra,0x0
    800034e8:	ebc080e7          	jalr	-324(ra) # 800033a0 <install_trans>
  log.lh.n = 0;
    800034ec:	00015797          	auipc	a5,0x15
    800034f0:	4407a823          	sw	zero,1104(a5) # 8001893c <log+0x2c>
  write_head(); // clear the log
    800034f4:	00000097          	auipc	ra,0x0
    800034f8:	e30080e7          	jalr	-464(ra) # 80003324 <write_head>
}
    800034fc:	70a2                	ld	ra,40(sp)
    800034fe:	7402                	ld	s0,32(sp)
    80003500:	64e2                	ld	s1,24(sp)
    80003502:	6942                	ld	s2,16(sp)
    80003504:	69a2                	ld	s3,8(sp)
    80003506:	6145                	addi	sp,sp,48
    80003508:	8082                	ret

000000008000350a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000350a:	1101                	addi	sp,sp,-32
    8000350c:	ec06                	sd	ra,24(sp)
    8000350e:	e822                	sd	s0,16(sp)
    80003510:	e426                	sd	s1,8(sp)
    80003512:	e04a                	sd	s2,0(sp)
    80003514:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003516:	00015517          	auipc	a0,0x15
    8000351a:	3fa50513          	addi	a0,a0,1018 # 80018910 <log>
    8000351e:	00003097          	auipc	ra,0x3
    80003522:	c06080e7          	jalr	-1018(ra) # 80006124 <acquire>
  while(1){
    if(log.committing){
    80003526:	00015497          	auipc	s1,0x15
    8000352a:	3ea48493          	addi	s1,s1,1002 # 80018910 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000352e:	4979                	li	s2,30
    80003530:	a039                	j	8000353e <begin_op+0x34>
      sleep(&log, &log.lock);
    80003532:	85a6                	mv	a1,s1
    80003534:	8526                	mv	a0,s1
    80003536:	ffffe097          	auipc	ra,0xffffe
    8000353a:	022080e7          	jalr	34(ra) # 80001558 <sleep>
    if(log.committing){
    8000353e:	50dc                	lw	a5,36(s1)
    80003540:	fbed                	bnez	a5,80003532 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003542:	5098                	lw	a4,32(s1)
    80003544:	2705                	addiw	a4,a4,1
    80003546:	0007069b          	sext.w	a3,a4
    8000354a:	0027179b          	slliw	a5,a4,0x2
    8000354e:	9fb9                	addw	a5,a5,a4
    80003550:	0017979b          	slliw	a5,a5,0x1
    80003554:	54d8                	lw	a4,44(s1)
    80003556:	9fb9                	addw	a5,a5,a4
    80003558:	00f95963          	bge	s2,a5,8000356a <begin_op+0x60>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000355c:	85a6                	mv	a1,s1
    8000355e:	8526                	mv	a0,s1
    80003560:	ffffe097          	auipc	ra,0xffffe
    80003564:	ff8080e7          	jalr	-8(ra) # 80001558 <sleep>
    80003568:	bfd9                	j	8000353e <begin_op+0x34>
    } else {
      log.outstanding += 1;
    8000356a:	00015517          	auipc	a0,0x15
    8000356e:	3a650513          	addi	a0,a0,934 # 80018910 <log>
    80003572:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003574:	00003097          	auipc	ra,0x3
    80003578:	c64080e7          	jalr	-924(ra) # 800061d8 <release>
      break;
    }
  }
}
    8000357c:	60e2                	ld	ra,24(sp)
    8000357e:	6442                	ld	s0,16(sp)
    80003580:	64a2                	ld	s1,8(sp)
    80003582:	6902                	ld	s2,0(sp)
    80003584:	6105                	addi	sp,sp,32
    80003586:	8082                	ret

0000000080003588 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003588:	7139                	addi	sp,sp,-64
    8000358a:	fc06                	sd	ra,56(sp)
    8000358c:	f822                	sd	s0,48(sp)
    8000358e:	f426                	sd	s1,40(sp)
    80003590:	f04a                	sd	s2,32(sp)
    80003592:	ec4e                	sd	s3,24(sp)
    80003594:	e852                	sd	s4,16(sp)
    80003596:	e456                	sd	s5,8(sp)
    80003598:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    8000359a:	00015497          	auipc	s1,0x15
    8000359e:	37648493          	addi	s1,s1,886 # 80018910 <log>
    800035a2:	8526                	mv	a0,s1
    800035a4:	00003097          	auipc	ra,0x3
    800035a8:	b80080e7          	jalr	-1152(ra) # 80006124 <acquire>
  log.outstanding -= 1;
    800035ac:	509c                	lw	a5,32(s1)
    800035ae:	37fd                	addiw	a5,a5,-1
    800035b0:	0007891b          	sext.w	s2,a5
    800035b4:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800035b6:	50dc                	lw	a5,36(s1)
    800035b8:	e7b9                	bnez	a5,80003606 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    800035ba:	04091e63          	bnez	s2,80003616 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800035be:	00015497          	auipc	s1,0x15
    800035c2:	35248493          	addi	s1,s1,850 # 80018910 <log>
    800035c6:	4785                	li	a5,1
    800035c8:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800035ca:	8526                	mv	a0,s1
    800035cc:	00003097          	auipc	ra,0x3
    800035d0:	c0c080e7          	jalr	-1012(ra) # 800061d8 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800035d4:	54dc                	lw	a5,44(s1)
    800035d6:	06f04763          	bgtz	a5,80003644 <end_op+0xbc>
    acquire(&log.lock);
    800035da:	00015497          	auipc	s1,0x15
    800035de:	33648493          	addi	s1,s1,822 # 80018910 <log>
    800035e2:	8526                	mv	a0,s1
    800035e4:	00003097          	auipc	ra,0x3
    800035e8:	b40080e7          	jalr	-1216(ra) # 80006124 <acquire>
    log.committing = 0;
    800035ec:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800035f0:	8526                	mv	a0,s1
    800035f2:	ffffe097          	auipc	ra,0xffffe
    800035f6:	fca080e7          	jalr	-54(ra) # 800015bc <wakeup>
    release(&log.lock);
    800035fa:	8526                	mv	a0,s1
    800035fc:	00003097          	auipc	ra,0x3
    80003600:	bdc080e7          	jalr	-1060(ra) # 800061d8 <release>
}
    80003604:	a03d                	j	80003632 <end_op+0xaa>
    panic("log.committing");
    80003606:	00005517          	auipc	a0,0x5
    8000360a:	fea50513          	addi	a0,a0,-22 # 800085f0 <syscalls+0x1e0>
    8000360e:	00002097          	auipc	ra,0x2
    80003612:	5de080e7          	jalr	1502(ra) # 80005bec <panic>
    wakeup(&log);
    80003616:	00015497          	auipc	s1,0x15
    8000361a:	2fa48493          	addi	s1,s1,762 # 80018910 <log>
    8000361e:	8526                	mv	a0,s1
    80003620:	ffffe097          	auipc	ra,0xffffe
    80003624:	f9c080e7          	jalr	-100(ra) # 800015bc <wakeup>
  release(&log.lock);
    80003628:	8526                	mv	a0,s1
    8000362a:	00003097          	auipc	ra,0x3
    8000362e:	bae080e7          	jalr	-1106(ra) # 800061d8 <release>
}
    80003632:	70e2                	ld	ra,56(sp)
    80003634:	7442                	ld	s0,48(sp)
    80003636:	74a2                	ld	s1,40(sp)
    80003638:	7902                	ld	s2,32(sp)
    8000363a:	69e2                	ld	s3,24(sp)
    8000363c:	6a42                	ld	s4,16(sp)
    8000363e:	6aa2                	ld	s5,8(sp)
    80003640:	6121                	addi	sp,sp,64
    80003642:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80003644:	00015a97          	auipc	s5,0x15
    80003648:	2fca8a93          	addi	s5,s5,764 # 80018940 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    8000364c:	00015a17          	auipc	s4,0x15
    80003650:	2c4a0a13          	addi	s4,s4,708 # 80018910 <log>
    80003654:	018a2583          	lw	a1,24(s4)
    80003658:	012585bb          	addw	a1,a1,s2
    8000365c:	2585                	addiw	a1,a1,1
    8000365e:	028a2503          	lw	a0,40(s4)
    80003662:	fffff097          	auipc	ra,0xfffff
    80003666:	cc4080e7          	jalr	-828(ra) # 80002326 <bread>
    8000366a:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000366c:	000aa583          	lw	a1,0(s5)
    80003670:	028a2503          	lw	a0,40(s4)
    80003674:	fffff097          	auipc	ra,0xfffff
    80003678:	cb2080e7          	jalr	-846(ra) # 80002326 <bread>
    8000367c:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000367e:	40000613          	li	a2,1024
    80003682:	05850593          	addi	a1,a0,88
    80003686:	05848513          	addi	a0,s1,88
    8000368a:	ffffd097          	auipc	ra,0xffffd
    8000368e:	b4c080e7          	jalr	-1204(ra) # 800001d6 <memmove>
    bwrite(to);  // write the log
    80003692:	8526                	mv	a0,s1
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	d84080e7          	jalr	-636(ra) # 80002418 <bwrite>
    brelse(from);
    8000369c:	854e                	mv	a0,s3
    8000369e:	fffff097          	auipc	ra,0xfffff
    800036a2:	db8080e7          	jalr	-584(ra) # 80002456 <brelse>
    brelse(to);
    800036a6:	8526                	mv	a0,s1
    800036a8:	fffff097          	auipc	ra,0xfffff
    800036ac:	dae080e7          	jalr	-594(ra) # 80002456 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800036b0:	2905                	addiw	s2,s2,1
    800036b2:	0a91                	addi	s5,s5,4
    800036b4:	02ca2783          	lw	a5,44(s4)
    800036b8:	f8f94ee3          	blt	s2,a5,80003654 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800036bc:	00000097          	auipc	ra,0x0
    800036c0:	c68080e7          	jalr	-920(ra) # 80003324 <write_head>
    install_trans(0); // Now install writes to home locations
    800036c4:	4501                	li	a0,0
    800036c6:	00000097          	auipc	ra,0x0
    800036ca:	cda080e7          	jalr	-806(ra) # 800033a0 <install_trans>
    log.lh.n = 0;
    800036ce:	00015797          	auipc	a5,0x15
    800036d2:	2607a723          	sw	zero,622(a5) # 8001893c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800036d6:	00000097          	auipc	ra,0x0
    800036da:	c4e080e7          	jalr	-946(ra) # 80003324 <write_head>
    800036de:	bdf5                	j	800035da <end_op+0x52>

00000000800036e0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800036e0:	1101                	addi	sp,sp,-32
    800036e2:	ec06                	sd	ra,24(sp)
    800036e4:	e822                	sd	s0,16(sp)
    800036e6:	e426                	sd	s1,8(sp)
    800036e8:	e04a                	sd	s2,0(sp)
    800036ea:	1000                	addi	s0,sp,32
    800036ec:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800036ee:	00015917          	auipc	s2,0x15
    800036f2:	22290913          	addi	s2,s2,546 # 80018910 <log>
    800036f6:	854a                	mv	a0,s2
    800036f8:	00003097          	auipc	ra,0x3
    800036fc:	a2c080e7          	jalr	-1492(ra) # 80006124 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003700:	02c92603          	lw	a2,44(s2)
    80003704:	47f5                	li	a5,29
    80003706:	06c7c563          	blt	a5,a2,80003770 <log_write+0x90>
    8000370a:	00015797          	auipc	a5,0x15
    8000370e:	2227a783          	lw	a5,546(a5) # 8001892c <log+0x1c>
    80003712:	37fd                	addiw	a5,a5,-1
    80003714:	04f65e63          	bge	a2,a5,80003770 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003718:	00015797          	auipc	a5,0x15
    8000371c:	2187a783          	lw	a5,536(a5) # 80018930 <log+0x20>
    80003720:	06f05063          	blez	a5,80003780 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003724:	4781                	li	a5,0
    80003726:	06c05563          	blez	a2,80003790 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000372a:	44cc                	lw	a1,12(s1)
    8000372c:	00015717          	auipc	a4,0x15
    80003730:	21470713          	addi	a4,a4,532 # 80018940 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003734:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003736:	4314                	lw	a3,0(a4)
    80003738:	04b68c63          	beq	a3,a1,80003790 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000373c:	2785                	addiw	a5,a5,1
    8000373e:	0711                	addi	a4,a4,4
    80003740:	fef61be3          	bne	a2,a5,80003736 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003744:	0621                	addi	a2,a2,8
    80003746:	060a                	slli	a2,a2,0x2
    80003748:	00015797          	auipc	a5,0x15
    8000374c:	1c878793          	addi	a5,a5,456 # 80018910 <log>
    80003750:	97b2                	add	a5,a5,a2
    80003752:	44d8                	lw	a4,12(s1)
    80003754:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003756:	8526                	mv	a0,s1
    80003758:	fffff097          	auipc	ra,0xfffff
    8000375c:	d9c080e7          	jalr	-612(ra) # 800024f4 <bpin>
    log.lh.n++;
    80003760:	00015717          	auipc	a4,0x15
    80003764:	1b070713          	addi	a4,a4,432 # 80018910 <log>
    80003768:	575c                	lw	a5,44(a4)
    8000376a:	2785                	addiw	a5,a5,1
    8000376c:	d75c                	sw	a5,44(a4)
    8000376e:	a82d                	j	800037a8 <log_write+0xc8>
    panic("too big a transaction");
    80003770:	00005517          	auipc	a0,0x5
    80003774:	e9050513          	addi	a0,a0,-368 # 80008600 <syscalls+0x1f0>
    80003778:	00002097          	auipc	ra,0x2
    8000377c:	474080e7          	jalr	1140(ra) # 80005bec <panic>
    panic("log_write outside of trans");
    80003780:	00005517          	auipc	a0,0x5
    80003784:	e9850513          	addi	a0,a0,-360 # 80008618 <syscalls+0x208>
    80003788:	00002097          	auipc	ra,0x2
    8000378c:	464080e7          	jalr	1124(ra) # 80005bec <panic>
  log.lh.block[i] = b->blockno;
    80003790:	00878693          	addi	a3,a5,8
    80003794:	068a                	slli	a3,a3,0x2
    80003796:	00015717          	auipc	a4,0x15
    8000379a:	17a70713          	addi	a4,a4,378 # 80018910 <log>
    8000379e:	9736                	add	a4,a4,a3
    800037a0:	44d4                	lw	a3,12(s1)
    800037a2:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800037a4:	faf609e3          	beq	a2,a5,80003756 <log_write+0x76>
  }
  release(&log.lock);
    800037a8:	00015517          	auipc	a0,0x15
    800037ac:	16850513          	addi	a0,a0,360 # 80018910 <log>
    800037b0:	00003097          	auipc	ra,0x3
    800037b4:	a28080e7          	jalr	-1496(ra) # 800061d8 <release>
}
    800037b8:	60e2                	ld	ra,24(sp)
    800037ba:	6442                	ld	s0,16(sp)
    800037bc:	64a2                	ld	s1,8(sp)
    800037be:	6902                	ld	s2,0(sp)
    800037c0:	6105                	addi	sp,sp,32
    800037c2:	8082                	ret

00000000800037c4 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800037c4:	1101                	addi	sp,sp,-32
    800037c6:	ec06                	sd	ra,24(sp)
    800037c8:	e822                	sd	s0,16(sp)
    800037ca:	e426                	sd	s1,8(sp)
    800037cc:	e04a                	sd	s2,0(sp)
    800037ce:	1000                	addi	s0,sp,32
    800037d0:	84aa                	mv	s1,a0
    800037d2:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800037d4:	00005597          	auipc	a1,0x5
    800037d8:	e6458593          	addi	a1,a1,-412 # 80008638 <syscalls+0x228>
    800037dc:	0521                	addi	a0,a0,8
    800037de:	00003097          	auipc	ra,0x3
    800037e2:	8b6080e7          	jalr	-1866(ra) # 80006094 <initlock>
  lk->name = name;
    800037e6:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800037ea:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800037ee:	0204a423          	sw	zero,40(s1)
}
    800037f2:	60e2                	ld	ra,24(sp)
    800037f4:	6442                	ld	s0,16(sp)
    800037f6:	64a2                	ld	s1,8(sp)
    800037f8:	6902                	ld	s2,0(sp)
    800037fa:	6105                	addi	sp,sp,32
    800037fc:	8082                	ret

00000000800037fe <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800037fe:	1101                	addi	sp,sp,-32
    80003800:	ec06                	sd	ra,24(sp)
    80003802:	e822                	sd	s0,16(sp)
    80003804:	e426                	sd	s1,8(sp)
    80003806:	e04a                	sd	s2,0(sp)
    80003808:	1000                	addi	s0,sp,32
    8000380a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000380c:	00850913          	addi	s2,a0,8
    80003810:	854a                	mv	a0,s2
    80003812:	00003097          	auipc	ra,0x3
    80003816:	912080e7          	jalr	-1774(ra) # 80006124 <acquire>
  while (lk->locked) {
    8000381a:	409c                	lw	a5,0(s1)
    8000381c:	cb89                	beqz	a5,8000382e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000381e:	85ca                	mv	a1,s2
    80003820:	8526                	mv	a0,s1
    80003822:	ffffe097          	auipc	ra,0xffffe
    80003826:	d36080e7          	jalr	-714(ra) # 80001558 <sleep>
  while (lk->locked) {
    8000382a:	409c                	lw	a5,0(s1)
    8000382c:	fbed                	bnez	a5,8000381e <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000382e:	4785                	li	a5,1
    80003830:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003832:	ffffd097          	auipc	ra,0xffffd
    80003836:	67a080e7          	jalr	1658(ra) # 80000eac <myproc>
    8000383a:	591c                	lw	a5,48(a0)
    8000383c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000383e:	854a                	mv	a0,s2
    80003840:	00003097          	auipc	ra,0x3
    80003844:	998080e7          	jalr	-1640(ra) # 800061d8 <release>
}
    80003848:	60e2                	ld	ra,24(sp)
    8000384a:	6442                	ld	s0,16(sp)
    8000384c:	64a2                	ld	s1,8(sp)
    8000384e:	6902                	ld	s2,0(sp)
    80003850:	6105                	addi	sp,sp,32
    80003852:	8082                	ret

0000000080003854 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003854:	1101                	addi	sp,sp,-32
    80003856:	ec06                	sd	ra,24(sp)
    80003858:	e822                	sd	s0,16(sp)
    8000385a:	e426                	sd	s1,8(sp)
    8000385c:	e04a                	sd	s2,0(sp)
    8000385e:	1000                	addi	s0,sp,32
    80003860:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003862:	00850913          	addi	s2,a0,8
    80003866:	854a                	mv	a0,s2
    80003868:	00003097          	auipc	ra,0x3
    8000386c:	8bc080e7          	jalr	-1860(ra) # 80006124 <acquire>
  lk->locked = 0;
    80003870:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003874:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003878:	8526                	mv	a0,s1
    8000387a:	ffffe097          	auipc	ra,0xffffe
    8000387e:	d42080e7          	jalr	-702(ra) # 800015bc <wakeup>
  release(&lk->lk);
    80003882:	854a                	mv	a0,s2
    80003884:	00003097          	auipc	ra,0x3
    80003888:	954080e7          	jalr	-1708(ra) # 800061d8 <release>
}
    8000388c:	60e2                	ld	ra,24(sp)
    8000388e:	6442                	ld	s0,16(sp)
    80003890:	64a2                	ld	s1,8(sp)
    80003892:	6902                	ld	s2,0(sp)
    80003894:	6105                	addi	sp,sp,32
    80003896:	8082                	ret

0000000080003898 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003898:	7179                	addi	sp,sp,-48
    8000389a:	f406                	sd	ra,40(sp)
    8000389c:	f022                	sd	s0,32(sp)
    8000389e:	ec26                	sd	s1,24(sp)
    800038a0:	e84a                	sd	s2,16(sp)
    800038a2:	e44e                	sd	s3,8(sp)
    800038a4:	1800                	addi	s0,sp,48
    800038a6:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800038a8:	00850913          	addi	s2,a0,8
    800038ac:	854a                	mv	a0,s2
    800038ae:	00003097          	auipc	ra,0x3
    800038b2:	876080e7          	jalr	-1930(ra) # 80006124 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800038b6:	409c                	lw	a5,0(s1)
    800038b8:	ef99                	bnez	a5,800038d6 <holdingsleep+0x3e>
    800038ba:	4481                	li	s1,0
  release(&lk->lk);
    800038bc:	854a                	mv	a0,s2
    800038be:	00003097          	auipc	ra,0x3
    800038c2:	91a080e7          	jalr	-1766(ra) # 800061d8 <release>
  return r;
}
    800038c6:	8526                	mv	a0,s1
    800038c8:	70a2                	ld	ra,40(sp)
    800038ca:	7402                	ld	s0,32(sp)
    800038cc:	64e2                	ld	s1,24(sp)
    800038ce:	6942                	ld	s2,16(sp)
    800038d0:	69a2                	ld	s3,8(sp)
    800038d2:	6145                	addi	sp,sp,48
    800038d4:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    800038d6:	0284a983          	lw	s3,40(s1)
    800038da:	ffffd097          	auipc	ra,0xffffd
    800038de:	5d2080e7          	jalr	1490(ra) # 80000eac <myproc>
    800038e2:	5904                	lw	s1,48(a0)
    800038e4:	413484b3          	sub	s1,s1,s3
    800038e8:	0014b493          	seqz	s1,s1
    800038ec:	bfc1                	j	800038bc <holdingsleep+0x24>

00000000800038ee <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800038ee:	1141                	addi	sp,sp,-16
    800038f0:	e406                	sd	ra,8(sp)
    800038f2:	e022                	sd	s0,0(sp)
    800038f4:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800038f6:	00005597          	auipc	a1,0x5
    800038fa:	d5258593          	addi	a1,a1,-686 # 80008648 <syscalls+0x238>
    800038fe:	00015517          	auipc	a0,0x15
    80003902:	15a50513          	addi	a0,a0,346 # 80018a58 <ftable>
    80003906:	00002097          	auipc	ra,0x2
    8000390a:	78e080e7          	jalr	1934(ra) # 80006094 <initlock>
}
    8000390e:	60a2                	ld	ra,8(sp)
    80003910:	6402                	ld	s0,0(sp)
    80003912:	0141                	addi	sp,sp,16
    80003914:	8082                	ret

0000000080003916 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003916:	1101                	addi	sp,sp,-32
    80003918:	ec06                	sd	ra,24(sp)
    8000391a:	e822                	sd	s0,16(sp)
    8000391c:	e426                	sd	s1,8(sp)
    8000391e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003920:	00015517          	auipc	a0,0x15
    80003924:	13850513          	addi	a0,a0,312 # 80018a58 <ftable>
    80003928:	00002097          	auipc	ra,0x2
    8000392c:	7fc080e7          	jalr	2044(ra) # 80006124 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003930:	00015497          	auipc	s1,0x15
    80003934:	14048493          	addi	s1,s1,320 # 80018a70 <ftable+0x18>
    80003938:	00016717          	auipc	a4,0x16
    8000393c:	0d870713          	addi	a4,a4,216 # 80019a10 <disk>
    if(f->ref == 0){
    80003940:	40dc                	lw	a5,4(s1)
    80003942:	cf99                	beqz	a5,80003960 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003944:	02848493          	addi	s1,s1,40
    80003948:	fee49ce3          	bne	s1,a4,80003940 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000394c:	00015517          	auipc	a0,0x15
    80003950:	10c50513          	addi	a0,a0,268 # 80018a58 <ftable>
    80003954:	00003097          	auipc	ra,0x3
    80003958:	884080e7          	jalr	-1916(ra) # 800061d8 <release>
  return 0;
    8000395c:	4481                	li	s1,0
    8000395e:	a819                	j	80003974 <filealloc+0x5e>
      f->ref = 1;
    80003960:	4785                	li	a5,1
    80003962:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003964:	00015517          	auipc	a0,0x15
    80003968:	0f450513          	addi	a0,a0,244 # 80018a58 <ftable>
    8000396c:	00003097          	auipc	ra,0x3
    80003970:	86c080e7          	jalr	-1940(ra) # 800061d8 <release>
}
    80003974:	8526                	mv	a0,s1
    80003976:	60e2                	ld	ra,24(sp)
    80003978:	6442                	ld	s0,16(sp)
    8000397a:	64a2                	ld	s1,8(sp)
    8000397c:	6105                	addi	sp,sp,32
    8000397e:	8082                	ret

0000000080003980 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003980:	1101                	addi	sp,sp,-32
    80003982:	ec06                	sd	ra,24(sp)
    80003984:	e822                	sd	s0,16(sp)
    80003986:	e426                	sd	s1,8(sp)
    80003988:	1000                	addi	s0,sp,32
    8000398a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000398c:	00015517          	auipc	a0,0x15
    80003990:	0cc50513          	addi	a0,a0,204 # 80018a58 <ftable>
    80003994:	00002097          	auipc	ra,0x2
    80003998:	790080e7          	jalr	1936(ra) # 80006124 <acquire>
  if(f->ref < 1)
    8000399c:	40dc                	lw	a5,4(s1)
    8000399e:	02f05263          	blez	a5,800039c2 <filedup+0x42>
    panic("filedup");
  f->ref++;
    800039a2:	2785                	addiw	a5,a5,1
    800039a4:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800039a6:	00015517          	auipc	a0,0x15
    800039aa:	0b250513          	addi	a0,a0,178 # 80018a58 <ftable>
    800039ae:	00003097          	auipc	ra,0x3
    800039b2:	82a080e7          	jalr	-2006(ra) # 800061d8 <release>
  return f;
}
    800039b6:	8526                	mv	a0,s1
    800039b8:	60e2                	ld	ra,24(sp)
    800039ba:	6442                	ld	s0,16(sp)
    800039bc:	64a2                	ld	s1,8(sp)
    800039be:	6105                	addi	sp,sp,32
    800039c0:	8082                	ret
    panic("filedup");
    800039c2:	00005517          	auipc	a0,0x5
    800039c6:	c8e50513          	addi	a0,a0,-882 # 80008650 <syscalls+0x240>
    800039ca:	00002097          	auipc	ra,0x2
    800039ce:	222080e7          	jalr	546(ra) # 80005bec <panic>

00000000800039d2 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800039d2:	7139                	addi	sp,sp,-64
    800039d4:	fc06                	sd	ra,56(sp)
    800039d6:	f822                	sd	s0,48(sp)
    800039d8:	f426                	sd	s1,40(sp)
    800039da:	f04a                	sd	s2,32(sp)
    800039dc:	ec4e                	sd	s3,24(sp)
    800039de:	e852                	sd	s4,16(sp)
    800039e0:	e456                	sd	s5,8(sp)
    800039e2:	0080                	addi	s0,sp,64
    800039e4:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800039e6:	00015517          	auipc	a0,0x15
    800039ea:	07250513          	addi	a0,a0,114 # 80018a58 <ftable>
    800039ee:	00002097          	auipc	ra,0x2
    800039f2:	736080e7          	jalr	1846(ra) # 80006124 <acquire>
  if(f->ref < 1)
    800039f6:	40dc                	lw	a5,4(s1)
    800039f8:	06f05163          	blez	a5,80003a5a <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800039fc:	37fd                	addiw	a5,a5,-1
    800039fe:	0007871b          	sext.w	a4,a5
    80003a02:	c0dc                	sw	a5,4(s1)
    80003a04:	06e04363          	bgtz	a4,80003a6a <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003a08:	0004a903          	lw	s2,0(s1)
    80003a0c:	0094ca83          	lbu	s5,9(s1)
    80003a10:	0104ba03          	ld	s4,16(s1)
    80003a14:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003a18:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003a1c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003a20:	00015517          	auipc	a0,0x15
    80003a24:	03850513          	addi	a0,a0,56 # 80018a58 <ftable>
    80003a28:	00002097          	auipc	ra,0x2
    80003a2c:	7b0080e7          	jalr	1968(ra) # 800061d8 <release>

  if(ff.type == FD_PIPE){
    80003a30:	4785                	li	a5,1
    80003a32:	04f90d63          	beq	s2,a5,80003a8c <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003a36:	3979                	addiw	s2,s2,-2
    80003a38:	4785                	li	a5,1
    80003a3a:	0527e063          	bltu	a5,s2,80003a7a <fileclose+0xa8>
    begin_op();
    80003a3e:	00000097          	auipc	ra,0x0
    80003a42:	acc080e7          	jalr	-1332(ra) # 8000350a <begin_op>
    iput(ff.ip);
    80003a46:	854e                	mv	a0,s3
    80003a48:	fffff097          	auipc	ra,0xfffff
    80003a4c:	2b0080e7          	jalr	688(ra) # 80002cf8 <iput>
    end_op();
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	b38080e7          	jalr	-1224(ra) # 80003588 <end_op>
    80003a58:	a00d                	j	80003a7a <fileclose+0xa8>
    panic("fileclose");
    80003a5a:	00005517          	auipc	a0,0x5
    80003a5e:	bfe50513          	addi	a0,a0,-1026 # 80008658 <syscalls+0x248>
    80003a62:	00002097          	auipc	ra,0x2
    80003a66:	18a080e7          	jalr	394(ra) # 80005bec <panic>
    release(&ftable.lock);
    80003a6a:	00015517          	auipc	a0,0x15
    80003a6e:	fee50513          	addi	a0,a0,-18 # 80018a58 <ftable>
    80003a72:	00002097          	auipc	ra,0x2
    80003a76:	766080e7          	jalr	1894(ra) # 800061d8 <release>
  }
}
    80003a7a:	70e2                	ld	ra,56(sp)
    80003a7c:	7442                	ld	s0,48(sp)
    80003a7e:	74a2                	ld	s1,40(sp)
    80003a80:	7902                	ld	s2,32(sp)
    80003a82:	69e2                	ld	s3,24(sp)
    80003a84:	6a42                	ld	s4,16(sp)
    80003a86:	6aa2                	ld	s5,8(sp)
    80003a88:	6121                	addi	sp,sp,64
    80003a8a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003a8c:	85d6                	mv	a1,s5
    80003a8e:	8552                	mv	a0,s4
    80003a90:	00000097          	auipc	ra,0x0
    80003a94:	34c080e7          	jalr	844(ra) # 80003ddc <pipeclose>
    80003a98:	b7cd                	j	80003a7a <fileclose+0xa8>

0000000080003a9a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003a9a:	715d                	addi	sp,sp,-80
    80003a9c:	e486                	sd	ra,72(sp)
    80003a9e:	e0a2                	sd	s0,64(sp)
    80003aa0:	fc26                	sd	s1,56(sp)
    80003aa2:	f84a                	sd	s2,48(sp)
    80003aa4:	f44e                	sd	s3,40(sp)
    80003aa6:	0880                	addi	s0,sp,80
    80003aa8:	84aa                	mv	s1,a0
    80003aaa:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003aac:	ffffd097          	auipc	ra,0xffffd
    80003ab0:	400080e7          	jalr	1024(ra) # 80000eac <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003ab4:	409c                	lw	a5,0(s1)
    80003ab6:	37f9                	addiw	a5,a5,-2
    80003ab8:	4705                	li	a4,1
    80003aba:	04f76763          	bltu	a4,a5,80003b08 <filestat+0x6e>
    80003abe:	892a                	mv	s2,a0
    ilock(f->ip);
    80003ac0:	6c88                	ld	a0,24(s1)
    80003ac2:	fffff097          	auipc	ra,0xfffff
    80003ac6:	07c080e7          	jalr	124(ra) # 80002b3e <ilock>
    stati(f->ip, &st);
    80003aca:	fb840593          	addi	a1,s0,-72
    80003ace:	6c88                	ld	a0,24(s1)
    80003ad0:	fffff097          	auipc	ra,0xfffff
    80003ad4:	2f8080e7          	jalr	760(ra) # 80002dc8 <stati>
    iunlock(f->ip);
    80003ad8:	6c88                	ld	a0,24(s1)
    80003ada:	fffff097          	auipc	ra,0xfffff
    80003ade:	126080e7          	jalr	294(ra) # 80002c00 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003ae2:	46e1                	li	a3,24
    80003ae4:	fb840613          	addi	a2,s0,-72
    80003ae8:	85ce                	mv	a1,s3
    80003aea:	05093503          	ld	a0,80(s2)
    80003aee:	ffffd097          	auipc	ra,0xffffd
    80003af2:	04a080e7          	jalr	74(ra) # 80000b38 <copyout>
    80003af6:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003afa:	60a6                	ld	ra,72(sp)
    80003afc:	6406                	ld	s0,64(sp)
    80003afe:	74e2                	ld	s1,56(sp)
    80003b00:	7942                	ld	s2,48(sp)
    80003b02:	79a2                	ld	s3,40(sp)
    80003b04:	6161                	addi	sp,sp,80
    80003b06:	8082                	ret
  return -1;
    80003b08:	557d                	li	a0,-1
    80003b0a:	bfc5                	j	80003afa <filestat+0x60>

0000000080003b0c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003b0c:	7179                	addi	sp,sp,-48
    80003b0e:	f406                	sd	ra,40(sp)
    80003b10:	f022                	sd	s0,32(sp)
    80003b12:	ec26                	sd	s1,24(sp)
    80003b14:	e84a                	sd	s2,16(sp)
    80003b16:	e44e                	sd	s3,8(sp)
    80003b18:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003b1a:	00854783          	lbu	a5,8(a0)
    80003b1e:	c3d5                	beqz	a5,80003bc2 <fileread+0xb6>
    80003b20:	84aa                	mv	s1,a0
    80003b22:	89ae                	mv	s3,a1
    80003b24:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003b26:	411c                	lw	a5,0(a0)
    80003b28:	4705                	li	a4,1
    80003b2a:	04e78963          	beq	a5,a4,80003b7c <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003b2e:	470d                	li	a4,3
    80003b30:	04e78d63          	beq	a5,a4,80003b8a <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003b34:	4709                	li	a4,2
    80003b36:	06e79e63          	bne	a5,a4,80003bb2 <fileread+0xa6>
    ilock(f->ip);
    80003b3a:	6d08                	ld	a0,24(a0)
    80003b3c:	fffff097          	auipc	ra,0xfffff
    80003b40:	002080e7          	jalr	2(ra) # 80002b3e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003b44:	874a                	mv	a4,s2
    80003b46:	5094                	lw	a3,32(s1)
    80003b48:	864e                	mv	a2,s3
    80003b4a:	4585                	li	a1,1
    80003b4c:	6c88                	ld	a0,24(s1)
    80003b4e:	fffff097          	auipc	ra,0xfffff
    80003b52:	2a4080e7          	jalr	676(ra) # 80002df2 <readi>
    80003b56:	892a                	mv	s2,a0
    80003b58:	00a05563          	blez	a0,80003b62 <fileread+0x56>
      f->off += r;
    80003b5c:	509c                	lw	a5,32(s1)
    80003b5e:	9fa9                	addw	a5,a5,a0
    80003b60:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003b62:	6c88                	ld	a0,24(s1)
    80003b64:	fffff097          	auipc	ra,0xfffff
    80003b68:	09c080e7          	jalr	156(ra) # 80002c00 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003b6c:	854a                	mv	a0,s2
    80003b6e:	70a2                	ld	ra,40(sp)
    80003b70:	7402                	ld	s0,32(sp)
    80003b72:	64e2                	ld	s1,24(sp)
    80003b74:	6942                	ld	s2,16(sp)
    80003b76:	69a2                	ld	s3,8(sp)
    80003b78:	6145                	addi	sp,sp,48
    80003b7a:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003b7c:	6908                	ld	a0,16(a0)
    80003b7e:	00000097          	auipc	ra,0x0
    80003b82:	3c6080e7          	jalr	966(ra) # 80003f44 <piperead>
    80003b86:	892a                	mv	s2,a0
    80003b88:	b7d5                	j	80003b6c <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003b8a:	02451783          	lh	a5,36(a0)
    80003b8e:	03079693          	slli	a3,a5,0x30
    80003b92:	92c1                	srli	a3,a3,0x30
    80003b94:	4725                	li	a4,9
    80003b96:	02d76863          	bltu	a4,a3,80003bc6 <fileread+0xba>
    80003b9a:	0792                	slli	a5,a5,0x4
    80003b9c:	00015717          	auipc	a4,0x15
    80003ba0:	e1c70713          	addi	a4,a4,-484 # 800189b8 <devsw>
    80003ba4:	97ba                	add	a5,a5,a4
    80003ba6:	639c                	ld	a5,0(a5)
    80003ba8:	c38d                	beqz	a5,80003bca <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003baa:	4505                	li	a0,1
    80003bac:	9782                	jalr	a5
    80003bae:	892a                	mv	s2,a0
    80003bb0:	bf75                	j	80003b6c <fileread+0x60>
    panic("fileread");
    80003bb2:	00005517          	auipc	a0,0x5
    80003bb6:	ab650513          	addi	a0,a0,-1354 # 80008668 <syscalls+0x258>
    80003bba:	00002097          	auipc	ra,0x2
    80003bbe:	032080e7          	jalr	50(ra) # 80005bec <panic>
    return -1;
    80003bc2:	597d                	li	s2,-1
    80003bc4:	b765                	j	80003b6c <fileread+0x60>
      return -1;
    80003bc6:	597d                	li	s2,-1
    80003bc8:	b755                	j	80003b6c <fileread+0x60>
    80003bca:	597d                	li	s2,-1
    80003bcc:	b745                	j	80003b6c <fileread+0x60>

0000000080003bce <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003bce:	715d                	addi	sp,sp,-80
    80003bd0:	e486                	sd	ra,72(sp)
    80003bd2:	e0a2                	sd	s0,64(sp)
    80003bd4:	fc26                	sd	s1,56(sp)
    80003bd6:	f84a                	sd	s2,48(sp)
    80003bd8:	f44e                	sd	s3,40(sp)
    80003bda:	f052                	sd	s4,32(sp)
    80003bdc:	ec56                	sd	s5,24(sp)
    80003bde:	e85a                	sd	s6,16(sp)
    80003be0:	e45e                	sd	s7,8(sp)
    80003be2:	e062                	sd	s8,0(sp)
    80003be4:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003be6:	00954783          	lbu	a5,9(a0)
    80003bea:	10078663          	beqz	a5,80003cf6 <filewrite+0x128>
    80003bee:	892a                	mv	s2,a0
    80003bf0:	8b2e                	mv	s6,a1
    80003bf2:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003bf4:	411c                	lw	a5,0(a0)
    80003bf6:	4705                	li	a4,1
    80003bf8:	02e78263          	beq	a5,a4,80003c1c <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003bfc:	470d                	li	a4,3
    80003bfe:	02e78663          	beq	a5,a4,80003c2a <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c02:	4709                	li	a4,2
    80003c04:	0ee79163          	bne	a5,a4,80003ce6 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003c08:	0ac05d63          	blez	a2,80003cc2 <filewrite+0xf4>
    int i = 0;
    80003c0c:	4981                	li	s3,0
    80003c0e:	6b85                	lui	s7,0x1
    80003c10:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003c14:	6c05                	lui	s8,0x1
    80003c16:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003c1a:	a861                	j	80003cb2 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003c1c:	6908                	ld	a0,16(a0)
    80003c1e:	00000097          	auipc	ra,0x0
    80003c22:	22e080e7          	jalr	558(ra) # 80003e4c <pipewrite>
    80003c26:	8a2a                	mv	s4,a0
    80003c28:	a045                	j	80003cc8 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003c2a:	02451783          	lh	a5,36(a0)
    80003c2e:	03079693          	slli	a3,a5,0x30
    80003c32:	92c1                	srli	a3,a3,0x30
    80003c34:	4725                	li	a4,9
    80003c36:	0cd76263          	bltu	a4,a3,80003cfa <filewrite+0x12c>
    80003c3a:	0792                	slli	a5,a5,0x4
    80003c3c:	00015717          	auipc	a4,0x15
    80003c40:	d7c70713          	addi	a4,a4,-644 # 800189b8 <devsw>
    80003c44:	97ba                	add	a5,a5,a4
    80003c46:	679c                	ld	a5,8(a5)
    80003c48:	cbdd                	beqz	a5,80003cfe <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003c4a:	4505                	li	a0,1
    80003c4c:	9782                	jalr	a5
    80003c4e:	8a2a                	mv	s4,a0
    80003c50:	a8a5                	j	80003cc8 <filewrite+0xfa>
    80003c52:	00048a9b          	sext.w	s5,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003c56:	00000097          	auipc	ra,0x0
    80003c5a:	8b4080e7          	jalr	-1868(ra) # 8000350a <begin_op>
      ilock(f->ip);
    80003c5e:	01893503          	ld	a0,24(s2)
    80003c62:	fffff097          	auipc	ra,0xfffff
    80003c66:	edc080e7          	jalr	-292(ra) # 80002b3e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003c6a:	8756                	mv	a4,s5
    80003c6c:	02092683          	lw	a3,32(s2)
    80003c70:	01698633          	add	a2,s3,s6
    80003c74:	4585                	li	a1,1
    80003c76:	01893503          	ld	a0,24(s2)
    80003c7a:	fffff097          	auipc	ra,0xfffff
    80003c7e:	270080e7          	jalr	624(ra) # 80002eea <writei>
    80003c82:	84aa                	mv	s1,a0
    80003c84:	00a05763          	blez	a0,80003c92 <filewrite+0xc4>
        f->off += r;
    80003c88:	02092783          	lw	a5,32(s2)
    80003c8c:	9fa9                	addw	a5,a5,a0
    80003c8e:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003c92:	01893503          	ld	a0,24(s2)
    80003c96:	fffff097          	auipc	ra,0xfffff
    80003c9a:	f6a080e7          	jalr	-150(ra) # 80002c00 <iunlock>
      end_op();
    80003c9e:	00000097          	auipc	ra,0x0
    80003ca2:	8ea080e7          	jalr	-1814(ra) # 80003588 <end_op>

      if(r != n1){
    80003ca6:	009a9f63          	bne	s5,s1,80003cc4 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003caa:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003cae:	0149db63          	bge	s3,s4,80003cc4 <filewrite+0xf6>
      int n1 = n - i;
    80003cb2:	413a04bb          	subw	s1,s4,s3
    80003cb6:	0004879b          	sext.w	a5,s1
    80003cba:	f8fbdce3          	bge	s7,a5,80003c52 <filewrite+0x84>
    80003cbe:	84e2                	mv	s1,s8
    80003cc0:	bf49                	j	80003c52 <filewrite+0x84>
    int i = 0;
    80003cc2:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003cc4:	013a1f63          	bne	s4,s3,80003ce2 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003cc8:	8552                	mv	a0,s4
    80003cca:	60a6                	ld	ra,72(sp)
    80003ccc:	6406                	ld	s0,64(sp)
    80003cce:	74e2                	ld	s1,56(sp)
    80003cd0:	7942                	ld	s2,48(sp)
    80003cd2:	79a2                	ld	s3,40(sp)
    80003cd4:	7a02                	ld	s4,32(sp)
    80003cd6:	6ae2                	ld	s5,24(sp)
    80003cd8:	6b42                	ld	s6,16(sp)
    80003cda:	6ba2                	ld	s7,8(sp)
    80003cdc:	6c02                	ld	s8,0(sp)
    80003cde:	6161                	addi	sp,sp,80
    80003ce0:	8082                	ret
    ret = (i == n ? n : -1);
    80003ce2:	5a7d                	li	s4,-1
    80003ce4:	b7d5                	j	80003cc8 <filewrite+0xfa>
    panic("filewrite");
    80003ce6:	00005517          	auipc	a0,0x5
    80003cea:	99250513          	addi	a0,a0,-1646 # 80008678 <syscalls+0x268>
    80003cee:	00002097          	auipc	ra,0x2
    80003cf2:	efe080e7          	jalr	-258(ra) # 80005bec <panic>
    return -1;
    80003cf6:	5a7d                	li	s4,-1
    80003cf8:	bfc1                	j	80003cc8 <filewrite+0xfa>
      return -1;
    80003cfa:	5a7d                	li	s4,-1
    80003cfc:	b7f1                	j	80003cc8 <filewrite+0xfa>
    80003cfe:	5a7d                	li	s4,-1
    80003d00:	b7e1                	j	80003cc8 <filewrite+0xfa>

0000000080003d02 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003d02:	7179                	addi	sp,sp,-48
    80003d04:	f406                	sd	ra,40(sp)
    80003d06:	f022                	sd	s0,32(sp)
    80003d08:	ec26                	sd	s1,24(sp)
    80003d0a:	e84a                	sd	s2,16(sp)
    80003d0c:	e44e                	sd	s3,8(sp)
    80003d0e:	e052                	sd	s4,0(sp)
    80003d10:	1800                	addi	s0,sp,48
    80003d12:	84aa                	mv	s1,a0
    80003d14:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003d16:	0005b023          	sd	zero,0(a1)
    80003d1a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003d1e:	00000097          	auipc	ra,0x0
    80003d22:	bf8080e7          	jalr	-1032(ra) # 80003916 <filealloc>
    80003d26:	e088                	sd	a0,0(s1)
    80003d28:	c551                	beqz	a0,80003db4 <pipealloc+0xb2>
    80003d2a:	00000097          	auipc	ra,0x0
    80003d2e:	bec080e7          	jalr	-1044(ra) # 80003916 <filealloc>
    80003d32:	00aa3023          	sd	a0,0(s4)
    80003d36:	c92d                	beqz	a0,80003da8 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003d38:	ffffc097          	auipc	ra,0xffffc
    80003d3c:	3e2080e7          	jalr	994(ra) # 8000011a <kalloc>
    80003d40:	892a                	mv	s2,a0
    80003d42:	c125                	beqz	a0,80003da2 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003d44:	4985                	li	s3,1
    80003d46:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003d4a:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003d4e:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003d52:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003d56:	00005597          	auipc	a1,0x5
    80003d5a:	93258593          	addi	a1,a1,-1742 # 80008688 <syscalls+0x278>
    80003d5e:	00002097          	auipc	ra,0x2
    80003d62:	336080e7          	jalr	822(ra) # 80006094 <initlock>
  (*f0)->type = FD_PIPE;
    80003d66:	609c                	ld	a5,0(s1)
    80003d68:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003d6c:	609c                	ld	a5,0(s1)
    80003d6e:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003d72:	609c                	ld	a5,0(s1)
    80003d74:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003d78:	609c                	ld	a5,0(s1)
    80003d7a:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003d7e:	000a3783          	ld	a5,0(s4)
    80003d82:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003d86:	000a3783          	ld	a5,0(s4)
    80003d8a:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003d8e:	000a3783          	ld	a5,0(s4)
    80003d92:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003d96:	000a3783          	ld	a5,0(s4)
    80003d9a:	0127b823          	sd	s2,16(a5)
  return 0;
    80003d9e:	4501                	li	a0,0
    80003da0:	a025                	j	80003dc8 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003da2:	6088                	ld	a0,0(s1)
    80003da4:	e501                	bnez	a0,80003dac <pipealloc+0xaa>
    80003da6:	a039                	j	80003db4 <pipealloc+0xb2>
    80003da8:	6088                	ld	a0,0(s1)
    80003daa:	c51d                	beqz	a0,80003dd8 <pipealloc+0xd6>
    fileclose(*f0);
    80003dac:	00000097          	auipc	ra,0x0
    80003db0:	c26080e7          	jalr	-986(ra) # 800039d2 <fileclose>
  if(*f1)
    80003db4:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003db8:	557d                	li	a0,-1
  if(*f1)
    80003dba:	c799                	beqz	a5,80003dc8 <pipealloc+0xc6>
    fileclose(*f1);
    80003dbc:	853e                	mv	a0,a5
    80003dbe:	00000097          	auipc	ra,0x0
    80003dc2:	c14080e7          	jalr	-1004(ra) # 800039d2 <fileclose>
  return -1;
    80003dc6:	557d                	li	a0,-1
}
    80003dc8:	70a2                	ld	ra,40(sp)
    80003dca:	7402                	ld	s0,32(sp)
    80003dcc:	64e2                	ld	s1,24(sp)
    80003dce:	6942                	ld	s2,16(sp)
    80003dd0:	69a2                	ld	s3,8(sp)
    80003dd2:	6a02                	ld	s4,0(sp)
    80003dd4:	6145                	addi	sp,sp,48
    80003dd6:	8082                	ret
  return -1;
    80003dd8:	557d                	li	a0,-1
    80003dda:	b7fd                	j	80003dc8 <pipealloc+0xc6>

0000000080003ddc <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003ddc:	1101                	addi	sp,sp,-32
    80003dde:	ec06                	sd	ra,24(sp)
    80003de0:	e822                	sd	s0,16(sp)
    80003de2:	e426                	sd	s1,8(sp)
    80003de4:	e04a                	sd	s2,0(sp)
    80003de6:	1000                	addi	s0,sp,32
    80003de8:	84aa                	mv	s1,a0
    80003dea:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003dec:	00002097          	auipc	ra,0x2
    80003df0:	338080e7          	jalr	824(ra) # 80006124 <acquire>
  if(writable){
    80003df4:	02090d63          	beqz	s2,80003e2e <pipeclose+0x52>
    pi->writeopen = 0;
    80003df8:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003dfc:	21848513          	addi	a0,s1,536
    80003e00:	ffffd097          	auipc	ra,0xffffd
    80003e04:	7bc080e7          	jalr	1980(ra) # 800015bc <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003e08:	2204b783          	ld	a5,544(s1)
    80003e0c:	eb95                	bnez	a5,80003e40 <pipeclose+0x64>
    release(&pi->lock);
    80003e0e:	8526                	mv	a0,s1
    80003e10:	00002097          	auipc	ra,0x2
    80003e14:	3c8080e7          	jalr	968(ra) # 800061d8 <release>
    kfree((char*)pi);
    80003e18:	8526                	mv	a0,s1
    80003e1a:	ffffc097          	auipc	ra,0xffffc
    80003e1e:	202080e7          	jalr	514(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003e22:	60e2                	ld	ra,24(sp)
    80003e24:	6442                	ld	s0,16(sp)
    80003e26:	64a2                	ld	s1,8(sp)
    80003e28:	6902                	ld	s2,0(sp)
    80003e2a:	6105                	addi	sp,sp,32
    80003e2c:	8082                	ret
    pi->readopen = 0;
    80003e2e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003e32:	21c48513          	addi	a0,s1,540
    80003e36:	ffffd097          	auipc	ra,0xffffd
    80003e3a:	786080e7          	jalr	1926(ra) # 800015bc <wakeup>
    80003e3e:	b7e9                	j	80003e08 <pipeclose+0x2c>
    release(&pi->lock);
    80003e40:	8526                	mv	a0,s1
    80003e42:	00002097          	auipc	ra,0x2
    80003e46:	396080e7          	jalr	918(ra) # 800061d8 <release>
}
    80003e4a:	bfe1                	j	80003e22 <pipeclose+0x46>

0000000080003e4c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003e4c:	711d                	addi	sp,sp,-96
    80003e4e:	ec86                	sd	ra,88(sp)
    80003e50:	e8a2                	sd	s0,80(sp)
    80003e52:	e4a6                	sd	s1,72(sp)
    80003e54:	e0ca                	sd	s2,64(sp)
    80003e56:	fc4e                	sd	s3,56(sp)
    80003e58:	f852                	sd	s4,48(sp)
    80003e5a:	f456                	sd	s5,40(sp)
    80003e5c:	f05a                	sd	s6,32(sp)
    80003e5e:	ec5e                	sd	s7,24(sp)
    80003e60:	e862                	sd	s8,16(sp)
    80003e62:	1080                	addi	s0,sp,96
    80003e64:	84aa                	mv	s1,a0
    80003e66:	8aae                	mv	s5,a1
    80003e68:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003e6a:	ffffd097          	auipc	ra,0xffffd
    80003e6e:	042080e7          	jalr	66(ra) # 80000eac <myproc>
    80003e72:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003e74:	8526                	mv	a0,s1
    80003e76:	00002097          	auipc	ra,0x2
    80003e7a:	2ae080e7          	jalr	686(ra) # 80006124 <acquire>
  while(i < n){
    80003e7e:	0b405663          	blez	s4,80003f2a <pipewrite+0xde>
  int i = 0;
    80003e82:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003e84:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003e86:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003e8a:	21c48b93          	addi	s7,s1,540
    80003e8e:	a089                	j	80003ed0 <pipewrite+0x84>
      release(&pi->lock);
    80003e90:	8526                	mv	a0,s1
    80003e92:	00002097          	auipc	ra,0x2
    80003e96:	346080e7          	jalr	838(ra) # 800061d8 <release>
      return -1;
    80003e9a:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003e9c:	854a                	mv	a0,s2
    80003e9e:	60e6                	ld	ra,88(sp)
    80003ea0:	6446                	ld	s0,80(sp)
    80003ea2:	64a6                	ld	s1,72(sp)
    80003ea4:	6906                	ld	s2,64(sp)
    80003ea6:	79e2                	ld	s3,56(sp)
    80003ea8:	7a42                	ld	s4,48(sp)
    80003eaa:	7aa2                	ld	s5,40(sp)
    80003eac:	7b02                	ld	s6,32(sp)
    80003eae:	6be2                	ld	s7,24(sp)
    80003eb0:	6c42                	ld	s8,16(sp)
    80003eb2:	6125                	addi	sp,sp,96
    80003eb4:	8082                	ret
      wakeup(&pi->nread);
    80003eb6:	8562                	mv	a0,s8
    80003eb8:	ffffd097          	auipc	ra,0xffffd
    80003ebc:	704080e7          	jalr	1796(ra) # 800015bc <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003ec0:	85a6                	mv	a1,s1
    80003ec2:	855e                	mv	a0,s7
    80003ec4:	ffffd097          	auipc	ra,0xffffd
    80003ec8:	694080e7          	jalr	1684(ra) # 80001558 <sleep>
  while(i < n){
    80003ecc:	07495063          	bge	s2,s4,80003f2c <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    80003ed0:	2204a783          	lw	a5,544(s1)
    80003ed4:	dfd5                	beqz	a5,80003e90 <pipewrite+0x44>
    80003ed6:	854e                	mv	a0,s3
    80003ed8:	ffffe097          	auipc	ra,0xffffe
    80003edc:	928080e7          	jalr	-1752(ra) # 80001800 <killed>
    80003ee0:	f945                	bnez	a0,80003e90 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003ee2:	2184a783          	lw	a5,536(s1)
    80003ee6:	21c4a703          	lw	a4,540(s1)
    80003eea:	2007879b          	addiw	a5,a5,512
    80003eee:	fcf704e3          	beq	a4,a5,80003eb6 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003ef2:	4685                	li	a3,1
    80003ef4:	01590633          	add	a2,s2,s5
    80003ef8:	faf40593          	addi	a1,s0,-81
    80003efc:	0509b503          	ld	a0,80(s3)
    80003f00:	ffffd097          	auipc	ra,0xffffd
    80003f04:	cf8080e7          	jalr	-776(ra) # 80000bf8 <copyin>
    80003f08:	03650263          	beq	a0,s6,80003f2c <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003f0c:	21c4a783          	lw	a5,540(s1)
    80003f10:	0017871b          	addiw	a4,a5,1
    80003f14:	20e4ae23          	sw	a4,540(s1)
    80003f18:	1ff7f793          	andi	a5,a5,511
    80003f1c:	97a6                	add	a5,a5,s1
    80003f1e:	faf44703          	lbu	a4,-81(s0)
    80003f22:	00e78c23          	sb	a4,24(a5)
      i++;
    80003f26:	2905                	addiw	s2,s2,1
    80003f28:	b755                	j	80003ecc <pipewrite+0x80>
  int i = 0;
    80003f2a:	4901                	li	s2,0
  wakeup(&pi->nread);
    80003f2c:	21848513          	addi	a0,s1,536
    80003f30:	ffffd097          	auipc	ra,0xffffd
    80003f34:	68c080e7          	jalr	1676(ra) # 800015bc <wakeup>
  release(&pi->lock);
    80003f38:	8526                	mv	a0,s1
    80003f3a:	00002097          	auipc	ra,0x2
    80003f3e:	29e080e7          	jalr	670(ra) # 800061d8 <release>
  return i;
    80003f42:	bfa9                	j	80003e9c <pipewrite+0x50>

0000000080003f44 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003f44:	715d                	addi	sp,sp,-80
    80003f46:	e486                	sd	ra,72(sp)
    80003f48:	e0a2                	sd	s0,64(sp)
    80003f4a:	fc26                	sd	s1,56(sp)
    80003f4c:	f84a                	sd	s2,48(sp)
    80003f4e:	f44e                	sd	s3,40(sp)
    80003f50:	f052                	sd	s4,32(sp)
    80003f52:	ec56                	sd	s5,24(sp)
    80003f54:	e85a                	sd	s6,16(sp)
    80003f56:	0880                	addi	s0,sp,80
    80003f58:	84aa                	mv	s1,a0
    80003f5a:	892e                	mv	s2,a1
    80003f5c:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003f5e:	ffffd097          	auipc	ra,0xffffd
    80003f62:	f4e080e7          	jalr	-178(ra) # 80000eac <myproc>
    80003f66:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003f68:	8526                	mv	a0,s1
    80003f6a:	00002097          	auipc	ra,0x2
    80003f6e:	1ba080e7          	jalr	442(ra) # 80006124 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003f72:	2184a703          	lw	a4,536(s1)
    80003f76:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003f7a:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003f7e:	02f71763          	bne	a4,a5,80003fac <piperead+0x68>
    80003f82:	2244a783          	lw	a5,548(s1)
    80003f86:	c39d                	beqz	a5,80003fac <piperead+0x68>
    if(killed(pr)){
    80003f88:	8552                	mv	a0,s4
    80003f8a:	ffffe097          	auipc	ra,0xffffe
    80003f8e:	876080e7          	jalr	-1930(ra) # 80001800 <killed>
    80003f92:	e949                	bnez	a0,80004024 <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003f94:	85a6                	mv	a1,s1
    80003f96:	854e                	mv	a0,s3
    80003f98:	ffffd097          	auipc	ra,0xffffd
    80003f9c:	5c0080e7          	jalr	1472(ra) # 80001558 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fa0:	2184a703          	lw	a4,536(s1)
    80003fa4:	21c4a783          	lw	a5,540(s1)
    80003fa8:	fcf70de3          	beq	a4,a5,80003f82 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003fac:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003fae:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003fb0:	05505463          	blez	s5,80003ff8 <piperead+0xb4>
    if(pi->nread == pi->nwrite)
    80003fb4:	2184a783          	lw	a5,536(s1)
    80003fb8:	21c4a703          	lw	a4,540(s1)
    80003fbc:	02f70e63          	beq	a4,a5,80003ff8 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003fc0:	0017871b          	addiw	a4,a5,1
    80003fc4:	20e4ac23          	sw	a4,536(s1)
    80003fc8:	1ff7f793          	andi	a5,a5,511
    80003fcc:	97a6                	add	a5,a5,s1
    80003fce:	0187c783          	lbu	a5,24(a5)
    80003fd2:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003fd6:	4685                	li	a3,1
    80003fd8:	fbf40613          	addi	a2,s0,-65
    80003fdc:	85ca                	mv	a1,s2
    80003fde:	050a3503          	ld	a0,80(s4)
    80003fe2:	ffffd097          	auipc	ra,0xffffd
    80003fe6:	b56080e7          	jalr	-1194(ra) # 80000b38 <copyout>
    80003fea:	01650763          	beq	a0,s6,80003ff8 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003fee:	2985                	addiw	s3,s3,1
    80003ff0:	0905                	addi	s2,s2,1
    80003ff2:	fd3a91e3          	bne	s5,s3,80003fb4 <piperead+0x70>
    80003ff6:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003ff8:	21c48513          	addi	a0,s1,540
    80003ffc:	ffffd097          	auipc	ra,0xffffd
    80004000:	5c0080e7          	jalr	1472(ra) # 800015bc <wakeup>
  release(&pi->lock);
    80004004:	8526                	mv	a0,s1
    80004006:	00002097          	auipc	ra,0x2
    8000400a:	1d2080e7          	jalr	466(ra) # 800061d8 <release>
  return i;
}
    8000400e:	854e                	mv	a0,s3
    80004010:	60a6                	ld	ra,72(sp)
    80004012:	6406                	ld	s0,64(sp)
    80004014:	74e2                	ld	s1,56(sp)
    80004016:	7942                	ld	s2,48(sp)
    80004018:	79a2                	ld	s3,40(sp)
    8000401a:	7a02                	ld	s4,32(sp)
    8000401c:	6ae2                	ld	s5,24(sp)
    8000401e:	6b42                	ld	s6,16(sp)
    80004020:	6161                	addi	sp,sp,80
    80004022:	8082                	ret
      release(&pi->lock);
    80004024:	8526                	mv	a0,s1
    80004026:	00002097          	auipc	ra,0x2
    8000402a:	1b2080e7          	jalr	434(ra) # 800061d8 <release>
      return -1;
    8000402e:	59fd                	li	s3,-1
    80004030:	bff9                	j	8000400e <piperead+0xca>

0000000080004032 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80004032:	1141                	addi	sp,sp,-16
    80004034:	e422                	sd	s0,8(sp)
    80004036:	0800                	addi	s0,sp,16
    80004038:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    8000403a:	8905                	andi	a0,a0,1
    8000403c:	050e                	slli	a0,a0,0x3
      perm = PTE_X;
    if(flags & 0x2)
    8000403e:	8b89                	andi	a5,a5,2
    80004040:	c399                	beqz	a5,80004046 <flags2perm+0x14>
      perm |= PTE_W;
    80004042:	00456513          	ori	a0,a0,4
    return perm;
}
    80004046:	6422                	ld	s0,8(sp)
    80004048:	0141                	addi	sp,sp,16
    8000404a:	8082                	ret

000000008000404c <exec>:

int
exec(char *path, char **argv)
{
    8000404c:	de010113          	addi	sp,sp,-544
    80004050:	20113c23          	sd	ra,536(sp)
    80004054:	20813823          	sd	s0,528(sp)
    80004058:	20913423          	sd	s1,520(sp)
    8000405c:	21213023          	sd	s2,512(sp)
    80004060:	ffce                	sd	s3,504(sp)
    80004062:	fbd2                	sd	s4,496(sp)
    80004064:	f7d6                	sd	s5,488(sp)
    80004066:	f3da                	sd	s6,480(sp)
    80004068:	efde                	sd	s7,472(sp)
    8000406a:	ebe2                	sd	s8,464(sp)
    8000406c:	e7e6                	sd	s9,456(sp)
    8000406e:	e3ea                	sd	s10,448(sp)
    80004070:	ff6e                	sd	s11,440(sp)
    80004072:	1400                	addi	s0,sp,544
    80004074:	892a                	mv	s2,a0
    80004076:	dea43423          	sd	a0,-536(s0)
    8000407a:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000407e:	ffffd097          	auipc	ra,0xffffd
    80004082:	e2e080e7          	jalr	-466(ra) # 80000eac <myproc>
    80004086:	84aa                	mv	s1,a0

  begin_op();
    80004088:	fffff097          	auipc	ra,0xfffff
    8000408c:	482080e7          	jalr	1154(ra) # 8000350a <begin_op>

  if((ip = namei(path)) == 0){
    80004090:	854a                	mv	a0,s2
    80004092:	fffff097          	auipc	ra,0xfffff
    80004096:	258080e7          	jalr	600(ra) # 800032ea <namei>
    8000409a:	c93d                	beqz	a0,80004110 <exec+0xc4>
    8000409c:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    8000409e:	fffff097          	auipc	ra,0xfffff
    800040a2:	aa0080e7          	jalr	-1376(ra) # 80002b3e <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800040a6:	04000713          	li	a4,64
    800040aa:	4681                	li	a3,0
    800040ac:	e5040613          	addi	a2,s0,-432
    800040b0:	4581                	li	a1,0
    800040b2:	8556                	mv	a0,s5
    800040b4:	fffff097          	auipc	ra,0xfffff
    800040b8:	d3e080e7          	jalr	-706(ra) # 80002df2 <readi>
    800040bc:	04000793          	li	a5,64
    800040c0:	00f51a63          	bne	a0,a5,800040d4 <exec+0x88>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    800040c4:	e5042703          	lw	a4,-432(s0)
    800040c8:	464c47b7          	lui	a5,0x464c4
    800040cc:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800040d0:	04f70663          	beq	a4,a5,8000411c <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800040d4:	8556                	mv	a0,s5
    800040d6:	fffff097          	auipc	ra,0xfffff
    800040da:	cca080e7          	jalr	-822(ra) # 80002da0 <iunlockput>
    end_op();
    800040de:	fffff097          	auipc	ra,0xfffff
    800040e2:	4aa080e7          	jalr	1194(ra) # 80003588 <end_op>
  }
  return -1;
    800040e6:	557d                	li	a0,-1
}
    800040e8:	21813083          	ld	ra,536(sp)
    800040ec:	21013403          	ld	s0,528(sp)
    800040f0:	20813483          	ld	s1,520(sp)
    800040f4:	20013903          	ld	s2,512(sp)
    800040f8:	79fe                	ld	s3,504(sp)
    800040fa:	7a5e                	ld	s4,496(sp)
    800040fc:	7abe                	ld	s5,488(sp)
    800040fe:	7b1e                	ld	s6,480(sp)
    80004100:	6bfe                	ld	s7,472(sp)
    80004102:	6c5e                	ld	s8,464(sp)
    80004104:	6cbe                	ld	s9,456(sp)
    80004106:	6d1e                	ld	s10,448(sp)
    80004108:	7dfa                	ld	s11,440(sp)
    8000410a:	22010113          	addi	sp,sp,544
    8000410e:	8082                	ret
    end_op();
    80004110:	fffff097          	auipc	ra,0xfffff
    80004114:	478080e7          	jalr	1144(ra) # 80003588 <end_op>
    return -1;
    80004118:	557d                	li	a0,-1
    8000411a:	b7f9                	j	800040e8 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    8000411c:	8526                	mv	a0,s1
    8000411e:	ffffd097          	auipc	ra,0xffffd
    80004122:	e56080e7          	jalr	-426(ra) # 80000f74 <proc_pagetable>
    80004126:	8b2a                	mv	s6,a0
    80004128:	d555                	beqz	a0,800040d4 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000412a:	e7042783          	lw	a5,-400(s0)
    8000412e:	e8845703          	lhu	a4,-376(s0)
    80004132:	c735                	beqz	a4,8000419e <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004134:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004136:	e0043423          	sd	zero,-504(s0)
    if(ph.vaddr % PGSIZE != 0)
    8000413a:	6a05                	lui	s4,0x1
    8000413c:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004140:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80004144:	6d85                	lui	s11,0x1
    80004146:	7d7d                	lui	s10,0xfffff
    80004148:	ac3d                	j	80004386 <exec+0x33a>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    8000414a:	00004517          	auipc	a0,0x4
    8000414e:	54650513          	addi	a0,a0,1350 # 80008690 <syscalls+0x280>
    80004152:	00002097          	auipc	ra,0x2
    80004156:	a9a080e7          	jalr	-1382(ra) # 80005bec <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000415a:	874a                	mv	a4,s2
    8000415c:	009c86bb          	addw	a3,s9,s1
    80004160:	4581                	li	a1,0
    80004162:	8556                	mv	a0,s5
    80004164:	fffff097          	auipc	ra,0xfffff
    80004168:	c8e080e7          	jalr	-882(ra) # 80002df2 <readi>
    8000416c:	2501                	sext.w	a0,a0
    8000416e:	1aa91963          	bne	s2,a0,80004320 <exec+0x2d4>
  for(i = 0; i < sz; i += PGSIZE){
    80004172:	009d84bb          	addw	s1,s11,s1
    80004176:	013d09bb          	addw	s3,s10,s3
    8000417a:	1f74f663          	bgeu	s1,s7,80004366 <exec+0x31a>
    pa = walkaddr(pagetable, va + i);
    8000417e:	02049593          	slli	a1,s1,0x20
    80004182:	9181                	srli	a1,a1,0x20
    80004184:	95e2                	add	a1,a1,s8
    80004186:	855a                	mv	a0,s6
    80004188:	ffffc097          	auipc	ra,0xffffc
    8000418c:	37c080e7          	jalr	892(ra) # 80000504 <walkaddr>
    80004190:	862a                	mv	a2,a0
    if(pa == 0)
    80004192:	dd45                	beqz	a0,8000414a <exec+0xfe>
      n = PGSIZE;
    80004194:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004196:	fd49f2e3          	bgeu	s3,s4,8000415a <exec+0x10e>
      n = sz - i;
    8000419a:	894e                	mv	s2,s3
    8000419c:	bf7d                	j	8000415a <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000419e:	4901                	li	s2,0
  iunlockput(ip);
    800041a0:	8556                	mv	a0,s5
    800041a2:	fffff097          	auipc	ra,0xfffff
    800041a6:	bfe080e7          	jalr	-1026(ra) # 80002da0 <iunlockput>
  end_op();
    800041aa:	fffff097          	auipc	ra,0xfffff
    800041ae:	3de080e7          	jalr	990(ra) # 80003588 <end_op>
  p = myproc();
    800041b2:	ffffd097          	auipc	ra,0xffffd
    800041b6:	cfa080e7          	jalr	-774(ra) # 80000eac <myproc>
    800041ba:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    800041bc:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800041c0:	6785                	lui	a5,0x1
    800041c2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800041c4:	97ca                	add	a5,a5,s2
    800041c6:	777d                	lui	a4,0xfffff
    800041c8:	8ff9                	and	a5,a5,a4
    800041ca:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800041ce:	4691                	li	a3,4
    800041d0:	6609                	lui	a2,0x2
    800041d2:	963e                	add	a2,a2,a5
    800041d4:	85be                	mv	a1,a5
    800041d6:	855a                	mv	a0,s6
    800041d8:	ffffc097          	auipc	ra,0xffffc
    800041dc:	704080e7          	jalr	1796(ra) # 800008dc <uvmalloc>
    800041e0:	8c2a                	mv	s8,a0
  ip = 0;
    800041e2:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800041e4:	12050e63          	beqz	a0,80004320 <exec+0x2d4>
  uvmclear(pagetable, sz-2*PGSIZE);
    800041e8:	75f9                	lui	a1,0xffffe
    800041ea:	95aa                	add	a1,a1,a0
    800041ec:	855a                	mv	a0,s6
    800041ee:	ffffd097          	auipc	ra,0xffffd
    800041f2:	918080e7          	jalr	-1768(ra) # 80000b06 <uvmclear>
  stackbase = sp - PGSIZE;
    800041f6:	7afd                	lui	s5,0xfffff
    800041f8:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    800041fa:	df043783          	ld	a5,-528(s0)
    800041fe:	6388                	ld	a0,0(a5)
    80004200:	c925                	beqz	a0,80004270 <exec+0x224>
    80004202:	e9040993          	addi	s3,s0,-368
    80004206:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    8000420a:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    8000420c:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    8000420e:	ffffc097          	auipc	ra,0xffffc
    80004212:	0e8080e7          	jalr	232(ra) # 800002f6 <strlen>
    80004216:	0015079b          	addiw	a5,a0,1
    8000421a:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000421e:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80004222:	13596663          	bltu	s2,s5,8000434e <exec+0x302>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004226:	df043d83          	ld	s11,-528(s0)
    8000422a:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    8000422e:	8552                	mv	a0,s4
    80004230:	ffffc097          	auipc	ra,0xffffc
    80004234:	0c6080e7          	jalr	198(ra) # 800002f6 <strlen>
    80004238:	0015069b          	addiw	a3,a0,1
    8000423c:	8652                	mv	a2,s4
    8000423e:	85ca                	mv	a1,s2
    80004240:	855a                	mv	a0,s6
    80004242:	ffffd097          	auipc	ra,0xffffd
    80004246:	8f6080e7          	jalr	-1802(ra) # 80000b38 <copyout>
    8000424a:	10054663          	bltz	a0,80004356 <exec+0x30a>
    ustack[argc] = sp;
    8000424e:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004252:	0485                	addi	s1,s1,1
    80004254:	008d8793          	addi	a5,s11,8
    80004258:	def43823          	sd	a5,-528(s0)
    8000425c:	008db503          	ld	a0,8(s11)
    80004260:	c911                	beqz	a0,80004274 <exec+0x228>
    if(argc >= MAXARG)
    80004262:	09a1                	addi	s3,s3,8
    80004264:	fb3c95e3          	bne	s9,s3,8000420e <exec+0x1c2>
  sz = sz1;
    80004268:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000426c:	4a81                	li	s5,0
    8000426e:	a84d                	j	80004320 <exec+0x2d4>
  sp = sz;
    80004270:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004272:	4481                	li	s1,0
  ustack[argc] = 0;
    80004274:	00349793          	slli	a5,s1,0x3
    80004278:	f9078793          	addi	a5,a5,-112
    8000427c:	97a2                	add	a5,a5,s0
    8000427e:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004282:	00148693          	addi	a3,s1,1
    80004286:	068e                	slli	a3,a3,0x3
    80004288:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000428c:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004290:	01597663          	bgeu	s2,s5,8000429c <exec+0x250>
  sz = sz1;
    80004294:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004298:	4a81                	li	s5,0
    8000429a:	a059                	j	80004320 <exec+0x2d4>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000429c:	e9040613          	addi	a2,s0,-368
    800042a0:	85ca                	mv	a1,s2
    800042a2:	855a                	mv	a0,s6
    800042a4:	ffffd097          	auipc	ra,0xffffd
    800042a8:	894080e7          	jalr	-1900(ra) # 80000b38 <copyout>
    800042ac:	0a054963          	bltz	a0,8000435e <exec+0x312>
  p->trapframe->a1 = sp;
    800042b0:	058bb783          	ld	a5,88(s7)
    800042b4:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800042b8:	de843783          	ld	a5,-536(s0)
    800042bc:	0007c703          	lbu	a4,0(a5)
    800042c0:	cf11                	beqz	a4,800042dc <exec+0x290>
    800042c2:	0785                	addi	a5,a5,1
    if(*s == '/')
    800042c4:	02f00693          	li	a3,47
    800042c8:	a039                	j	800042d6 <exec+0x28a>
      last = s+1;
    800042ca:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    800042ce:	0785                	addi	a5,a5,1
    800042d0:	fff7c703          	lbu	a4,-1(a5)
    800042d4:	c701                	beqz	a4,800042dc <exec+0x290>
    if(*s == '/')
    800042d6:	fed71ce3          	bne	a4,a3,800042ce <exec+0x282>
    800042da:	bfc5                	j	800042ca <exec+0x27e>
  safestrcpy(p->name, last, sizeof(p->name));
    800042dc:	4641                	li	a2,16
    800042de:	de843583          	ld	a1,-536(s0)
    800042e2:	158b8513          	addi	a0,s7,344
    800042e6:	ffffc097          	auipc	ra,0xffffc
    800042ea:	fde080e7          	jalr	-34(ra) # 800002c4 <safestrcpy>
  oldpagetable = p->pagetable;
    800042ee:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    800042f2:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    800042f6:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800042fa:	058bb783          	ld	a5,88(s7)
    800042fe:	e6843703          	ld	a4,-408(s0)
    80004302:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004304:	058bb783          	ld	a5,88(s7)
    80004308:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000430c:	85ea                	mv	a1,s10
    8000430e:	ffffd097          	auipc	ra,0xffffd
    80004312:	d02080e7          	jalr	-766(ra) # 80001010 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004316:	0004851b          	sext.w	a0,s1
    8000431a:	b3f9                	j	800040e8 <exec+0x9c>
    8000431c:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004320:	df843583          	ld	a1,-520(s0)
    80004324:	855a                	mv	a0,s6
    80004326:	ffffd097          	auipc	ra,0xffffd
    8000432a:	cea080e7          	jalr	-790(ra) # 80001010 <proc_freepagetable>
  if(ip){
    8000432e:	da0a93e3          	bnez	s5,800040d4 <exec+0x88>
  return -1;
    80004332:	557d                	li	a0,-1
    80004334:	bb55                	j	800040e8 <exec+0x9c>
    80004336:	df243c23          	sd	s2,-520(s0)
    8000433a:	b7dd                	j	80004320 <exec+0x2d4>
    8000433c:	df243c23          	sd	s2,-520(s0)
    80004340:	b7c5                	j	80004320 <exec+0x2d4>
    80004342:	df243c23          	sd	s2,-520(s0)
    80004346:	bfe9                	j	80004320 <exec+0x2d4>
    80004348:	df243c23          	sd	s2,-520(s0)
    8000434c:	bfd1                	j	80004320 <exec+0x2d4>
  sz = sz1;
    8000434e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004352:	4a81                	li	s5,0
    80004354:	b7f1                	j	80004320 <exec+0x2d4>
  sz = sz1;
    80004356:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000435a:	4a81                	li	s5,0
    8000435c:	b7d1                	j	80004320 <exec+0x2d4>
  sz = sz1;
    8000435e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004362:	4a81                	li	s5,0
    80004364:	bf75                	j	80004320 <exec+0x2d4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004366:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000436a:	e0843783          	ld	a5,-504(s0)
    8000436e:	0017869b          	addiw	a3,a5,1
    80004372:	e0d43423          	sd	a3,-504(s0)
    80004376:	e0043783          	ld	a5,-512(s0)
    8000437a:	0387879b          	addiw	a5,a5,56
    8000437e:	e8845703          	lhu	a4,-376(s0)
    80004382:	e0e6dfe3          	bge	a3,a4,800041a0 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004386:	2781                	sext.w	a5,a5
    80004388:	e0f43023          	sd	a5,-512(s0)
    8000438c:	03800713          	li	a4,56
    80004390:	86be                	mv	a3,a5
    80004392:	e1840613          	addi	a2,s0,-488
    80004396:	4581                	li	a1,0
    80004398:	8556                	mv	a0,s5
    8000439a:	fffff097          	auipc	ra,0xfffff
    8000439e:	a58080e7          	jalr	-1448(ra) # 80002df2 <readi>
    800043a2:	03800793          	li	a5,56
    800043a6:	f6f51be3          	bne	a0,a5,8000431c <exec+0x2d0>
    if(ph.type != ELF_PROG_LOAD)
    800043aa:	e1842783          	lw	a5,-488(s0)
    800043ae:	4705                	li	a4,1
    800043b0:	fae79de3          	bne	a5,a4,8000436a <exec+0x31e>
    if(ph.memsz < ph.filesz)
    800043b4:	e4043483          	ld	s1,-448(s0)
    800043b8:	e3843783          	ld	a5,-456(s0)
    800043bc:	f6f4ede3          	bltu	s1,a5,80004336 <exec+0x2ea>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800043c0:	e2843783          	ld	a5,-472(s0)
    800043c4:	94be                	add	s1,s1,a5
    800043c6:	f6f4ebe3          	bltu	s1,a5,8000433c <exec+0x2f0>
    if(ph.vaddr % PGSIZE != 0)
    800043ca:	de043703          	ld	a4,-544(s0)
    800043ce:	8ff9                	and	a5,a5,a4
    800043d0:	fbad                	bnez	a5,80004342 <exec+0x2f6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800043d2:	e1c42503          	lw	a0,-484(s0)
    800043d6:	00000097          	auipc	ra,0x0
    800043da:	c5c080e7          	jalr	-932(ra) # 80004032 <flags2perm>
    800043de:	86aa                	mv	a3,a0
    800043e0:	8626                	mv	a2,s1
    800043e2:	85ca                	mv	a1,s2
    800043e4:	855a                	mv	a0,s6
    800043e6:	ffffc097          	auipc	ra,0xffffc
    800043ea:	4f6080e7          	jalr	1270(ra) # 800008dc <uvmalloc>
    800043ee:	dea43c23          	sd	a0,-520(s0)
    800043f2:	d939                	beqz	a0,80004348 <exec+0x2fc>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800043f4:	e2843c03          	ld	s8,-472(s0)
    800043f8:	e2042c83          	lw	s9,-480(s0)
    800043fc:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004400:	f60b83e3          	beqz	s7,80004366 <exec+0x31a>
    80004404:	89de                	mv	s3,s7
    80004406:	4481                	li	s1,0
    80004408:	bb9d                	j	8000417e <exec+0x132>

000000008000440a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000440a:	7179                	addi	sp,sp,-48
    8000440c:	f406                	sd	ra,40(sp)
    8000440e:	f022                	sd	s0,32(sp)
    80004410:	ec26                	sd	s1,24(sp)
    80004412:	e84a                	sd	s2,16(sp)
    80004414:	1800                	addi	s0,sp,48
    80004416:	892e                	mv	s2,a1
    80004418:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000441a:	fdc40593          	addi	a1,s0,-36
    8000441e:	ffffe097          	auipc	ra,0xffffe
    80004422:	ba8080e7          	jalr	-1112(ra) # 80001fc6 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004426:	fdc42703          	lw	a4,-36(s0)
    8000442a:	47bd                	li	a5,15
    8000442c:	02e7eb63          	bltu	a5,a4,80004462 <argfd+0x58>
    80004430:	ffffd097          	auipc	ra,0xffffd
    80004434:	a7c080e7          	jalr	-1412(ra) # 80000eac <myproc>
    80004438:	fdc42703          	lw	a4,-36(s0)
    8000443c:	01a70793          	addi	a5,a4,26 # fffffffffffff01a <end+0xffffffff7ffdd28a>
    80004440:	078e                	slli	a5,a5,0x3
    80004442:	953e                	add	a0,a0,a5
    80004444:	611c                	ld	a5,0(a0)
    80004446:	c385                	beqz	a5,80004466 <argfd+0x5c>
    return -1;
  if(pfd)
    80004448:	00090463          	beqz	s2,80004450 <argfd+0x46>
    *pfd = fd;
    8000444c:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004450:	4501                	li	a0,0
  if(pf)
    80004452:	c091                	beqz	s1,80004456 <argfd+0x4c>
    *pf = f;
    80004454:	e09c                	sd	a5,0(s1)
}
    80004456:	70a2                	ld	ra,40(sp)
    80004458:	7402                	ld	s0,32(sp)
    8000445a:	64e2                	ld	s1,24(sp)
    8000445c:	6942                	ld	s2,16(sp)
    8000445e:	6145                	addi	sp,sp,48
    80004460:	8082                	ret
    return -1;
    80004462:	557d                	li	a0,-1
    80004464:	bfcd                	j	80004456 <argfd+0x4c>
    80004466:	557d                	li	a0,-1
    80004468:	b7fd                	j	80004456 <argfd+0x4c>

000000008000446a <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000446a:	1101                	addi	sp,sp,-32
    8000446c:	ec06                	sd	ra,24(sp)
    8000446e:	e822                	sd	s0,16(sp)
    80004470:	e426                	sd	s1,8(sp)
    80004472:	1000                	addi	s0,sp,32
    80004474:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004476:	ffffd097          	auipc	ra,0xffffd
    8000447a:	a36080e7          	jalr	-1482(ra) # 80000eac <myproc>
    8000447e:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004480:	0d050793          	addi	a5,a0,208
    80004484:	4501                	li	a0,0
    80004486:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004488:	6398                	ld	a4,0(a5)
    8000448a:	cb19                	beqz	a4,800044a0 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    8000448c:	2505                	addiw	a0,a0,1
    8000448e:	07a1                	addi	a5,a5,8
    80004490:	fed51ce3          	bne	a0,a3,80004488 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004494:	557d                	li	a0,-1
}
    80004496:	60e2                	ld	ra,24(sp)
    80004498:	6442                	ld	s0,16(sp)
    8000449a:	64a2                	ld	s1,8(sp)
    8000449c:	6105                	addi	sp,sp,32
    8000449e:	8082                	ret
      p->ofile[fd] = f;
    800044a0:	01a50793          	addi	a5,a0,26
    800044a4:	078e                	slli	a5,a5,0x3
    800044a6:	963e                	add	a2,a2,a5
    800044a8:	e204                	sd	s1,0(a2)
      return fd;
    800044aa:	b7f5                	j	80004496 <fdalloc+0x2c>

00000000800044ac <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800044ac:	715d                	addi	sp,sp,-80
    800044ae:	e486                	sd	ra,72(sp)
    800044b0:	e0a2                	sd	s0,64(sp)
    800044b2:	fc26                	sd	s1,56(sp)
    800044b4:	f84a                	sd	s2,48(sp)
    800044b6:	f44e                	sd	s3,40(sp)
    800044b8:	f052                	sd	s4,32(sp)
    800044ba:	ec56                	sd	s5,24(sp)
    800044bc:	e85a                	sd	s6,16(sp)
    800044be:	0880                	addi	s0,sp,80
    800044c0:	8b2e                	mv	s6,a1
    800044c2:	89b2                	mv	s3,a2
    800044c4:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800044c6:	fb040593          	addi	a1,s0,-80
    800044ca:	fffff097          	auipc	ra,0xfffff
    800044ce:	e3e080e7          	jalr	-450(ra) # 80003308 <nameiparent>
    800044d2:	84aa                	mv	s1,a0
    800044d4:	14050f63          	beqz	a0,80004632 <create+0x186>
    return 0;

  ilock(dp);
    800044d8:	ffffe097          	auipc	ra,0xffffe
    800044dc:	666080e7          	jalr	1638(ra) # 80002b3e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800044e0:	4601                	li	a2,0
    800044e2:	fb040593          	addi	a1,s0,-80
    800044e6:	8526                	mv	a0,s1
    800044e8:	fffff097          	auipc	ra,0xfffff
    800044ec:	b3a080e7          	jalr	-1222(ra) # 80003022 <dirlookup>
    800044f0:	8aaa                	mv	s5,a0
    800044f2:	c931                	beqz	a0,80004546 <create+0x9a>
    iunlockput(dp);
    800044f4:	8526                	mv	a0,s1
    800044f6:	fffff097          	auipc	ra,0xfffff
    800044fa:	8aa080e7          	jalr	-1878(ra) # 80002da0 <iunlockput>
    ilock(ip);
    800044fe:	8556                	mv	a0,s5
    80004500:	ffffe097          	auipc	ra,0xffffe
    80004504:	63e080e7          	jalr	1598(ra) # 80002b3e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004508:	000b059b          	sext.w	a1,s6
    8000450c:	4789                	li	a5,2
    8000450e:	02f59563          	bne	a1,a5,80004538 <create+0x8c>
    80004512:	044ad783          	lhu	a5,68(s5) # fffffffffffff044 <end+0xffffffff7ffdd2b4>
    80004516:	37f9                	addiw	a5,a5,-2
    80004518:	17c2                	slli	a5,a5,0x30
    8000451a:	93c1                	srli	a5,a5,0x30
    8000451c:	4705                	li	a4,1
    8000451e:	00f76d63          	bltu	a4,a5,80004538 <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004522:	8556                	mv	a0,s5
    80004524:	60a6                	ld	ra,72(sp)
    80004526:	6406                	ld	s0,64(sp)
    80004528:	74e2                	ld	s1,56(sp)
    8000452a:	7942                	ld	s2,48(sp)
    8000452c:	79a2                	ld	s3,40(sp)
    8000452e:	7a02                	ld	s4,32(sp)
    80004530:	6ae2                	ld	s5,24(sp)
    80004532:	6b42                	ld	s6,16(sp)
    80004534:	6161                	addi	sp,sp,80
    80004536:	8082                	ret
    iunlockput(ip);
    80004538:	8556                	mv	a0,s5
    8000453a:	fffff097          	auipc	ra,0xfffff
    8000453e:	866080e7          	jalr	-1946(ra) # 80002da0 <iunlockput>
    return 0;
    80004542:	4a81                	li	s5,0
    80004544:	bff9                	j	80004522 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    80004546:	85da                	mv	a1,s6
    80004548:	4088                	lw	a0,0(s1)
    8000454a:	ffffe097          	auipc	ra,0xffffe
    8000454e:	456080e7          	jalr	1110(ra) # 800029a0 <ialloc>
    80004552:	8a2a                	mv	s4,a0
    80004554:	c539                	beqz	a0,800045a2 <create+0xf6>
  ilock(ip);
    80004556:	ffffe097          	auipc	ra,0xffffe
    8000455a:	5e8080e7          	jalr	1512(ra) # 80002b3e <ilock>
  ip->major = major;
    8000455e:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80004562:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80004566:	4905                	li	s2,1
    80004568:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    8000456c:	8552                	mv	a0,s4
    8000456e:	ffffe097          	auipc	ra,0xffffe
    80004572:	504080e7          	jalr	1284(ra) # 80002a72 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004576:	000b059b          	sext.w	a1,s6
    8000457a:	03258b63          	beq	a1,s2,800045b0 <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
    8000457e:	004a2603          	lw	a2,4(s4)
    80004582:	fb040593          	addi	a1,s0,-80
    80004586:	8526                	mv	a0,s1
    80004588:	fffff097          	auipc	ra,0xfffff
    8000458c:	cb0080e7          	jalr	-848(ra) # 80003238 <dirlink>
    80004590:	06054f63          	bltz	a0,8000460e <create+0x162>
  iunlockput(dp);
    80004594:	8526                	mv	a0,s1
    80004596:	fffff097          	auipc	ra,0xfffff
    8000459a:	80a080e7          	jalr	-2038(ra) # 80002da0 <iunlockput>
  return ip;
    8000459e:	8ad2                	mv	s5,s4
    800045a0:	b749                	j	80004522 <create+0x76>
    iunlockput(dp);
    800045a2:	8526                	mv	a0,s1
    800045a4:	ffffe097          	auipc	ra,0xffffe
    800045a8:	7fc080e7          	jalr	2044(ra) # 80002da0 <iunlockput>
    return 0;
    800045ac:	8ad2                	mv	s5,s4
    800045ae:	bf95                	j	80004522 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800045b0:	004a2603          	lw	a2,4(s4)
    800045b4:	00004597          	auipc	a1,0x4
    800045b8:	0fc58593          	addi	a1,a1,252 # 800086b0 <syscalls+0x2a0>
    800045bc:	8552                	mv	a0,s4
    800045be:	fffff097          	auipc	ra,0xfffff
    800045c2:	c7a080e7          	jalr	-902(ra) # 80003238 <dirlink>
    800045c6:	04054463          	bltz	a0,8000460e <create+0x162>
    800045ca:	40d0                	lw	a2,4(s1)
    800045cc:	00004597          	auipc	a1,0x4
    800045d0:	0ec58593          	addi	a1,a1,236 # 800086b8 <syscalls+0x2a8>
    800045d4:	8552                	mv	a0,s4
    800045d6:	fffff097          	auipc	ra,0xfffff
    800045da:	c62080e7          	jalr	-926(ra) # 80003238 <dirlink>
    800045de:	02054863          	bltz	a0,8000460e <create+0x162>
  if(dirlink(dp, name, ip->inum) < 0)
    800045e2:	004a2603          	lw	a2,4(s4)
    800045e6:	fb040593          	addi	a1,s0,-80
    800045ea:	8526                	mv	a0,s1
    800045ec:	fffff097          	auipc	ra,0xfffff
    800045f0:	c4c080e7          	jalr	-948(ra) # 80003238 <dirlink>
    800045f4:	00054d63          	bltz	a0,8000460e <create+0x162>
    dp->nlink++;  // for ".."
    800045f8:	04a4d783          	lhu	a5,74(s1)
    800045fc:	2785                	addiw	a5,a5,1
    800045fe:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004602:	8526                	mv	a0,s1
    80004604:	ffffe097          	auipc	ra,0xffffe
    80004608:	46e080e7          	jalr	1134(ra) # 80002a72 <iupdate>
    8000460c:	b761                	j	80004594 <create+0xe8>
  ip->nlink = 0;
    8000460e:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004612:	8552                	mv	a0,s4
    80004614:	ffffe097          	auipc	ra,0xffffe
    80004618:	45e080e7          	jalr	1118(ra) # 80002a72 <iupdate>
  iunlockput(ip);
    8000461c:	8552                	mv	a0,s4
    8000461e:	ffffe097          	auipc	ra,0xffffe
    80004622:	782080e7          	jalr	1922(ra) # 80002da0 <iunlockput>
  iunlockput(dp);
    80004626:	8526                	mv	a0,s1
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	778080e7          	jalr	1912(ra) # 80002da0 <iunlockput>
  return 0;
    80004630:	bdcd                	j	80004522 <create+0x76>
    return 0;
    80004632:	8aaa                	mv	s5,a0
    80004634:	b5fd                	j	80004522 <create+0x76>

0000000080004636 <sys_dup>:
{
    80004636:	7179                	addi	sp,sp,-48
    80004638:	f406                	sd	ra,40(sp)
    8000463a:	f022                	sd	s0,32(sp)
    8000463c:	ec26                	sd	s1,24(sp)
    8000463e:	e84a                	sd	s2,16(sp)
    80004640:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004642:	fd840613          	addi	a2,s0,-40
    80004646:	4581                	li	a1,0
    80004648:	4501                	li	a0,0
    8000464a:	00000097          	auipc	ra,0x0
    8000464e:	dc0080e7          	jalr	-576(ra) # 8000440a <argfd>
    return -1;
    80004652:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004654:	02054363          	bltz	a0,8000467a <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    80004658:	fd843903          	ld	s2,-40(s0)
    8000465c:	854a                	mv	a0,s2
    8000465e:	00000097          	auipc	ra,0x0
    80004662:	e0c080e7          	jalr	-500(ra) # 8000446a <fdalloc>
    80004666:	84aa                	mv	s1,a0
    return -1;
    80004668:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000466a:	00054863          	bltz	a0,8000467a <sys_dup+0x44>
  filedup(f);
    8000466e:	854a                	mv	a0,s2
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	310080e7          	jalr	784(ra) # 80003980 <filedup>
  return fd;
    80004678:	87a6                	mv	a5,s1
}
    8000467a:	853e                	mv	a0,a5
    8000467c:	70a2                	ld	ra,40(sp)
    8000467e:	7402                	ld	s0,32(sp)
    80004680:	64e2                	ld	s1,24(sp)
    80004682:	6942                	ld	s2,16(sp)
    80004684:	6145                	addi	sp,sp,48
    80004686:	8082                	ret

0000000080004688 <sys_read>:
{
    80004688:	7179                	addi	sp,sp,-48
    8000468a:	f406                	sd	ra,40(sp)
    8000468c:	f022                	sd	s0,32(sp)
    8000468e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004690:	fd840593          	addi	a1,s0,-40
    80004694:	4505                	li	a0,1
    80004696:	ffffe097          	auipc	ra,0xffffe
    8000469a:	950080e7          	jalr	-1712(ra) # 80001fe6 <argaddr>
  argint(2, &n);
    8000469e:	fe440593          	addi	a1,s0,-28
    800046a2:	4509                	li	a0,2
    800046a4:	ffffe097          	auipc	ra,0xffffe
    800046a8:	922080e7          	jalr	-1758(ra) # 80001fc6 <argint>
  if(argfd(0, 0, &f) < 0)
    800046ac:	fe840613          	addi	a2,s0,-24
    800046b0:	4581                	li	a1,0
    800046b2:	4501                	li	a0,0
    800046b4:	00000097          	auipc	ra,0x0
    800046b8:	d56080e7          	jalr	-682(ra) # 8000440a <argfd>
    800046bc:	87aa                	mv	a5,a0
    return -1;
    800046be:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800046c0:	0007cc63          	bltz	a5,800046d8 <sys_read+0x50>
  return fileread(f, p, n);
    800046c4:	fe442603          	lw	a2,-28(s0)
    800046c8:	fd843583          	ld	a1,-40(s0)
    800046cc:	fe843503          	ld	a0,-24(s0)
    800046d0:	fffff097          	auipc	ra,0xfffff
    800046d4:	43c080e7          	jalr	1084(ra) # 80003b0c <fileread>
}
    800046d8:	70a2                	ld	ra,40(sp)
    800046da:	7402                	ld	s0,32(sp)
    800046dc:	6145                	addi	sp,sp,48
    800046de:	8082                	ret

00000000800046e0 <sys_write>:
{
    800046e0:	7179                	addi	sp,sp,-48
    800046e2:	f406                	sd	ra,40(sp)
    800046e4:	f022                	sd	s0,32(sp)
    800046e6:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800046e8:	fd840593          	addi	a1,s0,-40
    800046ec:	4505                	li	a0,1
    800046ee:	ffffe097          	auipc	ra,0xffffe
    800046f2:	8f8080e7          	jalr	-1800(ra) # 80001fe6 <argaddr>
  argint(2, &n);
    800046f6:	fe440593          	addi	a1,s0,-28
    800046fa:	4509                	li	a0,2
    800046fc:	ffffe097          	auipc	ra,0xffffe
    80004700:	8ca080e7          	jalr	-1846(ra) # 80001fc6 <argint>
  if(argfd(0, 0, &f) < 0)
    80004704:	fe840613          	addi	a2,s0,-24
    80004708:	4581                	li	a1,0
    8000470a:	4501                	li	a0,0
    8000470c:	00000097          	auipc	ra,0x0
    80004710:	cfe080e7          	jalr	-770(ra) # 8000440a <argfd>
    80004714:	87aa                	mv	a5,a0
    return -1;
    80004716:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004718:	0007cc63          	bltz	a5,80004730 <sys_write+0x50>
  return filewrite(f, p, n);
    8000471c:	fe442603          	lw	a2,-28(s0)
    80004720:	fd843583          	ld	a1,-40(s0)
    80004724:	fe843503          	ld	a0,-24(s0)
    80004728:	fffff097          	auipc	ra,0xfffff
    8000472c:	4a6080e7          	jalr	1190(ra) # 80003bce <filewrite>
}
    80004730:	70a2                	ld	ra,40(sp)
    80004732:	7402                	ld	s0,32(sp)
    80004734:	6145                	addi	sp,sp,48
    80004736:	8082                	ret

0000000080004738 <sys_close>:
{
    80004738:	1101                	addi	sp,sp,-32
    8000473a:	ec06                	sd	ra,24(sp)
    8000473c:	e822                	sd	s0,16(sp)
    8000473e:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004740:	fe040613          	addi	a2,s0,-32
    80004744:	fec40593          	addi	a1,s0,-20
    80004748:	4501                	li	a0,0
    8000474a:	00000097          	auipc	ra,0x0
    8000474e:	cc0080e7          	jalr	-832(ra) # 8000440a <argfd>
    return -1;
    80004752:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004754:	02054463          	bltz	a0,8000477c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004758:	ffffc097          	auipc	ra,0xffffc
    8000475c:	754080e7          	jalr	1876(ra) # 80000eac <myproc>
    80004760:	fec42783          	lw	a5,-20(s0)
    80004764:	07e9                	addi	a5,a5,26
    80004766:	078e                	slli	a5,a5,0x3
    80004768:	953e                	add	a0,a0,a5
    8000476a:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000476e:	fe043503          	ld	a0,-32(s0)
    80004772:	fffff097          	auipc	ra,0xfffff
    80004776:	260080e7          	jalr	608(ra) # 800039d2 <fileclose>
  return 0;
    8000477a:	4781                	li	a5,0
}
    8000477c:	853e                	mv	a0,a5
    8000477e:	60e2                	ld	ra,24(sp)
    80004780:	6442                	ld	s0,16(sp)
    80004782:	6105                	addi	sp,sp,32
    80004784:	8082                	ret

0000000080004786 <sys_fstat>:
{
    80004786:	1101                	addi	sp,sp,-32
    80004788:	ec06                	sd	ra,24(sp)
    8000478a:	e822                	sd	s0,16(sp)
    8000478c:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000478e:	fe040593          	addi	a1,s0,-32
    80004792:	4505                	li	a0,1
    80004794:	ffffe097          	auipc	ra,0xffffe
    80004798:	852080e7          	jalr	-1966(ra) # 80001fe6 <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000479c:	fe840613          	addi	a2,s0,-24
    800047a0:	4581                	li	a1,0
    800047a2:	4501                	li	a0,0
    800047a4:	00000097          	auipc	ra,0x0
    800047a8:	c66080e7          	jalr	-922(ra) # 8000440a <argfd>
    800047ac:	87aa                	mv	a5,a0
    return -1;
    800047ae:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800047b0:	0007ca63          	bltz	a5,800047c4 <sys_fstat+0x3e>
  return filestat(f, st);
    800047b4:	fe043583          	ld	a1,-32(s0)
    800047b8:	fe843503          	ld	a0,-24(s0)
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	2de080e7          	jalr	734(ra) # 80003a9a <filestat>
}
    800047c4:	60e2                	ld	ra,24(sp)
    800047c6:	6442                	ld	s0,16(sp)
    800047c8:	6105                	addi	sp,sp,32
    800047ca:	8082                	ret

00000000800047cc <sys_link>:
{
    800047cc:	7169                	addi	sp,sp,-304
    800047ce:	f606                	sd	ra,296(sp)
    800047d0:	f222                	sd	s0,288(sp)
    800047d2:	ee26                	sd	s1,280(sp)
    800047d4:	ea4a                	sd	s2,272(sp)
    800047d6:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800047d8:	08000613          	li	a2,128
    800047dc:	ed040593          	addi	a1,s0,-304
    800047e0:	4501                	li	a0,0
    800047e2:	ffffe097          	auipc	ra,0xffffe
    800047e6:	824080e7          	jalr	-2012(ra) # 80002006 <argstr>
    return -1;
    800047ea:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800047ec:	10054e63          	bltz	a0,80004908 <sys_link+0x13c>
    800047f0:	08000613          	li	a2,128
    800047f4:	f5040593          	addi	a1,s0,-176
    800047f8:	4505                	li	a0,1
    800047fa:	ffffe097          	auipc	ra,0xffffe
    800047fe:	80c080e7          	jalr	-2036(ra) # 80002006 <argstr>
    return -1;
    80004802:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004804:	10054263          	bltz	a0,80004908 <sys_link+0x13c>
  begin_op();
    80004808:	fffff097          	auipc	ra,0xfffff
    8000480c:	d02080e7          	jalr	-766(ra) # 8000350a <begin_op>
  if((ip = namei(old)) == 0){
    80004810:	ed040513          	addi	a0,s0,-304
    80004814:	fffff097          	auipc	ra,0xfffff
    80004818:	ad6080e7          	jalr	-1322(ra) # 800032ea <namei>
    8000481c:	84aa                	mv	s1,a0
    8000481e:	c551                	beqz	a0,800048aa <sys_link+0xde>
  ilock(ip);
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	31e080e7          	jalr	798(ra) # 80002b3e <ilock>
  if(ip->type == T_DIR){
    80004828:	04449703          	lh	a4,68(s1)
    8000482c:	4785                	li	a5,1
    8000482e:	08f70463          	beq	a4,a5,800048b6 <sys_link+0xea>
  ip->nlink++;
    80004832:	04a4d783          	lhu	a5,74(s1)
    80004836:	2785                	addiw	a5,a5,1
    80004838:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000483c:	8526                	mv	a0,s1
    8000483e:	ffffe097          	auipc	ra,0xffffe
    80004842:	234080e7          	jalr	564(ra) # 80002a72 <iupdate>
  iunlock(ip);
    80004846:	8526                	mv	a0,s1
    80004848:	ffffe097          	auipc	ra,0xffffe
    8000484c:	3b8080e7          	jalr	952(ra) # 80002c00 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004850:	fd040593          	addi	a1,s0,-48
    80004854:	f5040513          	addi	a0,s0,-176
    80004858:	fffff097          	auipc	ra,0xfffff
    8000485c:	ab0080e7          	jalr	-1360(ra) # 80003308 <nameiparent>
    80004860:	892a                	mv	s2,a0
    80004862:	c935                	beqz	a0,800048d6 <sys_link+0x10a>
  ilock(dp);
    80004864:	ffffe097          	auipc	ra,0xffffe
    80004868:	2da080e7          	jalr	730(ra) # 80002b3e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000486c:	00092703          	lw	a4,0(s2)
    80004870:	409c                	lw	a5,0(s1)
    80004872:	04f71d63          	bne	a4,a5,800048cc <sys_link+0x100>
    80004876:	40d0                	lw	a2,4(s1)
    80004878:	fd040593          	addi	a1,s0,-48
    8000487c:	854a                	mv	a0,s2
    8000487e:	fffff097          	auipc	ra,0xfffff
    80004882:	9ba080e7          	jalr	-1606(ra) # 80003238 <dirlink>
    80004886:	04054363          	bltz	a0,800048cc <sys_link+0x100>
  iunlockput(dp);
    8000488a:	854a                	mv	a0,s2
    8000488c:	ffffe097          	auipc	ra,0xffffe
    80004890:	514080e7          	jalr	1300(ra) # 80002da0 <iunlockput>
  iput(ip);
    80004894:	8526                	mv	a0,s1
    80004896:	ffffe097          	auipc	ra,0xffffe
    8000489a:	462080e7          	jalr	1122(ra) # 80002cf8 <iput>
  end_op();
    8000489e:	fffff097          	auipc	ra,0xfffff
    800048a2:	cea080e7          	jalr	-790(ra) # 80003588 <end_op>
  return 0;
    800048a6:	4781                	li	a5,0
    800048a8:	a085                	j	80004908 <sys_link+0x13c>
    end_op();
    800048aa:	fffff097          	auipc	ra,0xfffff
    800048ae:	cde080e7          	jalr	-802(ra) # 80003588 <end_op>
    return -1;
    800048b2:	57fd                	li	a5,-1
    800048b4:	a891                	j	80004908 <sys_link+0x13c>
    iunlockput(ip);
    800048b6:	8526                	mv	a0,s1
    800048b8:	ffffe097          	auipc	ra,0xffffe
    800048bc:	4e8080e7          	jalr	1256(ra) # 80002da0 <iunlockput>
    end_op();
    800048c0:	fffff097          	auipc	ra,0xfffff
    800048c4:	cc8080e7          	jalr	-824(ra) # 80003588 <end_op>
    return -1;
    800048c8:	57fd                	li	a5,-1
    800048ca:	a83d                	j	80004908 <sys_link+0x13c>
    iunlockput(dp);
    800048cc:	854a                	mv	a0,s2
    800048ce:	ffffe097          	auipc	ra,0xffffe
    800048d2:	4d2080e7          	jalr	1234(ra) # 80002da0 <iunlockput>
  ilock(ip);
    800048d6:	8526                	mv	a0,s1
    800048d8:	ffffe097          	auipc	ra,0xffffe
    800048dc:	266080e7          	jalr	614(ra) # 80002b3e <ilock>
  ip->nlink--;
    800048e0:	04a4d783          	lhu	a5,74(s1)
    800048e4:	37fd                	addiw	a5,a5,-1
    800048e6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800048ea:	8526                	mv	a0,s1
    800048ec:	ffffe097          	auipc	ra,0xffffe
    800048f0:	186080e7          	jalr	390(ra) # 80002a72 <iupdate>
  iunlockput(ip);
    800048f4:	8526                	mv	a0,s1
    800048f6:	ffffe097          	auipc	ra,0xffffe
    800048fa:	4aa080e7          	jalr	1194(ra) # 80002da0 <iunlockput>
  end_op();
    800048fe:	fffff097          	auipc	ra,0xfffff
    80004902:	c8a080e7          	jalr	-886(ra) # 80003588 <end_op>
  return -1;
    80004906:	57fd                	li	a5,-1
}
    80004908:	853e                	mv	a0,a5
    8000490a:	70b2                	ld	ra,296(sp)
    8000490c:	7412                	ld	s0,288(sp)
    8000490e:	64f2                	ld	s1,280(sp)
    80004910:	6952                	ld	s2,272(sp)
    80004912:	6155                	addi	sp,sp,304
    80004914:	8082                	ret

0000000080004916 <sys_unlink>:
{
    80004916:	7151                	addi	sp,sp,-240
    80004918:	f586                	sd	ra,232(sp)
    8000491a:	f1a2                	sd	s0,224(sp)
    8000491c:	eda6                	sd	s1,216(sp)
    8000491e:	e9ca                	sd	s2,208(sp)
    80004920:	e5ce                	sd	s3,200(sp)
    80004922:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004924:	08000613          	li	a2,128
    80004928:	f3040593          	addi	a1,s0,-208
    8000492c:	4501                	li	a0,0
    8000492e:	ffffd097          	auipc	ra,0xffffd
    80004932:	6d8080e7          	jalr	1752(ra) # 80002006 <argstr>
    80004936:	18054163          	bltz	a0,80004ab8 <sys_unlink+0x1a2>
  begin_op();
    8000493a:	fffff097          	auipc	ra,0xfffff
    8000493e:	bd0080e7          	jalr	-1072(ra) # 8000350a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004942:	fb040593          	addi	a1,s0,-80
    80004946:	f3040513          	addi	a0,s0,-208
    8000494a:	fffff097          	auipc	ra,0xfffff
    8000494e:	9be080e7          	jalr	-1602(ra) # 80003308 <nameiparent>
    80004952:	84aa                	mv	s1,a0
    80004954:	c979                	beqz	a0,80004a2a <sys_unlink+0x114>
  ilock(dp);
    80004956:	ffffe097          	auipc	ra,0xffffe
    8000495a:	1e8080e7          	jalr	488(ra) # 80002b3e <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000495e:	00004597          	auipc	a1,0x4
    80004962:	d5258593          	addi	a1,a1,-686 # 800086b0 <syscalls+0x2a0>
    80004966:	fb040513          	addi	a0,s0,-80
    8000496a:	ffffe097          	auipc	ra,0xffffe
    8000496e:	69e080e7          	jalr	1694(ra) # 80003008 <namecmp>
    80004972:	14050a63          	beqz	a0,80004ac6 <sys_unlink+0x1b0>
    80004976:	00004597          	auipc	a1,0x4
    8000497a:	d4258593          	addi	a1,a1,-702 # 800086b8 <syscalls+0x2a8>
    8000497e:	fb040513          	addi	a0,s0,-80
    80004982:	ffffe097          	auipc	ra,0xffffe
    80004986:	686080e7          	jalr	1670(ra) # 80003008 <namecmp>
    8000498a:	12050e63          	beqz	a0,80004ac6 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000498e:	f2c40613          	addi	a2,s0,-212
    80004992:	fb040593          	addi	a1,s0,-80
    80004996:	8526                	mv	a0,s1
    80004998:	ffffe097          	auipc	ra,0xffffe
    8000499c:	68a080e7          	jalr	1674(ra) # 80003022 <dirlookup>
    800049a0:	892a                	mv	s2,a0
    800049a2:	12050263          	beqz	a0,80004ac6 <sys_unlink+0x1b0>
  ilock(ip);
    800049a6:	ffffe097          	auipc	ra,0xffffe
    800049aa:	198080e7          	jalr	408(ra) # 80002b3e <ilock>
  if(ip->nlink < 1)
    800049ae:	04a91783          	lh	a5,74(s2)
    800049b2:	08f05263          	blez	a5,80004a36 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800049b6:	04491703          	lh	a4,68(s2)
    800049ba:	4785                	li	a5,1
    800049bc:	08f70563          	beq	a4,a5,80004a46 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    800049c0:	4641                	li	a2,16
    800049c2:	4581                	li	a1,0
    800049c4:	fc040513          	addi	a0,s0,-64
    800049c8:	ffffb097          	auipc	ra,0xffffb
    800049cc:	7b2080e7          	jalr	1970(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800049d0:	4741                	li	a4,16
    800049d2:	f2c42683          	lw	a3,-212(s0)
    800049d6:	fc040613          	addi	a2,s0,-64
    800049da:	4581                	li	a1,0
    800049dc:	8526                	mv	a0,s1
    800049de:	ffffe097          	auipc	ra,0xffffe
    800049e2:	50c080e7          	jalr	1292(ra) # 80002eea <writei>
    800049e6:	47c1                	li	a5,16
    800049e8:	0af51563          	bne	a0,a5,80004a92 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800049ec:	04491703          	lh	a4,68(s2)
    800049f0:	4785                	li	a5,1
    800049f2:	0af70863          	beq	a4,a5,80004aa2 <sys_unlink+0x18c>
  iunlockput(dp);
    800049f6:	8526                	mv	a0,s1
    800049f8:	ffffe097          	auipc	ra,0xffffe
    800049fc:	3a8080e7          	jalr	936(ra) # 80002da0 <iunlockput>
  ip->nlink--;
    80004a00:	04a95783          	lhu	a5,74(s2)
    80004a04:	37fd                	addiw	a5,a5,-1
    80004a06:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004a0a:	854a                	mv	a0,s2
    80004a0c:	ffffe097          	auipc	ra,0xffffe
    80004a10:	066080e7          	jalr	102(ra) # 80002a72 <iupdate>
  iunlockput(ip);
    80004a14:	854a                	mv	a0,s2
    80004a16:	ffffe097          	auipc	ra,0xffffe
    80004a1a:	38a080e7          	jalr	906(ra) # 80002da0 <iunlockput>
  end_op();
    80004a1e:	fffff097          	auipc	ra,0xfffff
    80004a22:	b6a080e7          	jalr	-1174(ra) # 80003588 <end_op>
  return 0;
    80004a26:	4501                	li	a0,0
    80004a28:	a84d                	j	80004ada <sys_unlink+0x1c4>
    end_op();
    80004a2a:	fffff097          	auipc	ra,0xfffff
    80004a2e:	b5e080e7          	jalr	-1186(ra) # 80003588 <end_op>
    return -1;
    80004a32:	557d                	li	a0,-1
    80004a34:	a05d                	j	80004ada <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004a36:	00004517          	auipc	a0,0x4
    80004a3a:	c8a50513          	addi	a0,a0,-886 # 800086c0 <syscalls+0x2b0>
    80004a3e:	00001097          	auipc	ra,0x1
    80004a42:	1ae080e7          	jalr	430(ra) # 80005bec <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004a46:	04c92703          	lw	a4,76(s2)
    80004a4a:	02000793          	li	a5,32
    80004a4e:	f6e7f9e3          	bgeu	a5,a4,800049c0 <sys_unlink+0xaa>
    80004a52:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a56:	4741                	li	a4,16
    80004a58:	86ce                	mv	a3,s3
    80004a5a:	f1840613          	addi	a2,s0,-232
    80004a5e:	4581                	li	a1,0
    80004a60:	854a                	mv	a0,s2
    80004a62:	ffffe097          	auipc	ra,0xffffe
    80004a66:	390080e7          	jalr	912(ra) # 80002df2 <readi>
    80004a6a:	47c1                	li	a5,16
    80004a6c:	00f51b63          	bne	a0,a5,80004a82 <sys_unlink+0x16c>
    if(de.inum != 0)
    80004a70:	f1845783          	lhu	a5,-232(s0)
    80004a74:	e7a1                	bnez	a5,80004abc <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004a76:	29c1                	addiw	s3,s3,16
    80004a78:	04c92783          	lw	a5,76(s2)
    80004a7c:	fcf9ede3          	bltu	s3,a5,80004a56 <sys_unlink+0x140>
    80004a80:	b781                	j	800049c0 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004a82:	00004517          	auipc	a0,0x4
    80004a86:	c5650513          	addi	a0,a0,-938 # 800086d8 <syscalls+0x2c8>
    80004a8a:	00001097          	auipc	ra,0x1
    80004a8e:	162080e7          	jalr	354(ra) # 80005bec <panic>
    panic("unlink: writei");
    80004a92:	00004517          	auipc	a0,0x4
    80004a96:	c5e50513          	addi	a0,a0,-930 # 800086f0 <syscalls+0x2e0>
    80004a9a:	00001097          	auipc	ra,0x1
    80004a9e:	152080e7          	jalr	338(ra) # 80005bec <panic>
    dp->nlink--;
    80004aa2:	04a4d783          	lhu	a5,74(s1)
    80004aa6:	37fd                	addiw	a5,a5,-1
    80004aa8:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004aac:	8526                	mv	a0,s1
    80004aae:	ffffe097          	auipc	ra,0xffffe
    80004ab2:	fc4080e7          	jalr	-60(ra) # 80002a72 <iupdate>
    80004ab6:	b781                	j	800049f6 <sys_unlink+0xe0>
    return -1;
    80004ab8:	557d                	li	a0,-1
    80004aba:	a005                	j	80004ada <sys_unlink+0x1c4>
    iunlockput(ip);
    80004abc:	854a                	mv	a0,s2
    80004abe:	ffffe097          	auipc	ra,0xffffe
    80004ac2:	2e2080e7          	jalr	738(ra) # 80002da0 <iunlockput>
  iunlockput(dp);
    80004ac6:	8526                	mv	a0,s1
    80004ac8:	ffffe097          	auipc	ra,0xffffe
    80004acc:	2d8080e7          	jalr	728(ra) # 80002da0 <iunlockput>
  end_op();
    80004ad0:	fffff097          	auipc	ra,0xfffff
    80004ad4:	ab8080e7          	jalr	-1352(ra) # 80003588 <end_op>
  return -1;
    80004ad8:	557d                	li	a0,-1
}
    80004ada:	70ae                	ld	ra,232(sp)
    80004adc:	740e                	ld	s0,224(sp)
    80004ade:	64ee                	ld	s1,216(sp)
    80004ae0:	694e                	ld	s2,208(sp)
    80004ae2:	69ae                	ld	s3,200(sp)
    80004ae4:	616d                	addi	sp,sp,240
    80004ae6:	8082                	ret

0000000080004ae8 <sys_open>:

uint64
sys_open(void)
{
    80004ae8:	7131                	addi	sp,sp,-192
    80004aea:	fd06                	sd	ra,184(sp)
    80004aec:	f922                	sd	s0,176(sp)
    80004aee:	f526                	sd	s1,168(sp)
    80004af0:	f14a                	sd	s2,160(sp)
    80004af2:	ed4e                	sd	s3,152(sp)
    80004af4:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004af6:	f4c40593          	addi	a1,s0,-180
    80004afa:	4505                	li	a0,1
    80004afc:	ffffd097          	auipc	ra,0xffffd
    80004b00:	4ca080e7          	jalr	1226(ra) # 80001fc6 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004b04:	08000613          	li	a2,128
    80004b08:	f5040593          	addi	a1,s0,-176
    80004b0c:	4501                	li	a0,0
    80004b0e:	ffffd097          	auipc	ra,0xffffd
    80004b12:	4f8080e7          	jalr	1272(ra) # 80002006 <argstr>
    80004b16:	87aa                	mv	a5,a0
    return -1;
    80004b18:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004b1a:	0a07c963          	bltz	a5,80004bcc <sys_open+0xe4>

  begin_op();
    80004b1e:	fffff097          	auipc	ra,0xfffff
    80004b22:	9ec080e7          	jalr	-1556(ra) # 8000350a <begin_op>

  if(omode & O_CREATE){
    80004b26:	f4c42783          	lw	a5,-180(s0)
    80004b2a:	2007f793          	andi	a5,a5,512
    80004b2e:	cfc5                	beqz	a5,80004be6 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004b30:	4681                	li	a3,0
    80004b32:	4601                	li	a2,0
    80004b34:	4589                	li	a1,2
    80004b36:	f5040513          	addi	a0,s0,-176
    80004b3a:	00000097          	auipc	ra,0x0
    80004b3e:	972080e7          	jalr	-1678(ra) # 800044ac <create>
    80004b42:	84aa                	mv	s1,a0
    if(ip == 0){
    80004b44:	c959                	beqz	a0,80004bda <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004b46:	04449703          	lh	a4,68(s1)
    80004b4a:	478d                	li	a5,3
    80004b4c:	00f71763          	bne	a4,a5,80004b5a <sys_open+0x72>
    80004b50:	0464d703          	lhu	a4,70(s1)
    80004b54:	47a5                	li	a5,9
    80004b56:	0ce7ed63          	bltu	a5,a4,80004c30 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004b5a:	fffff097          	auipc	ra,0xfffff
    80004b5e:	dbc080e7          	jalr	-580(ra) # 80003916 <filealloc>
    80004b62:	89aa                	mv	s3,a0
    80004b64:	10050363          	beqz	a0,80004c6a <sys_open+0x182>
    80004b68:	00000097          	auipc	ra,0x0
    80004b6c:	902080e7          	jalr	-1790(ra) # 8000446a <fdalloc>
    80004b70:	892a                	mv	s2,a0
    80004b72:	0e054763          	bltz	a0,80004c60 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004b76:	04449703          	lh	a4,68(s1)
    80004b7a:	478d                	li	a5,3
    80004b7c:	0cf70563          	beq	a4,a5,80004c46 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004b80:	4789                	li	a5,2
    80004b82:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004b86:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004b8a:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004b8e:	f4c42783          	lw	a5,-180(s0)
    80004b92:	0017c713          	xori	a4,a5,1
    80004b96:	8b05                	andi	a4,a4,1
    80004b98:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004b9c:	0037f713          	andi	a4,a5,3
    80004ba0:	00e03733          	snez	a4,a4
    80004ba4:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004ba8:	4007f793          	andi	a5,a5,1024
    80004bac:	c791                	beqz	a5,80004bb8 <sys_open+0xd0>
    80004bae:	04449703          	lh	a4,68(s1)
    80004bb2:	4789                	li	a5,2
    80004bb4:	0af70063          	beq	a4,a5,80004c54 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004bb8:	8526                	mv	a0,s1
    80004bba:	ffffe097          	auipc	ra,0xffffe
    80004bbe:	046080e7          	jalr	70(ra) # 80002c00 <iunlock>
  end_op();
    80004bc2:	fffff097          	auipc	ra,0xfffff
    80004bc6:	9c6080e7          	jalr	-1594(ra) # 80003588 <end_op>

  return fd;
    80004bca:	854a                	mv	a0,s2
}
    80004bcc:	70ea                	ld	ra,184(sp)
    80004bce:	744a                	ld	s0,176(sp)
    80004bd0:	74aa                	ld	s1,168(sp)
    80004bd2:	790a                	ld	s2,160(sp)
    80004bd4:	69ea                	ld	s3,152(sp)
    80004bd6:	6129                	addi	sp,sp,192
    80004bd8:	8082                	ret
      end_op();
    80004bda:	fffff097          	auipc	ra,0xfffff
    80004bde:	9ae080e7          	jalr	-1618(ra) # 80003588 <end_op>
      return -1;
    80004be2:	557d                	li	a0,-1
    80004be4:	b7e5                	j	80004bcc <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004be6:	f5040513          	addi	a0,s0,-176
    80004bea:	ffffe097          	auipc	ra,0xffffe
    80004bee:	700080e7          	jalr	1792(ra) # 800032ea <namei>
    80004bf2:	84aa                	mv	s1,a0
    80004bf4:	c905                	beqz	a0,80004c24 <sys_open+0x13c>
    ilock(ip);
    80004bf6:	ffffe097          	auipc	ra,0xffffe
    80004bfa:	f48080e7          	jalr	-184(ra) # 80002b3e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004bfe:	04449703          	lh	a4,68(s1)
    80004c02:	4785                	li	a5,1
    80004c04:	f4f711e3          	bne	a4,a5,80004b46 <sys_open+0x5e>
    80004c08:	f4c42783          	lw	a5,-180(s0)
    80004c0c:	d7b9                	beqz	a5,80004b5a <sys_open+0x72>
      iunlockput(ip);
    80004c0e:	8526                	mv	a0,s1
    80004c10:	ffffe097          	auipc	ra,0xffffe
    80004c14:	190080e7          	jalr	400(ra) # 80002da0 <iunlockput>
      end_op();
    80004c18:	fffff097          	auipc	ra,0xfffff
    80004c1c:	970080e7          	jalr	-1680(ra) # 80003588 <end_op>
      return -1;
    80004c20:	557d                	li	a0,-1
    80004c22:	b76d                	j	80004bcc <sys_open+0xe4>
      end_op();
    80004c24:	fffff097          	auipc	ra,0xfffff
    80004c28:	964080e7          	jalr	-1692(ra) # 80003588 <end_op>
      return -1;
    80004c2c:	557d                	li	a0,-1
    80004c2e:	bf79                	j	80004bcc <sys_open+0xe4>
    iunlockput(ip);
    80004c30:	8526                	mv	a0,s1
    80004c32:	ffffe097          	auipc	ra,0xffffe
    80004c36:	16e080e7          	jalr	366(ra) # 80002da0 <iunlockput>
    end_op();
    80004c3a:	fffff097          	auipc	ra,0xfffff
    80004c3e:	94e080e7          	jalr	-1714(ra) # 80003588 <end_op>
    return -1;
    80004c42:	557d                	li	a0,-1
    80004c44:	b761                	j	80004bcc <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004c46:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004c4a:	04649783          	lh	a5,70(s1)
    80004c4e:	02f99223          	sh	a5,36(s3)
    80004c52:	bf25                	j	80004b8a <sys_open+0xa2>
    itrunc(ip);
    80004c54:	8526                	mv	a0,s1
    80004c56:	ffffe097          	auipc	ra,0xffffe
    80004c5a:	ff6080e7          	jalr	-10(ra) # 80002c4c <itrunc>
    80004c5e:	bfa9                	j	80004bb8 <sys_open+0xd0>
      fileclose(f);
    80004c60:	854e                	mv	a0,s3
    80004c62:	fffff097          	auipc	ra,0xfffff
    80004c66:	d70080e7          	jalr	-656(ra) # 800039d2 <fileclose>
    iunlockput(ip);
    80004c6a:	8526                	mv	a0,s1
    80004c6c:	ffffe097          	auipc	ra,0xffffe
    80004c70:	134080e7          	jalr	308(ra) # 80002da0 <iunlockput>
    end_op();
    80004c74:	fffff097          	auipc	ra,0xfffff
    80004c78:	914080e7          	jalr	-1772(ra) # 80003588 <end_op>
    return -1;
    80004c7c:	557d                	li	a0,-1
    80004c7e:	b7b9                	j	80004bcc <sys_open+0xe4>

0000000080004c80 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004c80:	7175                	addi	sp,sp,-144
    80004c82:	e506                	sd	ra,136(sp)
    80004c84:	e122                	sd	s0,128(sp)
    80004c86:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004c88:	fffff097          	auipc	ra,0xfffff
    80004c8c:	882080e7          	jalr	-1918(ra) # 8000350a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004c90:	08000613          	li	a2,128
    80004c94:	f7040593          	addi	a1,s0,-144
    80004c98:	4501                	li	a0,0
    80004c9a:	ffffd097          	auipc	ra,0xffffd
    80004c9e:	36c080e7          	jalr	876(ra) # 80002006 <argstr>
    80004ca2:	02054963          	bltz	a0,80004cd4 <sys_mkdir+0x54>
    80004ca6:	4681                	li	a3,0
    80004ca8:	4601                	li	a2,0
    80004caa:	4585                	li	a1,1
    80004cac:	f7040513          	addi	a0,s0,-144
    80004cb0:	fffff097          	auipc	ra,0xfffff
    80004cb4:	7fc080e7          	jalr	2044(ra) # 800044ac <create>
    80004cb8:	cd11                	beqz	a0,80004cd4 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004cba:	ffffe097          	auipc	ra,0xffffe
    80004cbe:	0e6080e7          	jalr	230(ra) # 80002da0 <iunlockput>
  end_op();
    80004cc2:	fffff097          	auipc	ra,0xfffff
    80004cc6:	8c6080e7          	jalr	-1850(ra) # 80003588 <end_op>
  return 0;
    80004cca:	4501                	li	a0,0
}
    80004ccc:	60aa                	ld	ra,136(sp)
    80004cce:	640a                	ld	s0,128(sp)
    80004cd0:	6149                	addi	sp,sp,144
    80004cd2:	8082                	ret
    end_op();
    80004cd4:	fffff097          	auipc	ra,0xfffff
    80004cd8:	8b4080e7          	jalr	-1868(ra) # 80003588 <end_op>
    return -1;
    80004cdc:	557d                	li	a0,-1
    80004cde:	b7fd                	j	80004ccc <sys_mkdir+0x4c>

0000000080004ce0 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004ce0:	7135                	addi	sp,sp,-160
    80004ce2:	ed06                	sd	ra,152(sp)
    80004ce4:	e922                	sd	s0,144(sp)
    80004ce6:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	822080e7          	jalr	-2014(ra) # 8000350a <begin_op>
  argint(1, &major);
    80004cf0:	f6c40593          	addi	a1,s0,-148
    80004cf4:	4505                	li	a0,1
    80004cf6:	ffffd097          	auipc	ra,0xffffd
    80004cfa:	2d0080e7          	jalr	720(ra) # 80001fc6 <argint>
  argint(2, &minor);
    80004cfe:	f6840593          	addi	a1,s0,-152
    80004d02:	4509                	li	a0,2
    80004d04:	ffffd097          	auipc	ra,0xffffd
    80004d08:	2c2080e7          	jalr	706(ra) # 80001fc6 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004d0c:	08000613          	li	a2,128
    80004d10:	f7040593          	addi	a1,s0,-144
    80004d14:	4501                	li	a0,0
    80004d16:	ffffd097          	auipc	ra,0xffffd
    80004d1a:	2f0080e7          	jalr	752(ra) # 80002006 <argstr>
    80004d1e:	02054b63          	bltz	a0,80004d54 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004d22:	f6841683          	lh	a3,-152(s0)
    80004d26:	f6c41603          	lh	a2,-148(s0)
    80004d2a:	458d                	li	a1,3
    80004d2c:	f7040513          	addi	a0,s0,-144
    80004d30:	fffff097          	auipc	ra,0xfffff
    80004d34:	77c080e7          	jalr	1916(ra) # 800044ac <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004d38:	cd11                	beqz	a0,80004d54 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004d3a:	ffffe097          	auipc	ra,0xffffe
    80004d3e:	066080e7          	jalr	102(ra) # 80002da0 <iunlockput>
  end_op();
    80004d42:	fffff097          	auipc	ra,0xfffff
    80004d46:	846080e7          	jalr	-1978(ra) # 80003588 <end_op>
  return 0;
    80004d4a:	4501                	li	a0,0
}
    80004d4c:	60ea                	ld	ra,152(sp)
    80004d4e:	644a                	ld	s0,144(sp)
    80004d50:	610d                	addi	sp,sp,160
    80004d52:	8082                	ret
    end_op();
    80004d54:	fffff097          	auipc	ra,0xfffff
    80004d58:	834080e7          	jalr	-1996(ra) # 80003588 <end_op>
    return -1;
    80004d5c:	557d                	li	a0,-1
    80004d5e:	b7fd                	j	80004d4c <sys_mknod+0x6c>

0000000080004d60 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004d60:	7135                	addi	sp,sp,-160
    80004d62:	ed06                	sd	ra,152(sp)
    80004d64:	e922                	sd	s0,144(sp)
    80004d66:	e526                	sd	s1,136(sp)
    80004d68:	e14a                	sd	s2,128(sp)
    80004d6a:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004d6c:	ffffc097          	auipc	ra,0xffffc
    80004d70:	140080e7          	jalr	320(ra) # 80000eac <myproc>
    80004d74:	892a                	mv	s2,a0
  
  begin_op();
    80004d76:	ffffe097          	auipc	ra,0xffffe
    80004d7a:	794080e7          	jalr	1940(ra) # 8000350a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004d7e:	08000613          	li	a2,128
    80004d82:	f6040593          	addi	a1,s0,-160
    80004d86:	4501                	li	a0,0
    80004d88:	ffffd097          	auipc	ra,0xffffd
    80004d8c:	27e080e7          	jalr	638(ra) # 80002006 <argstr>
    80004d90:	04054b63          	bltz	a0,80004de6 <sys_chdir+0x86>
    80004d94:	f6040513          	addi	a0,s0,-160
    80004d98:	ffffe097          	auipc	ra,0xffffe
    80004d9c:	552080e7          	jalr	1362(ra) # 800032ea <namei>
    80004da0:	84aa                	mv	s1,a0
    80004da2:	c131                	beqz	a0,80004de6 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004da4:	ffffe097          	auipc	ra,0xffffe
    80004da8:	d9a080e7          	jalr	-614(ra) # 80002b3e <ilock>
  if(ip->type != T_DIR){
    80004dac:	04449703          	lh	a4,68(s1)
    80004db0:	4785                	li	a5,1
    80004db2:	04f71063          	bne	a4,a5,80004df2 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004db6:	8526                	mv	a0,s1
    80004db8:	ffffe097          	auipc	ra,0xffffe
    80004dbc:	e48080e7          	jalr	-440(ra) # 80002c00 <iunlock>
  iput(p->cwd);
    80004dc0:	15093503          	ld	a0,336(s2)
    80004dc4:	ffffe097          	auipc	ra,0xffffe
    80004dc8:	f34080e7          	jalr	-204(ra) # 80002cf8 <iput>
  end_op();
    80004dcc:	ffffe097          	auipc	ra,0xffffe
    80004dd0:	7bc080e7          	jalr	1980(ra) # 80003588 <end_op>
  p->cwd = ip;
    80004dd4:	14993823          	sd	s1,336(s2)
  return 0;
    80004dd8:	4501                	li	a0,0
}
    80004dda:	60ea                	ld	ra,152(sp)
    80004ddc:	644a                	ld	s0,144(sp)
    80004dde:	64aa                	ld	s1,136(sp)
    80004de0:	690a                	ld	s2,128(sp)
    80004de2:	610d                	addi	sp,sp,160
    80004de4:	8082                	ret
    end_op();
    80004de6:	ffffe097          	auipc	ra,0xffffe
    80004dea:	7a2080e7          	jalr	1954(ra) # 80003588 <end_op>
    return -1;
    80004dee:	557d                	li	a0,-1
    80004df0:	b7ed                	j	80004dda <sys_chdir+0x7a>
    iunlockput(ip);
    80004df2:	8526                	mv	a0,s1
    80004df4:	ffffe097          	auipc	ra,0xffffe
    80004df8:	fac080e7          	jalr	-84(ra) # 80002da0 <iunlockput>
    end_op();
    80004dfc:	ffffe097          	auipc	ra,0xffffe
    80004e00:	78c080e7          	jalr	1932(ra) # 80003588 <end_op>
    return -1;
    80004e04:	557d                	li	a0,-1
    80004e06:	bfd1                	j	80004dda <sys_chdir+0x7a>

0000000080004e08 <sys_exec>:

uint64
sys_exec(void)
{
    80004e08:	7145                	addi	sp,sp,-464
    80004e0a:	e786                	sd	ra,456(sp)
    80004e0c:	e3a2                	sd	s0,448(sp)
    80004e0e:	ff26                	sd	s1,440(sp)
    80004e10:	fb4a                	sd	s2,432(sp)
    80004e12:	f74e                	sd	s3,424(sp)
    80004e14:	f352                	sd	s4,416(sp)
    80004e16:	ef56                	sd	s5,408(sp)
    80004e18:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004e1a:	e3840593          	addi	a1,s0,-456
    80004e1e:	4505                	li	a0,1
    80004e20:	ffffd097          	auipc	ra,0xffffd
    80004e24:	1c6080e7          	jalr	454(ra) # 80001fe6 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004e28:	08000613          	li	a2,128
    80004e2c:	f4040593          	addi	a1,s0,-192
    80004e30:	4501                	li	a0,0
    80004e32:	ffffd097          	auipc	ra,0xffffd
    80004e36:	1d4080e7          	jalr	468(ra) # 80002006 <argstr>
    80004e3a:	87aa                	mv	a5,a0
    return -1;
    80004e3c:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004e3e:	0c07c363          	bltz	a5,80004f04 <sys_exec+0xfc>
  }
  memset(argv, 0, sizeof(argv));
    80004e42:	10000613          	li	a2,256
    80004e46:	4581                	li	a1,0
    80004e48:	e4040513          	addi	a0,s0,-448
    80004e4c:	ffffb097          	auipc	ra,0xffffb
    80004e50:	32e080e7          	jalr	814(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004e54:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004e58:	89a6                	mv	s3,s1
    80004e5a:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004e5c:	02000a13          	li	s4,32
    80004e60:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004e64:	00391513          	slli	a0,s2,0x3
    80004e68:	e3040593          	addi	a1,s0,-464
    80004e6c:	e3843783          	ld	a5,-456(s0)
    80004e70:	953e                	add	a0,a0,a5
    80004e72:	ffffd097          	auipc	ra,0xffffd
    80004e76:	0b6080e7          	jalr	182(ra) # 80001f28 <fetchaddr>
    80004e7a:	02054a63          	bltz	a0,80004eae <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80004e7e:	e3043783          	ld	a5,-464(s0)
    80004e82:	c3b9                	beqz	a5,80004ec8 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004e84:	ffffb097          	auipc	ra,0xffffb
    80004e88:	296080e7          	jalr	662(ra) # 8000011a <kalloc>
    80004e8c:	85aa                	mv	a1,a0
    80004e8e:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004e92:	cd11                	beqz	a0,80004eae <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004e94:	6605                	lui	a2,0x1
    80004e96:	e3043503          	ld	a0,-464(s0)
    80004e9a:	ffffd097          	auipc	ra,0xffffd
    80004e9e:	0e0080e7          	jalr	224(ra) # 80001f7a <fetchstr>
    80004ea2:	00054663          	bltz	a0,80004eae <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80004ea6:	0905                	addi	s2,s2,1
    80004ea8:	09a1                	addi	s3,s3,8
    80004eaa:	fb491be3          	bne	s2,s4,80004e60 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004eae:	f4040913          	addi	s2,s0,-192
    80004eb2:	6088                	ld	a0,0(s1)
    80004eb4:	c539                	beqz	a0,80004f02 <sys_exec+0xfa>
    kfree(argv[i]);
    80004eb6:	ffffb097          	auipc	ra,0xffffb
    80004eba:	166080e7          	jalr	358(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004ebe:	04a1                	addi	s1,s1,8
    80004ec0:	ff2499e3          	bne	s1,s2,80004eb2 <sys_exec+0xaa>
  return -1;
    80004ec4:	557d                	li	a0,-1
    80004ec6:	a83d                	j	80004f04 <sys_exec+0xfc>
      argv[i] = 0;
    80004ec8:	0a8e                	slli	s5,s5,0x3
    80004eca:	fc0a8793          	addi	a5,s5,-64
    80004ece:	00878ab3          	add	s5,a5,s0
    80004ed2:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80004ed6:	e4040593          	addi	a1,s0,-448
    80004eda:	f4040513          	addi	a0,s0,-192
    80004ede:	fffff097          	auipc	ra,0xfffff
    80004ee2:	16e080e7          	jalr	366(ra) # 8000404c <exec>
    80004ee6:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004ee8:	f4040993          	addi	s3,s0,-192
    80004eec:	6088                	ld	a0,0(s1)
    80004eee:	c901                	beqz	a0,80004efe <sys_exec+0xf6>
    kfree(argv[i]);
    80004ef0:	ffffb097          	auipc	ra,0xffffb
    80004ef4:	12c080e7          	jalr	300(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004ef8:	04a1                	addi	s1,s1,8
    80004efa:	ff3499e3          	bne	s1,s3,80004eec <sys_exec+0xe4>
  return ret;
    80004efe:	854a                	mv	a0,s2
    80004f00:	a011                	j	80004f04 <sys_exec+0xfc>
  return -1;
    80004f02:	557d                	li	a0,-1
}
    80004f04:	60be                	ld	ra,456(sp)
    80004f06:	641e                	ld	s0,448(sp)
    80004f08:	74fa                	ld	s1,440(sp)
    80004f0a:	795a                	ld	s2,432(sp)
    80004f0c:	79ba                	ld	s3,424(sp)
    80004f0e:	7a1a                	ld	s4,416(sp)
    80004f10:	6afa                	ld	s5,408(sp)
    80004f12:	6179                	addi	sp,sp,464
    80004f14:	8082                	ret

0000000080004f16 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004f16:	7139                	addi	sp,sp,-64
    80004f18:	fc06                	sd	ra,56(sp)
    80004f1a:	f822                	sd	s0,48(sp)
    80004f1c:	f426                	sd	s1,40(sp)
    80004f1e:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004f20:	ffffc097          	auipc	ra,0xffffc
    80004f24:	f8c080e7          	jalr	-116(ra) # 80000eac <myproc>
    80004f28:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004f2a:	fd840593          	addi	a1,s0,-40
    80004f2e:	4501                	li	a0,0
    80004f30:	ffffd097          	auipc	ra,0xffffd
    80004f34:	0b6080e7          	jalr	182(ra) # 80001fe6 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004f38:	fc840593          	addi	a1,s0,-56
    80004f3c:	fd040513          	addi	a0,s0,-48
    80004f40:	fffff097          	auipc	ra,0xfffff
    80004f44:	dc2080e7          	jalr	-574(ra) # 80003d02 <pipealloc>
    return -1;
    80004f48:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004f4a:	0c054463          	bltz	a0,80005012 <sys_pipe+0xfc>
  fd0 = -1;
    80004f4e:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004f52:	fd043503          	ld	a0,-48(s0)
    80004f56:	fffff097          	auipc	ra,0xfffff
    80004f5a:	514080e7          	jalr	1300(ra) # 8000446a <fdalloc>
    80004f5e:	fca42223          	sw	a0,-60(s0)
    80004f62:	08054b63          	bltz	a0,80004ff8 <sys_pipe+0xe2>
    80004f66:	fc843503          	ld	a0,-56(s0)
    80004f6a:	fffff097          	auipc	ra,0xfffff
    80004f6e:	500080e7          	jalr	1280(ra) # 8000446a <fdalloc>
    80004f72:	fca42023          	sw	a0,-64(s0)
    80004f76:	06054863          	bltz	a0,80004fe6 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004f7a:	4691                	li	a3,4
    80004f7c:	fc440613          	addi	a2,s0,-60
    80004f80:	fd843583          	ld	a1,-40(s0)
    80004f84:	68a8                	ld	a0,80(s1)
    80004f86:	ffffc097          	auipc	ra,0xffffc
    80004f8a:	bb2080e7          	jalr	-1102(ra) # 80000b38 <copyout>
    80004f8e:	02054063          	bltz	a0,80004fae <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80004f92:	4691                	li	a3,4
    80004f94:	fc040613          	addi	a2,s0,-64
    80004f98:	fd843583          	ld	a1,-40(s0)
    80004f9c:	0591                	addi	a1,a1,4
    80004f9e:	68a8                	ld	a0,80(s1)
    80004fa0:	ffffc097          	auipc	ra,0xffffc
    80004fa4:	b98080e7          	jalr	-1128(ra) # 80000b38 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004fa8:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004faa:	06055463          	bgez	a0,80005012 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80004fae:	fc442783          	lw	a5,-60(s0)
    80004fb2:	07e9                	addi	a5,a5,26
    80004fb4:	078e                	slli	a5,a5,0x3
    80004fb6:	97a6                	add	a5,a5,s1
    80004fb8:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80004fbc:	fc042783          	lw	a5,-64(s0)
    80004fc0:	07e9                	addi	a5,a5,26
    80004fc2:	078e                	slli	a5,a5,0x3
    80004fc4:	94be                	add	s1,s1,a5
    80004fc6:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004fca:	fd043503          	ld	a0,-48(s0)
    80004fce:	fffff097          	auipc	ra,0xfffff
    80004fd2:	a04080e7          	jalr	-1532(ra) # 800039d2 <fileclose>
    fileclose(wf);
    80004fd6:	fc843503          	ld	a0,-56(s0)
    80004fda:	fffff097          	auipc	ra,0xfffff
    80004fde:	9f8080e7          	jalr	-1544(ra) # 800039d2 <fileclose>
    return -1;
    80004fe2:	57fd                	li	a5,-1
    80004fe4:	a03d                	j	80005012 <sys_pipe+0xfc>
    if(fd0 >= 0)
    80004fe6:	fc442783          	lw	a5,-60(s0)
    80004fea:	0007c763          	bltz	a5,80004ff8 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80004fee:	07e9                	addi	a5,a5,26
    80004ff0:	078e                	slli	a5,a5,0x3
    80004ff2:	97a6                	add	a5,a5,s1
    80004ff4:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80004ff8:	fd043503          	ld	a0,-48(s0)
    80004ffc:	fffff097          	auipc	ra,0xfffff
    80005000:	9d6080e7          	jalr	-1578(ra) # 800039d2 <fileclose>
    fileclose(wf);
    80005004:	fc843503          	ld	a0,-56(s0)
    80005008:	fffff097          	auipc	ra,0xfffff
    8000500c:	9ca080e7          	jalr	-1590(ra) # 800039d2 <fileclose>
    return -1;
    80005010:	57fd                	li	a5,-1
}
    80005012:	853e                	mv	a0,a5
    80005014:	70e2                	ld	ra,56(sp)
    80005016:	7442                	ld	s0,48(sp)
    80005018:	74a2                	ld	s1,40(sp)
    8000501a:	6121                	addi	sp,sp,64
    8000501c:	8082                	ret
	...

0000000080005020 <kernelvec>:
    80005020:	7111                	addi	sp,sp,-256
    80005022:	e006                	sd	ra,0(sp)
    80005024:	e40a                	sd	sp,8(sp)
    80005026:	e80e                	sd	gp,16(sp)
    80005028:	ec12                	sd	tp,24(sp)
    8000502a:	f016                	sd	t0,32(sp)
    8000502c:	f41a                	sd	t1,40(sp)
    8000502e:	f81e                	sd	t2,48(sp)
    80005030:	fc22                	sd	s0,56(sp)
    80005032:	e0a6                	sd	s1,64(sp)
    80005034:	e4aa                	sd	a0,72(sp)
    80005036:	e8ae                	sd	a1,80(sp)
    80005038:	ecb2                	sd	a2,88(sp)
    8000503a:	f0b6                	sd	a3,96(sp)
    8000503c:	f4ba                	sd	a4,104(sp)
    8000503e:	f8be                	sd	a5,112(sp)
    80005040:	fcc2                	sd	a6,120(sp)
    80005042:	e146                	sd	a7,128(sp)
    80005044:	e54a                	sd	s2,136(sp)
    80005046:	e94e                	sd	s3,144(sp)
    80005048:	ed52                	sd	s4,152(sp)
    8000504a:	f156                	sd	s5,160(sp)
    8000504c:	f55a                	sd	s6,168(sp)
    8000504e:	f95e                	sd	s7,176(sp)
    80005050:	fd62                	sd	s8,184(sp)
    80005052:	e1e6                	sd	s9,192(sp)
    80005054:	e5ea                	sd	s10,200(sp)
    80005056:	e9ee                	sd	s11,208(sp)
    80005058:	edf2                	sd	t3,216(sp)
    8000505a:	f1f6                	sd	t4,224(sp)
    8000505c:	f5fa                	sd	t5,232(sp)
    8000505e:	f9fe                	sd	t6,240(sp)
    80005060:	d95fc0ef          	jal	ra,80001df4 <kerneltrap>
    80005064:	6082                	ld	ra,0(sp)
    80005066:	6122                	ld	sp,8(sp)
    80005068:	61c2                	ld	gp,16(sp)
    8000506a:	7282                	ld	t0,32(sp)
    8000506c:	7322                	ld	t1,40(sp)
    8000506e:	73c2                	ld	t2,48(sp)
    80005070:	7462                	ld	s0,56(sp)
    80005072:	6486                	ld	s1,64(sp)
    80005074:	6526                	ld	a0,72(sp)
    80005076:	65c6                	ld	a1,80(sp)
    80005078:	6666                	ld	a2,88(sp)
    8000507a:	7686                	ld	a3,96(sp)
    8000507c:	7726                	ld	a4,104(sp)
    8000507e:	77c6                	ld	a5,112(sp)
    80005080:	7866                	ld	a6,120(sp)
    80005082:	688a                	ld	a7,128(sp)
    80005084:	692a                	ld	s2,136(sp)
    80005086:	69ca                	ld	s3,144(sp)
    80005088:	6a6a                	ld	s4,152(sp)
    8000508a:	7a8a                	ld	s5,160(sp)
    8000508c:	7b2a                	ld	s6,168(sp)
    8000508e:	7bca                	ld	s7,176(sp)
    80005090:	7c6a                	ld	s8,184(sp)
    80005092:	6c8e                	ld	s9,192(sp)
    80005094:	6d2e                	ld	s10,200(sp)
    80005096:	6dce                	ld	s11,208(sp)
    80005098:	6e6e                	ld	t3,216(sp)
    8000509a:	7e8e                	ld	t4,224(sp)
    8000509c:	7f2e                	ld	t5,232(sp)
    8000509e:	7fce                	ld	t6,240(sp)
    800050a0:	6111                	addi	sp,sp,256
    800050a2:	10200073          	sret
    800050a6:	00000013          	nop
    800050aa:	00000013          	nop
    800050ae:	0001                	nop

00000000800050b0 <timervec>:
    800050b0:	34051573          	csrrw	a0,mscratch,a0
    800050b4:	e10c                	sd	a1,0(a0)
    800050b6:	e510                	sd	a2,8(a0)
    800050b8:	e914                	sd	a3,16(a0)
    800050ba:	6d0c                	ld	a1,24(a0)
    800050bc:	7110                	ld	a2,32(a0)
    800050be:	6194                	ld	a3,0(a1)
    800050c0:	96b2                	add	a3,a3,a2
    800050c2:	e194                	sd	a3,0(a1)
    800050c4:	4589                	li	a1,2
    800050c6:	14459073          	csrw	sip,a1
    800050ca:	6914                	ld	a3,16(a0)
    800050cc:	6510                	ld	a2,8(a0)
    800050ce:	610c                	ld	a1,0(a0)
    800050d0:	34051573          	csrrw	a0,mscratch,a0
    800050d4:	30200073          	mret
	...

00000000800050da <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800050da:	1141                	addi	sp,sp,-16
    800050dc:	e422                	sd	s0,8(sp)
    800050de:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800050e0:	0c0007b7          	lui	a5,0xc000
    800050e4:	4705                	li	a4,1
    800050e6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800050e8:	c3d8                	sw	a4,4(a5)
}
    800050ea:	6422                	ld	s0,8(sp)
    800050ec:	0141                	addi	sp,sp,16
    800050ee:	8082                	ret

00000000800050f0 <plicinithart>:

void
plicinithart(void)
{
    800050f0:	1141                	addi	sp,sp,-16
    800050f2:	e406                	sd	ra,8(sp)
    800050f4:	e022                	sd	s0,0(sp)
    800050f6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800050f8:	ffffc097          	auipc	ra,0xffffc
    800050fc:	d88080e7          	jalr	-632(ra) # 80000e80 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005100:	0085171b          	slliw	a4,a0,0x8
    80005104:	0c0027b7          	lui	a5,0xc002
    80005108:	97ba                	add	a5,a5,a4
    8000510a:	40200713          	li	a4,1026
    8000510e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005112:	00d5151b          	slliw	a0,a0,0xd
    80005116:	0c2017b7          	lui	a5,0xc201
    8000511a:	97aa                	add	a5,a5,a0
    8000511c:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005120:	60a2                	ld	ra,8(sp)
    80005122:	6402                	ld	s0,0(sp)
    80005124:	0141                	addi	sp,sp,16
    80005126:	8082                	ret

0000000080005128 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005128:	1141                	addi	sp,sp,-16
    8000512a:	e406                	sd	ra,8(sp)
    8000512c:	e022                	sd	s0,0(sp)
    8000512e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005130:	ffffc097          	auipc	ra,0xffffc
    80005134:	d50080e7          	jalr	-688(ra) # 80000e80 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005138:	00d5151b          	slliw	a0,a0,0xd
    8000513c:	0c2017b7          	lui	a5,0xc201
    80005140:	97aa                	add	a5,a5,a0
  return irq;
}
    80005142:	43c8                	lw	a0,4(a5)
    80005144:	60a2                	ld	ra,8(sp)
    80005146:	6402                	ld	s0,0(sp)
    80005148:	0141                	addi	sp,sp,16
    8000514a:	8082                	ret

000000008000514c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000514c:	1101                	addi	sp,sp,-32
    8000514e:	ec06                	sd	ra,24(sp)
    80005150:	e822                	sd	s0,16(sp)
    80005152:	e426                	sd	s1,8(sp)
    80005154:	1000                	addi	s0,sp,32
    80005156:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005158:	ffffc097          	auipc	ra,0xffffc
    8000515c:	d28080e7          	jalr	-728(ra) # 80000e80 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005160:	00d5151b          	slliw	a0,a0,0xd
    80005164:	0c2017b7          	lui	a5,0xc201
    80005168:	97aa                	add	a5,a5,a0
    8000516a:	c3c4                	sw	s1,4(a5)
}
    8000516c:	60e2                	ld	ra,24(sp)
    8000516e:	6442                	ld	s0,16(sp)
    80005170:	64a2                	ld	s1,8(sp)
    80005172:	6105                	addi	sp,sp,32
    80005174:	8082                	ret

0000000080005176 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005176:	1141                	addi	sp,sp,-16
    80005178:	e406                	sd	ra,8(sp)
    8000517a:	e022                	sd	s0,0(sp)
    8000517c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000517e:	479d                	li	a5,7
    80005180:	04a7cc63          	blt	a5,a0,800051d8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005184:	00015797          	auipc	a5,0x15
    80005188:	88c78793          	addi	a5,a5,-1908 # 80019a10 <disk>
    8000518c:	97aa                	add	a5,a5,a0
    8000518e:	0187c783          	lbu	a5,24(a5)
    80005192:	ebb9                	bnez	a5,800051e8 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005194:	00451693          	slli	a3,a0,0x4
    80005198:	00015797          	auipc	a5,0x15
    8000519c:	87878793          	addi	a5,a5,-1928 # 80019a10 <disk>
    800051a0:	6398                	ld	a4,0(a5)
    800051a2:	9736                	add	a4,a4,a3
    800051a4:	00073023          	sd	zero,0(a4)
  disk.desc[i].len = 0;
    800051a8:	6398                	ld	a4,0(a5)
    800051aa:	9736                	add	a4,a4,a3
    800051ac:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800051b0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800051b4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800051b8:	97aa                	add	a5,a5,a0
    800051ba:	4705                	li	a4,1
    800051bc:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800051c0:	00015517          	auipc	a0,0x15
    800051c4:	86850513          	addi	a0,a0,-1944 # 80019a28 <disk+0x18>
    800051c8:	ffffc097          	auipc	ra,0xffffc
    800051cc:	3f4080e7          	jalr	1012(ra) # 800015bc <wakeup>
}
    800051d0:	60a2                	ld	ra,8(sp)
    800051d2:	6402                	ld	s0,0(sp)
    800051d4:	0141                	addi	sp,sp,16
    800051d6:	8082                	ret
    panic("free_desc 1");
    800051d8:	00003517          	auipc	a0,0x3
    800051dc:	52850513          	addi	a0,a0,1320 # 80008700 <syscalls+0x2f0>
    800051e0:	00001097          	auipc	ra,0x1
    800051e4:	a0c080e7          	jalr	-1524(ra) # 80005bec <panic>
    panic("free_desc 2");
    800051e8:	00003517          	auipc	a0,0x3
    800051ec:	52850513          	addi	a0,a0,1320 # 80008710 <syscalls+0x300>
    800051f0:	00001097          	auipc	ra,0x1
    800051f4:	9fc080e7          	jalr	-1540(ra) # 80005bec <panic>

00000000800051f8 <virtio_disk_init>:
{
    800051f8:	1101                	addi	sp,sp,-32
    800051fa:	ec06                	sd	ra,24(sp)
    800051fc:	e822                	sd	s0,16(sp)
    800051fe:	e426                	sd	s1,8(sp)
    80005200:	e04a                	sd	s2,0(sp)
    80005202:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005204:	00003597          	auipc	a1,0x3
    80005208:	51c58593          	addi	a1,a1,1308 # 80008720 <syscalls+0x310>
    8000520c:	00015517          	auipc	a0,0x15
    80005210:	92c50513          	addi	a0,a0,-1748 # 80019b38 <disk+0x128>
    80005214:	00001097          	auipc	ra,0x1
    80005218:	e80080e7          	jalr	-384(ra) # 80006094 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000521c:	100017b7          	lui	a5,0x10001
    80005220:	4398                	lw	a4,0(a5)
    80005222:	2701                	sext.w	a4,a4
    80005224:	747277b7          	lui	a5,0x74727
    80005228:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000522c:	14f71b63          	bne	a4,a5,80005382 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005230:	100017b7          	lui	a5,0x10001
    80005234:	43dc                	lw	a5,4(a5)
    80005236:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005238:	4709                	li	a4,2
    8000523a:	14e79463          	bne	a5,a4,80005382 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000523e:	100017b7          	lui	a5,0x10001
    80005242:	479c                	lw	a5,8(a5)
    80005244:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005246:	12e79e63          	bne	a5,a4,80005382 <virtio_disk_init+0x18a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000524a:	100017b7          	lui	a5,0x10001
    8000524e:	47d8                	lw	a4,12(a5)
    80005250:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005252:	554d47b7          	lui	a5,0x554d4
    80005256:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000525a:	12f71463          	bne	a4,a5,80005382 <virtio_disk_init+0x18a>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000525e:	100017b7          	lui	a5,0x10001
    80005262:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005266:	4705                	li	a4,1
    80005268:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000526a:	470d                	li	a4,3
    8000526c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000526e:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005270:	c7ffe6b7          	lui	a3,0xc7ffe
    80005274:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc9cf>
    80005278:	8f75                	and	a4,a4,a3
    8000527a:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000527c:	472d                	li	a4,11
    8000527e:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005280:	5bbc                	lw	a5,112(a5)
    80005282:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005286:	8ba1                	andi	a5,a5,8
    80005288:	10078563          	beqz	a5,80005392 <virtio_disk_init+0x19a>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000528c:	100017b7          	lui	a5,0x10001
    80005290:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005294:	43fc                	lw	a5,68(a5)
    80005296:	2781                	sext.w	a5,a5
    80005298:	10079563          	bnez	a5,800053a2 <virtio_disk_init+0x1aa>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    8000529c:	100017b7          	lui	a5,0x10001
    800052a0:	5bdc                	lw	a5,52(a5)
    800052a2:	2781                	sext.w	a5,a5
  if(max == 0)
    800052a4:	10078763          	beqz	a5,800053b2 <virtio_disk_init+0x1ba>
  if(max < NUM)
    800052a8:	471d                	li	a4,7
    800052aa:	10f77c63          	bgeu	a4,a5,800053c2 <virtio_disk_init+0x1ca>
  disk.desc = kalloc();
    800052ae:	ffffb097          	auipc	ra,0xffffb
    800052b2:	e6c080e7          	jalr	-404(ra) # 8000011a <kalloc>
    800052b6:	00014497          	auipc	s1,0x14
    800052ba:	75a48493          	addi	s1,s1,1882 # 80019a10 <disk>
    800052be:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800052c0:	ffffb097          	auipc	ra,0xffffb
    800052c4:	e5a080e7          	jalr	-422(ra) # 8000011a <kalloc>
    800052c8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800052ca:	ffffb097          	auipc	ra,0xffffb
    800052ce:	e50080e7          	jalr	-432(ra) # 8000011a <kalloc>
    800052d2:	87aa                	mv	a5,a0
    800052d4:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800052d6:	6088                	ld	a0,0(s1)
    800052d8:	cd6d                	beqz	a0,800053d2 <virtio_disk_init+0x1da>
    800052da:	00014717          	auipc	a4,0x14
    800052de:	73e73703          	ld	a4,1854(a4) # 80019a18 <disk+0x8>
    800052e2:	cb65                	beqz	a4,800053d2 <virtio_disk_init+0x1da>
    800052e4:	c7fd                	beqz	a5,800053d2 <virtio_disk_init+0x1da>
  memset(disk.desc, 0, PGSIZE);
    800052e6:	6605                	lui	a2,0x1
    800052e8:	4581                	li	a1,0
    800052ea:	ffffb097          	auipc	ra,0xffffb
    800052ee:	e90080e7          	jalr	-368(ra) # 8000017a <memset>
  memset(disk.avail, 0, PGSIZE);
    800052f2:	00014497          	auipc	s1,0x14
    800052f6:	71e48493          	addi	s1,s1,1822 # 80019a10 <disk>
    800052fa:	6605                	lui	a2,0x1
    800052fc:	4581                	li	a1,0
    800052fe:	6488                	ld	a0,8(s1)
    80005300:	ffffb097          	auipc	ra,0xffffb
    80005304:	e7a080e7          	jalr	-390(ra) # 8000017a <memset>
  memset(disk.used, 0, PGSIZE);
    80005308:	6605                	lui	a2,0x1
    8000530a:	4581                	li	a1,0
    8000530c:	6888                	ld	a0,16(s1)
    8000530e:	ffffb097          	auipc	ra,0xffffb
    80005312:	e6c080e7          	jalr	-404(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005316:	100017b7          	lui	a5,0x10001
    8000531a:	4721                	li	a4,8
    8000531c:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000531e:	4098                	lw	a4,0(s1)
    80005320:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005324:	40d8                	lw	a4,4(s1)
    80005326:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    8000532a:	6498                	ld	a4,8(s1)
    8000532c:	0007069b          	sext.w	a3,a4
    80005330:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005334:	9701                	srai	a4,a4,0x20
    80005336:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    8000533a:	6898                	ld	a4,16(s1)
    8000533c:	0007069b          	sext.w	a3,a4
    80005340:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005344:	9701                	srai	a4,a4,0x20
    80005346:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    8000534a:	4705                	li	a4,1
    8000534c:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    8000534e:	00e48c23          	sb	a4,24(s1)
    80005352:	00e48ca3          	sb	a4,25(s1)
    80005356:	00e48d23          	sb	a4,26(s1)
    8000535a:	00e48da3          	sb	a4,27(s1)
    8000535e:	00e48e23          	sb	a4,28(s1)
    80005362:	00e48ea3          	sb	a4,29(s1)
    80005366:	00e48f23          	sb	a4,30(s1)
    8000536a:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000536e:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005372:	0727a823          	sw	s2,112(a5)
}
    80005376:	60e2                	ld	ra,24(sp)
    80005378:	6442                	ld	s0,16(sp)
    8000537a:	64a2                	ld	s1,8(sp)
    8000537c:	6902                	ld	s2,0(sp)
    8000537e:	6105                	addi	sp,sp,32
    80005380:	8082                	ret
    panic("could not find virtio disk");
    80005382:	00003517          	auipc	a0,0x3
    80005386:	3ae50513          	addi	a0,a0,942 # 80008730 <syscalls+0x320>
    8000538a:	00001097          	auipc	ra,0x1
    8000538e:	862080e7          	jalr	-1950(ra) # 80005bec <panic>
    panic("virtio disk FEATURES_OK unset");
    80005392:	00003517          	auipc	a0,0x3
    80005396:	3be50513          	addi	a0,a0,958 # 80008750 <syscalls+0x340>
    8000539a:	00001097          	auipc	ra,0x1
    8000539e:	852080e7          	jalr	-1966(ra) # 80005bec <panic>
    panic("virtio disk should not be ready");
    800053a2:	00003517          	auipc	a0,0x3
    800053a6:	3ce50513          	addi	a0,a0,974 # 80008770 <syscalls+0x360>
    800053aa:	00001097          	auipc	ra,0x1
    800053ae:	842080e7          	jalr	-1982(ra) # 80005bec <panic>
    panic("virtio disk has no queue 0");
    800053b2:	00003517          	auipc	a0,0x3
    800053b6:	3de50513          	addi	a0,a0,990 # 80008790 <syscalls+0x380>
    800053ba:	00001097          	auipc	ra,0x1
    800053be:	832080e7          	jalr	-1998(ra) # 80005bec <panic>
    panic("virtio disk max queue too short");
    800053c2:	00003517          	auipc	a0,0x3
    800053c6:	3ee50513          	addi	a0,a0,1006 # 800087b0 <syscalls+0x3a0>
    800053ca:	00001097          	auipc	ra,0x1
    800053ce:	822080e7          	jalr	-2014(ra) # 80005bec <panic>
    panic("virtio disk kalloc");
    800053d2:	00003517          	auipc	a0,0x3
    800053d6:	3fe50513          	addi	a0,a0,1022 # 800087d0 <syscalls+0x3c0>
    800053da:	00001097          	auipc	ra,0x1
    800053de:	812080e7          	jalr	-2030(ra) # 80005bec <panic>

00000000800053e2 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800053e2:	7119                	addi	sp,sp,-128
    800053e4:	fc86                	sd	ra,120(sp)
    800053e6:	f8a2                	sd	s0,112(sp)
    800053e8:	f4a6                	sd	s1,104(sp)
    800053ea:	f0ca                	sd	s2,96(sp)
    800053ec:	ecce                	sd	s3,88(sp)
    800053ee:	e8d2                	sd	s4,80(sp)
    800053f0:	e4d6                	sd	s5,72(sp)
    800053f2:	e0da                	sd	s6,64(sp)
    800053f4:	fc5e                	sd	s7,56(sp)
    800053f6:	f862                	sd	s8,48(sp)
    800053f8:	f466                	sd	s9,40(sp)
    800053fa:	f06a                	sd	s10,32(sp)
    800053fc:	ec6e                	sd	s11,24(sp)
    800053fe:	0100                	addi	s0,sp,128
    80005400:	8aaa                	mv	s5,a0
    80005402:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005404:	00c52d03          	lw	s10,12(a0)
    80005408:	001d1d1b          	slliw	s10,s10,0x1
    8000540c:	1d02                	slli	s10,s10,0x20
    8000540e:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk.vdisk_lock);
    80005412:	00014517          	auipc	a0,0x14
    80005416:	72650513          	addi	a0,a0,1830 # 80019b38 <disk+0x128>
    8000541a:	00001097          	auipc	ra,0x1
    8000541e:	d0a080e7          	jalr	-758(ra) # 80006124 <acquire>
  for(int i = 0; i < 3; i++){
    80005422:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005424:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005426:	00014b97          	auipc	s7,0x14
    8000542a:	5eab8b93          	addi	s7,s7,1514 # 80019a10 <disk>
  for(int i = 0; i < 3; i++){
    8000542e:	4b0d                	li	s6,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005430:	00014c97          	auipc	s9,0x14
    80005434:	708c8c93          	addi	s9,s9,1800 # 80019b38 <disk+0x128>
    80005438:	a08d                	j	8000549a <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    8000543a:	00fb8733          	add	a4,s7,a5
    8000543e:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005442:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005444:	0207c563          	bltz	a5,8000546e <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    80005448:	2905                	addiw	s2,s2,1
    8000544a:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    8000544c:	05690c63          	beq	s2,s6,800054a4 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    80005450:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005452:	00014717          	auipc	a4,0x14
    80005456:	5be70713          	addi	a4,a4,1470 # 80019a10 <disk>
    8000545a:	87ce                	mv	a5,s3
    if(disk.free[i]){
    8000545c:	01874683          	lbu	a3,24(a4)
    80005460:	fee9                	bnez	a3,8000543a <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80005462:	2785                	addiw	a5,a5,1
    80005464:	0705                	addi	a4,a4,1
    80005466:	fe979be3          	bne	a5,s1,8000545c <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    8000546a:	57fd                	li	a5,-1
    8000546c:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000546e:	01205d63          	blez	s2,80005488 <virtio_disk_rw+0xa6>
    80005472:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005474:	000a2503          	lw	a0,0(s4)
    80005478:	00000097          	auipc	ra,0x0
    8000547c:	cfe080e7          	jalr	-770(ra) # 80005176 <free_desc>
      for(int j = 0; j < i; j++)
    80005480:	2d85                	addiw	s11,s11,1
    80005482:	0a11                	addi	s4,s4,4
    80005484:	ff2d98e3          	bne	s11,s2,80005474 <virtio_disk_rw+0x92>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005488:	85e6                	mv	a1,s9
    8000548a:	00014517          	auipc	a0,0x14
    8000548e:	59e50513          	addi	a0,a0,1438 # 80019a28 <disk+0x18>
    80005492:	ffffc097          	auipc	ra,0xffffc
    80005496:	0c6080e7          	jalr	198(ra) # 80001558 <sleep>
  for(int i = 0; i < 3; i++){
    8000549a:	f8040a13          	addi	s4,s0,-128
{
    8000549e:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    800054a0:	894e                	mv	s2,s3
    800054a2:	b77d                	j	80005450 <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800054a4:	f8042503          	lw	a0,-128(s0)
    800054a8:	00a50713          	addi	a4,a0,10
    800054ac:	0712                	slli	a4,a4,0x4

  if(write)
    800054ae:	00014797          	auipc	a5,0x14
    800054b2:	56278793          	addi	a5,a5,1378 # 80019a10 <disk>
    800054b6:	00e786b3          	add	a3,a5,a4
    800054ba:	01803633          	snez	a2,s8
    800054be:	c690                	sw	a2,8(a3)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800054c0:	0006a623          	sw	zero,12(a3)
  buf0->sector = sector;
    800054c4:	01a6b823          	sd	s10,16(a3)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800054c8:	f6070613          	addi	a2,a4,-160
    800054cc:	6394                	ld	a3,0(a5)
    800054ce:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800054d0:	00870593          	addi	a1,a4,8
    800054d4:	95be                	add	a1,a1,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    800054d6:	e28c                	sd	a1,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800054d8:	0007b803          	ld	a6,0(a5)
    800054dc:	9642                	add	a2,a2,a6
    800054de:	46c1                	li	a3,16
    800054e0:	c614                	sw	a3,8(a2)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800054e2:	4585                	li	a1,1
    800054e4:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[0]].next = idx[1];
    800054e8:	f8442683          	lw	a3,-124(s0)
    800054ec:	00d61723          	sh	a3,14(a2)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800054f0:	0692                	slli	a3,a3,0x4
    800054f2:	9836                	add	a6,a6,a3
    800054f4:	058a8613          	addi	a2,s5,88
    800054f8:	00c83023          	sd	a2,0(a6)
  disk.desc[idx[1]].len = BSIZE;
    800054fc:	0007b803          	ld	a6,0(a5)
    80005500:	96c2                	add	a3,a3,a6
    80005502:	40000613          	li	a2,1024
    80005506:	c690                	sw	a2,8(a3)
  if(write)
    80005508:	001c3613          	seqz	a2,s8
    8000550c:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005510:	00166613          	ori	a2,a2,1
    80005514:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005518:	f8842603          	lw	a2,-120(s0)
    8000551c:	00c69723          	sh	a2,14(a3)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005520:	00250693          	addi	a3,a0,2
    80005524:	0692                	slli	a3,a3,0x4
    80005526:	96be                	add	a3,a3,a5
    80005528:	58fd                	li	a7,-1
    8000552a:	01168823          	sb	a7,16(a3)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000552e:	0612                	slli	a2,a2,0x4
    80005530:	9832                	add	a6,a6,a2
    80005532:	f9070713          	addi	a4,a4,-112
    80005536:	973e                	add	a4,a4,a5
    80005538:	00e83023          	sd	a4,0(a6)
  disk.desc[idx[2]].len = 1;
    8000553c:	6398                	ld	a4,0(a5)
    8000553e:	9732                	add	a4,a4,a2
    80005540:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005542:	4609                	li	a2,2
    80005544:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[2]].next = 0;
    80005548:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000554c:	00baa223          	sw	a1,4(s5)
  disk.info[idx[0]].b = b;
    80005550:	0156b423          	sd	s5,8(a3)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005554:	6794                	ld	a3,8(a5)
    80005556:	0026d703          	lhu	a4,2(a3)
    8000555a:	8b1d                	andi	a4,a4,7
    8000555c:	0706                	slli	a4,a4,0x1
    8000555e:	96ba                	add	a3,a3,a4
    80005560:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80005564:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005568:	6798                	ld	a4,8(a5)
    8000556a:	00275783          	lhu	a5,2(a4)
    8000556e:	2785                	addiw	a5,a5,1
    80005570:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005574:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005578:	100017b7          	lui	a5,0x10001
    8000557c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005580:	004aa783          	lw	a5,4(s5)
    sleep(b, &disk.vdisk_lock);
    80005584:	00014917          	auipc	s2,0x14
    80005588:	5b490913          	addi	s2,s2,1460 # 80019b38 <disk+0x128>
  while(b->disk == 1) {
    8000558c:	4485                	li	s1,1
    8000558e:	00b79c63          	bne	a5,a1,800055a6 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    80005592:	85ca                	mv	a1,s2
    80005594:	8556                	mv	a0,s5
    80005596:	ffffc097          	auipc	ra,0xffffc
    8000559a:	fc2080e7          	jalr	-62(ra) # 80001558 <sleep>
  while(b->disk == 1) {
    8000559e:	004aa783          	lw	a5,4(s5)
    800055a2:	fe9788e3          	beq	a5,s1,80005592 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    800055a6:	f8042903          	lw	s2,-128(s0)
    800055aa:	00290713          	addi	a4,s2,2
    800055ae:	0712                	slli	a4,a4,0x4
    800055b0:	00014797          	auipc	a5,0x14
    800055b4:	46078793          	addi	a5,a5,1120 # 80019a10 <disk>
    800055b8:	97ba                	add	a5,a5,a4
    800055ba:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800055be:	00014997          	auipc	s3,0x14
    800055c2:	45298993          	addi	s3,s3,1106 # 80019a10 <disk>
    800055c6:	00491713          	slli	a4,s2,0x4
    800055ca:	0009b783          	ld	a5,0(s3)
    800055ce:	97ba                	add	a5,a5,a4
    800055d0:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800055d4:	854a                	mv	a0,s2
    800055d6:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800055da:	00000097          	auipc	ra,0x0
    800055de:	b9c080e7          	jalr	-1124(ra) # 80005176 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800055e2:	8885                	andi	s1,s1,1
    800055e4:	f0ed                	bnez	s1,800055c6 <virtio_disk_rw+0x1e4>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800055e6:	00014517          	auipc	a0,0x14
    800055ea:	55250513          	addi	a0,a0,1362 # 80019b38 <disk+0x128>
    800055ee:	00001097          	auipc	ra,0x1
    800055f2:	bea080e7          	jalr	-1046(ra) # 800061d8 <release>
}
    800055f6:	70e6                	ld	ra,120(sp)
    800055f8:	7446                	ld	s0,112(sp)
    800055fa:	74a6                	ld	s1,104(sp)
    800055fc:	7906                	ld	s2,96(sp)
    800055fe:	69e6                	ld	s3,88(sp)
    80005600:	6a46                	ld	s4,80(sp)
    80005602:	6aa6                	ld	s5,72(sp)
    80005604:	6b06                	ld	s6,64(sp)
    80005606:	7be2                	ld	s7,56(sp)
    80005608:	7c42                	ld	s8,48(sp)
    8000560a:	7ca2                	ld	s9,40(sp)
    8000560c:	7d02                	ld	s10,32(sp)
    8000560e:	6de2                	ld	s11,24(sp)
    80005610:	6109                	addi	sp,sp,128
    80005612:	8082                	ret

0000000080005614 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005614:	1101                	addi	sp,sp,-32
    80005616:	ec06                	sd	ra,24(sp)
    80005618:	e822                	sd	s0,16(sp)
    8000561a:	e426                	sd	s1,8(sp)
    8000561c:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000561e:	00014497          	auipc	s1,0x14
    80005622:	3f248493          	addi	s1,s1,1010 # 80019a10 <disk>
    80005626:	00014517          	auipc	a0,0x14
    8000562a:	51250513          	addi	a0,a0,1298 # 80019b38 <disk+0x128>
    8000562e:	00001097          	auipc	ra,0x1
    80005632:	af6080e7          	jalr	-1290(ra) # 80006124 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005636:	10001737          	lui	a4,0x10001
    8000563a:	533c                	lw	a5,96(a4)
    8000563c:	8b8d                	andi	a5,a5,3
    8000563e:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005640:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005644:	689c                	ld	a5,16(s1)
    80005646:	0204d703          	lhu	a4,32(s1)
    8000564a:	0027d783          	lhu	a5,2(a5)
    8000564e:	04f70863          	beq	a4,a5,8000569e <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005652:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005656:	6898                	ld	a4,16(s1)
    80005658:	0204d783          	lhu	a5,32(s1)
    8000565c:	8b9d                	andi	a5,a5,7
    8000565e:	078e                	slli	a5,a5,0x3
    80005660:	97ba                	add	a5,a5,a4
    80005662:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005664:	00278713          	addi	a4,a5,2
    80005668:	0712                	slli	a4,a4,0x4
    8000566a:	9726                	add	a4,a4,s1
    8000566c:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005670:	e721                	bnez	a4,800056b8 <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005672:	0789                	addi	a5,a5,2
    80005674:	0792                	slli	a5,a5,0x4
    80005676:	97a6                	add	a5,a5,s1
    80005678:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000567a:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000567e:	ffffc097          	auipc	ra,0xffffc
    80005682:	f3e080e7          	jalr	-194(ra) # 800015bc <wakeup>

    disk.used_idx += 1;
    80005686:	0204d783          	lhu	a5,32(s1)
    8000568a:	2785                	addiw	a5,a5,1
    8000568c:	17c2                	slli	a5,a5,0x30
    8000568e:	93c1                	srli	a5,a5,0x30
    80005690:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005694:	6898                	ld	a4,16(s1)
    80005696:	00275703          	lhu	a4,2(a4)
    8000569a:	faf71ce3          	bne	a4,a5,80005652 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    8000569e:	00014517          	auipc	a0,0x14
    800056a2:	49a50513          	addi	a0,a0,1178 # 80019b38 <disk+0x128>
    800056a6:	00001097          	auipc	ra,0x1
    800056aa:	b32080e7          	jalr	-1230(ra) # 800061d8 <release>
}
    800056ae:	60e2                	ld	ra,24(sp)
    800056b0:	6442                	ld	s0,16(sp)
    800056b2:	64a2                	ld	s1,8(sp)
    800056b4:	6105                	addi	sp,sp,32
    800056b6:	8082                	ret
      panic("virtio_disk_intr status");
    800056b8:	00003517          	auipc	a0,0x3
    800056bc:	13050513          	addi	a0,a0,304 # 800087e8 <syscalls+0x3d8>
    800056c0:	00000097          	auipc	ra,0x0
    800056c4:	52c080e7          	jalr	1324(ra) # 80005bec <panic>

00000000800056c8 <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800056c8:	1141                	addi	sp,sp,-16
    800056ca:	e422                	sd	s0,8(sp)
    800056cc:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800056ce:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800056d2:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800056d6:	0037979b          	slliw	a5,a5,0x3
    800056da:	02004737          	lui	a4,0x2004
    800056de:	97ba                	add	a5,a5,a4
    800056e0:	0200c737          	lui	a4,0x200c
    800056e4:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800056e8:	000f4637          	lui	a2,0xf4
    800056ec:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800056f0:	9732                	add	a4,a4,a2
    800056f2:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800056f4:	00259693          	slli	a3,a1,0x2
    800056f8:	96ae                	add	a3,a3,a1
    800056fa:	068e                	slli	a3,a3,0x3
    800056fc:	00014717          	auipc	a4,0x14
    80005700:	45470713          	addi	a4,a4,1108 # 80019b50 <timer_scratch>
    80005704:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005706:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005708:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000570a:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    8000570e:	00000797          	auipc	a5,0x0
    80005712:	9a278793          	addi	a5,a5,-1630 # 800050b0 <timervec>
    80005716:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000571a:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000571e:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005722:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005726:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000572a:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    8000572e:	30479073          	csrw	mie,a5
}
    80005732:	6422                	ld	s0,8(sp)
    80005734:	0141                	addi	sp,sp,16
    80005736:	8082                	ret

0000000080005738 <start>:
{
    80005738:	1141                	addi	sp,sp,-16
    8000573a:	e406                	sd	ra,8(sp)
    8000573c:	e022                	sd	s0,0(sp)
    8000573e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005740:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005744:	7779                	lui	a4,0xffffe
    80005746:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdca6f>
    8000574a:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000574c:	6705                	lui	a4,0x1
    8000574e:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005752:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005754:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005758:	ffffb797          	auipc	a5,0xffffb
    8000575c:	bc878793          	addi	a5,a5,-1080 # 80000320 <main>
    80005760:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005764:	4781                	li	a5,0
    80005766:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    8000576a:	67c1                	lui	a5,0x10
    8000576c:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000576e:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005772:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005776:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    8000577a:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    8000577e:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005782:	57fd                	li	a5,-1
    80005784:	83a9                	srli	a5,a5,0xa
    80005786:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    8000578a:	47bd                	li	a5,15
    8000578c:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005790:	00000097          	auipc	ra,0x0
    80005794:	f38080e7          	jalr	-200(ra) # 800056c8 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005798:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    8000579c:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    8000579e:	823e                	mv	tp,a5
  asm volatile("mret");
    800057a0:	30200073          	mret
}
    800057a4:	60a2                	ld	ra,8(sp)
    800057a6:	6402                	ld	s0,0(sp)
    800057a8:	0141                	addi	sp,sp,16
    800057aa:	8082                	ret

00000000800057ac <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800057ac:	715d                	addi	sp,sp,-80
    800057ae:	e486                	sd	ra,72(sp)
    800057b0:	e0a2                	sd	s0,64(sp)
    800057b2:	fc26                	sd	s1,56(sp)
    800057b4:	f84a                	sd	s2,48(sp)
    800057b6:	f44e                	sd	s3,40(sp)
    800057b8:	f052                	sd	s4,32(sp)
    800057ba:	ec56                	sd	s5,24(sp)
    800057bc:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    800057be:	04c05763          	blez	a2,8000580c <consolewrite+0x60>
    800057c2:	8a2a                	mv	s4,a0
    800057c4:	84ae                	mv	s1,a1
    800057c6:	89b2                	mv	s3,a2
    800057c8:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800057ca:	5afd                	li	s5,-1
    800057cc:	4685                	li	a3,1
    800057ce:	8626                	mv	a2,s1
    800057d0:	85d2                	mv	a1,s4
    800057d2:	fbf40513          	addi	a0,s0,-65
    800057d6:	ffffc097          	auipc	ra,0xffffc
    800057da:	1e0080e7          	jalr	480(ra) # 800019b6 <either_copyin>
    800057de:	01550d63          	beq	a0,s5,800057f8 <consolewrite+0x4c>
      break;
    uartputc(c);
    800057e2:	fbf44503          	lbu	a0,-65(s0)
    800057e6:	00000097          	auipc	ra,0x0
    800057ea:	784080e7          	jalr	1924(ra) # 80005f6a <uartputc>
  for(i = 0; i < n; i++){
    800057ee:	2905                	addiw	s2,s2,1
    800057f0:	0485                	addi	s1,s1,1
    800057f2:	fd299de3          	bne	s3,s2,800057cc <consolewrite+0x20>
    800057f6:	894e                	mv	s2,s3
  }

  return i;
}
    800057f8:	854a                	mv	a0,s2
    800057fa:	60a6                	ld	ra,72(sp)
    800057fc:	6406                	ld	s0,64(sp)
    800057fe:	74e2                	ld	s1,56(sp)
    80005800:	7942                	ld	s2,48(sp)
    80005802:	79a2                	ld	s3,40(sp)
    80005804:	7a02                	ld	s4,32(sp)
    80005806:	6ae2                	ld	s5,24(sp)
    80005808:	6161                	addi	sp,sp,80
    8000580a:	8082                	ret
  for(i = 0; i < n; i++){
    8000580c:	4901                	li	s2,0
    8000580e:	b7ed                	j	800057f8 <consolewrite+0x4c>

0000000080005810 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005810:	7159                	addi	sp,sp,-112
    80005812:	f486                	sd	ra,104(sp)
    80005814:	f0a2                	sd	s0,96(sp)
    80005816:	eca6                	sd	s1,88(sp)
    80005818:	e8ca                	sd	s2,80(sp)
    8000581a:	e4ce                	sd	s3,72(sp)
    8000581c:	e0d2                	sd	s4,64(sp)
    8000581e:	fc56                	sd	s5,56(sp)
    80005820:	f85a                	sd	s6,48(sp)
    80005822:	f45e                	sd	s7,40(sp)
    80005824:	f062                	sd	s8,32(sp)
    80005826:	ec66                	sd	s9,24(sp)
    80005828:	e86a                	sd	s10,16(sp)
    8000582a:	1880                	addi	s0,sp,112
    8000582c:	8aaa                	mv	s5,a0
    8000582e:	8a2e                	mv	s4,a1
    80005830:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005832:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80005836:	0001c517          	auipc	a0,0x1c
    8000583a:	45a50513          	addi	a0,a0,1114 # 80021c90 <cons>
    8000583e:	00001097          	auipc	ra,0x1
    80005842:	8e6080e7          	jalr	-1818(ra) # 80006124 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005846:	0001c497          	auipc	s1,0x1c
    8000584a:	44a48493          	addi	s1,s1,1098 # 80021c90 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000584e:	0001c917          	auipc	s2,0x1c
    80005852:	4da90913          	addi	s2,s2,1242 # 80021d28 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    80005856:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005858:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    8000585a:	4ca9                	li	s9,10
  while(n > 0){
    8000585c:	07305b63          	blez	s3,800058d2 <consoleread+0xc2>
    while(cons.r == cons.w){
    80005860:	0984a783          	lw	a5,152(s1)
    80005864:	09c4a703          	lw	a4,156(s1)
    80005868:	02f71763          	bne	a4,a5,80005896 <consoleread+0x86>
      if(killed(myproc())){
    8000586c:	ffffb097          	auipc	ra,0xffffb
    80005870:	640080e7          	jalr	1600(ra) # 80000eac <myproc>
    80005874:	ffffc097          	auipc	ra,0xffffc
    80005878:	f8c080e7          	jalr	-116(ra) # 80001800 <killed>
    8000587c:	e535                	bnez	a0,800058e8 <consoleread+0xd8>
      sleep(&cons.r, &cons.lock);
    8000587e:	85a6                	mv	a1,s1
    80005880:	854a                	mv	a0,s2
    80005882:	ffffc097          	auipc	ra,0xffffc
    80005886:	cd6080e7          	jalr	-810(ra) # 80001558 <sleep>
    while(cons.r == cons.w){
    8000588a:	0984a783          	lw	a5,152(s1)
    8000588e:	09c4a703          	lw	a4,156(s1)
    80005892:	fcf70de3          	beq	a4,a5,8000586c <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005896:	0017871b          	addiw	a4,a5,1
    8000589a:	08e4ac23          	sw	a4,152(s1)
    8000589e:	07f7f713          	andi	a4,a5,127
    800058a2:	9726                	add	a4,a4,s1
    800058a4:	01874703          	lbu	a4,24(a4)
    800058a8:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    800058ac:	077d0563          	beq	s10,s7,80005916 <consoleread+0x106>
    cbuf = c;
    800058b0:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800058b4:	4685                	li	a3,1
    800058b6:	f9f40613          	addi	a2,s0,-97
    800058ba:	85d2                	mv	a1,s4
    800058bc:	8556                	mv	a0,s5
    800058be:	ffffc097          	auipc	ra,0xffffc
    800058c2:	0a2080e7          	jalr	162(ra) # 80001960 <either_copyout>
    800058c6:	01850663          	beq	a0,s8,800058d2 <consoleread+0xc2>
    dst++;
    800058ca:	0a05                	addi	s4,s4,1
    --n;
    800058cc:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    800058ce:	f99d17e3          	bne	s10,s9,8000585c <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    800058d2:	0001c517          	auipc	a0,0x1c
    800058d6:	3be50513          	addi	a0,a0,958 # 80021c90 <cons>
    800058da:	00001097          	auipc	ra,0x1
    800058de:	8fe080e7          	jalr	-1794(ra) # 800061d8 <release>

  return target - n;
    800058e2:	413b053b          	subw	a0,s6,s3
    800058e6:	a811                	j	800058fa <consoleread+0xea>
        release(&cons.lock);
    800058e8:	0001c517          	auipc	a0,0x1c
    800058ec:	3a850513          	addi	a0,a0,936 # 80021c90 <cons>
    800058f0:	00001097          	auipc	ra,0x1
    800058f4:	8e8080e7          	jalr	-1816(ra) # 800061d8 <release>
        return -1;
    800058f8:	557d                	li	a0,-1
}
    800058fa:	70a6                	ld	ra,104(sp)
    800058fc:	7406                	ld	s0,96(sp)
    800058fe:	64e6                	ld	s1,88(sp)
    80005900:	6946                	ld	s2,80(sp)
    80005902:	69a6                	ld	s3,72(sp)
    80005904:	6a06                	ld	s4,64(sp)
    80005906:	7ae2                	ld	s5,56(sp)
    80005908:	7b42                	ld	s6,48(sp)
    8000590a:	7ba2                	ld	s7,40(sp)
    8000590c:	7c02                	ld	s8,32(sp)
    8000590e:	6ce2                	ld	s9,24(sp)
    80005910:	6d42                	ld	s10,16(sp)
    80005912:	6165                	addi	sp,sp,112
    80005914:	8082                	ret
      if(n < target){
    80005916:	0009871b          	sext.w	a4,s3
    8000591a:	fb677ce3          	bgeu	a4,s6,800058d2 <consoleread+0xc2>
        cons.r--;
    8000591e:	0001c717          	auipc	a4,0x1c
    80005922:	40f72523          	sw	a5,1034(a4) # 80021d28 <cons+0x98>
    80005926:	b775                	j	800058d2 <consoleread+0xc2>

0000000080005928 <consputc>:
{
    80005928:	1141                	addi	sp,sp,-16
    8000592a:	e406                	sd	ra,8(sp)
    8000592c:	e022                	sd	s0,0(sp)
    8000592e:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005930:	10000793          	li	a5,256
    80005934:	00f50a63          	beq	a0,a5,80005948 <consputc+0x20>
    uartputc_sync(c);
    80005938:	00000097          	auipc	ra,0x0
    8000593c:	560080e7          	jalr	1376(ra) # 80005e98 <uartputc_sync>
}
    80005940:	60a2                	ld	ra,8(sp)
    80005942:	6402                	ld	s0,0(sp)
    80005944:	0141                	addi	sp,sp,16
    80005946:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005948:	4521                	li	a0,8
    8000594a:	00000097          	auipc	ra,0x0
    8000594e:	54e080e7          	jalr	1358(ra) # 80005e98 <uartputc_sync>
    80005952:	02000513          	li	a0,32
    80005956:	00000097          	auipc	ra,0x0
    8000595a:	542080e7          	jalr	1346(ra) # 80005e98 <uartputc_sync>
    8000595e:	4521                	li	a0,8
    80005960:	00000097          	auipc	ra,0x0
    80005964:	538080e7          	jalr	1336(ra) # 80005e98 <uartputc_sync>
    80005968:	bfe1                	j	80005940 <consputc+0x18>

000000008000596a <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    8000596a:	1101                	addi	sp,sp,-32
    8000596c:	ec06                	sd	ra,24(sp)
    8000596e:	e822                	sd	s0,16(sp)
    80005970:	e426                	sd	s1,8(sp)
    80005972:	e04a                	sd	s2,0(sp)
    80005974:	1000                	addi	s0,sp,32
    80005976:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005978:	0001c517          	auipc	a0,0x1c
    8000597c:	31850513          	addi	a0,a0,792 # 80021c90 <cons>
    80005980:	00000097          	auipc	ra,0x0
    80005984:	7a4080e7          	jalr	1956(ra) # 80006124 <acquire>

  switch(c){
    80005988:	47d5                	li	a5,21
    8000598a:	0af48663          	beq	s1,a5,80005a36 <consoleintr+0xcc>
    8000598e:	0297ca63          	blt	a5,s1,800059c2 <consoleintr+0x58>
    80005992:	47a1                	li	a5,8
    80005994:	0ef48763          	beq	s1,a5,80005a82 <consoleintr+0x118>
    80005998:	47c1                	li	a5,16
    8000599a:	10f49a63          	bne	s1,a5,80005aae <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    8000599e:	ffffc097          	auipc	ra,0xffffc
    800059a2:	06e080e7          	jalr	110(ra) # 80001a0c <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800059a6:	0001c517          	auipc	a0,0x1c
    800059aa:	2ea50513          	addi	a0,a0,746 # 80021c90 <cons>
    800059ae:	00001097          	auipc	ra,0x1
    800059b2:	82a080e7          	jalr	-2006(ra) # 800061d8 <release>
}
    800059b6:	60e2                	ld	ra,24(sp)
    800059b8:	6442                	ld	s0,16(sp)
    800059ba:	64a2                	ld	s1,8(sp)
    800059bc:	6902                	ld	s2,0(sp)
    800059be:	6105                	addi	sp,sp,32
    800059c0:	8082                	ret
  switch(c){
    800059c2:	07f00793          	li	a5,127
    800059c6:	0af48e63          	beq	s1,a5,80005a82 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800059ca:	0001c717          	auipc	a4,0x1c
    800059ce:	2c670713          	addi	a4,a4,710 # 80021c90 <cons>
    800059d2:	0a072783          	lw	a5,160(a4)
    800059d6:	09872703          	lw	a4,152(a4)
    800059da:	9f99                	subw	a5,a5,a4
    800059dc:	07f00713          	li	a4,127
    800059e0:	fcf763e3          	bltu	a4,a5,800059a6 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    800059e4:	47b5                	li	a5,13
    800059e6:	0cf48763          	beq	s1,a5,80005ab4 <consoleintr+0x14a>
      consputc(c);
    800059ea:	8526                	mv	a0,s1
    800059ec:	00000097          	auipc	ra,0x0
    800059f0:	f3c080e7          	jalr	-196(ra) # 80005928 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800059f4:	0001c797          	auipc	a5,0x1c
    800059f8:	29c78793          	addi	a5,a5,668 # 80021c90 <cons>
    800059fc:	0a07a683          	lw	a3,160(a5)
    80005a00:	0016871b          	addiw	a4,a3,1
    80005a04:	0007061b          	sext.w	a2,a4
    80005a08:	0ae7a023          	sw	a4,160(a5)
    80005a0c:	07f6f693          	andi	a3,a3,127
    80005a10:	97b6                	add	a5,a5,a3
    80005a12:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005a16:	47a9                	li	a5,10
    80005a18:	0cf48563          	beq	s1,a5,80005ae2 <consoleintr+0x178>
    80005a1c:	4791                	li	a5,4
    80005a1e:	0cf48263          	beq	s1,a5,80005ae2 <consoleintr+0x178>
    80005a22:	0001c797          	auipc	a5,0x1c
    80005a26:	3067a783          	lw	a5,774(a5) # 80021d28 <cons+0x98>
    80005a2a:	9f1d                	subw	a4,a4,a5
    80005a2c:	08000793          	li	a5,128
    80005a30:	f6f71be3          	bne	a4,a5,800059a6 <consoleintr+0x3c>
    80005a34:	a07d                	j	80005ae2 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005a36:	0001c717          	auipc	a4,0x1c
    80005a3a:	25a70713          	addi	a4,a4,602 # 80021c90 <cons>
    80005a3e:	0a072783          	lw	a5,160(a4)
    80005a42:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005a46:	0001c497          	auipc	s1,0x1c
    80005a4a:	24a48493          	addi	s1,s1,586 # 80021c90 <cons>
    while(cons.e != cons.w &&
    80005a4e:	4929                	li	s2,10
    80005a50:	f4f70be3          	beq	a4,a5,800059a6 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005a54:	37fd                	addiw	a5,a5,-1
    80005a56:	07f7f713          	andi	a4,a5,127
    80005a5a:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005a5c:	01874703          	lbu	a4,24(a4)
    80005a60:	f52703e3          	beq	a4,s2,800059a6 <consoleintr+0x3c>
      cons.e--;
    80005a64:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005a68:	10000513          	li	a0,256
    80005a6c:	00000097          	auipc	ra,0x0
    80005a70:	ebc080e7          	jalr	-324(ra) # 80005928 <consputc>
    while(cons.e != cons.w &&
    80005a74:	0a04a783          	lw	a5,160(s1)
    80005a78:	09c4a703          	lw	a4,156(s1)
    80005a7c:	fcf71ce3          	bne	a4,a5,80005a54 <consoleintr+0xea>
    80005a80:	b71d                	j	800059a6 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005a82:	0001c717          	auipc	a4,0x1c
    80005a86:	20e70713          	addi	a4,a4,526 # 80021c90 <cons>
    80005a8a:	0a072783          	lw	a5,160(a4)
    80005a8e:	09c72703          	lw	a4,156(a4)
    80005a92:	f0f70ae3          	beq	a4,a5,800059a6 <consoleintr+0x3c>
      cons.e--;
    80005a96:	37fd                	addiw	a5,a5,-1
    80005a98:	0001c717          	auipc	a4,0x1c
    80005a9c:	28f72c23          	sw	a5,664(a4) # 80021d30 <cons+0xa0>
      consputc(BACKSPACE);
    80005aa0:	10000513          	li	a0,256
    80005aa4:	00000097          	auipc	ra,0x0
    80005aa8:	e84080e7          	jalr	-380(ra) # 80005928 <consputc>
    80005aac:	bded                	j	800059a6 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005aae:	ee048ce3          	beqz	s1,800059a6 <consoleintr+0x3c>
    80005ab2:	bf21                	j	800059ca <consoleintr+0x60>
      consputc(c);
    80005ab4:	4529                	li	a0,10
    80005ab6:	00000097          	auipc	ra,0x0
    80005aba:	e72080e7          	jalr	-398(ra) # 80005928 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005abe:	0001c797          	auipc	a5,0x1c
    80005ac2:	1d278793          	addi	a5,a5,466 # 80021c90 <cons>
    80005ac6:	0a07a703          	lw	a4,160(a5)
    80005aca:	0017069b          	addiw	a3,a4,1
    80005ace:	0006861b          	sext.w	a2,a3
    80005ad2:	0ad7a023          	sw	a3,160(a5)
    80005ad6:	07f77713          	andi	a4,a4,127
    80005ada:	97ba                	add	a5,a5,a4
    80005adc:	4729                	li	a4,10
    80005ade:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005ae2:	0001c797          	auipc	a5,0x1c
    80005ae6:	24c7a523          	sw	a2,586(a5) # 80021d2c <cons+0x9c>
        wakeup(&cons.r);
    80005aea:	0001c517          	auipc	a0,0x1c
    80005aee:	23e50513          	addi	a0,a0,574 # 80021d28 <cons+0x98>
    80005af2:	ffffc097          	auipc	ra,0xffffc
    80005af6:	aca080e7          	jalr	-1334(ra) # 800015bc <wakeup>
    80005afa:	b575                	j	800059a6 <consoleintr+0x3c>

0000000080005afc <consoleinit>:

void
consoleinit(void)
{
    80005afc:	1141                	addi	sp,sp,-16
    80005afe:	e406                	sd	ra,8(sp)
    80005b00:	e022                	sd	s0,0(sp)
    80005b02:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005b04:	00003597          	auipc	a1,0x3
    80005b08:	cfc58593          	addi	a1,a1,-772 # 80008800 <syscalls+0x3f0>
    80005b0c:	0001c517          	auipc	a0,0x1c
    80005b10:	18450513          	addi	a0,a0,388 # 80021c90 <cons>
    80005b14:	00000097          	auipc	ra,0x0
    80005b18:	580080e7          	jalr	1408(ra) # 80006094 <initlock>

  uartinit();
    80005b1c:	00000097          	auipc	ra,0x0
    80005b20:	32c080e7          	jalr	812(ra) # 80005e48 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005b24:	00013797          	auipc	a5,0x13
    80005b28:	e9478793          	addi	a5,a5,-364 # 800189b8 <devsw>
    80005b2c:	00000717          	auipc	a4,0x0
    80005b30:	ce470713          	addi	a4,a4,-796 # 80005810 <consoleread>
    80005b34:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005b36:	00000717          	auipc	a4,0x0
    80005b3a:	c7670713          	addi	a4,a4,-906 # 800057ac <consolewrite>
    80005b3e:	ef98                	sd	a4,24(a5)
}
    80005b40:	60a2                	ld	ra,8(sp)
    80005b42:	6402                	ld	s0,0(sp)
    80005b44:	0141                	addi	sp,sp,16
    80005b46:	8082                	ret

0000000080005b48 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005b48:	7179                	addi	sp,sp,-48
    80005b4a:	f406                	sd	ra,40(sp)
    80005b4c:	f022                	sd	s0,32(sp)
    80005b4e:	ec26                	sd	s1,24(sp)
    80005b50:	e84a                	sd	s2,16(sp)
    80005b52:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005b54:	c219                	beqz	a2,80005b5a <printint+0x12>
    80005b56:	08054763          	bltz	a0,80005be4 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80005b5a:	2501                	sext.w	a0,a0
    80005b5c:	4881                	li	a7,0
    80005b5e:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005b62:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005b64:	2581                	sext.w	a1,a1
    80005b66:	00003617          	auipc	a2,0x3
    80005b6a:	cca60613          	addi	a2,a2,-822 # 80008830 <digits>
    80005b6e:	883a                	mv	a6,a4
    80005b70:	2705                	addiw	a4,a4,1
    80005b72:	02b577bb          	remuw	a5,a0,a1
    80005b76:	1782                	slli	a5,a5,0x20
    80005b78:	9381                	srli	a5,a5,0x20
    80005b7a:	97b2                	add	a5,a5,a2
    80005b7c:	0007c783          	lbu	a5,0(a5)
    80005b80:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005b84:	0005079b          	sext.w	a5,a0
    80005b88:	02b5553b          	divuw	a0,a0,a1
    80005b8c:	0685                	addi	a3,a3,1
    80005b8e:	feb7f0e3          	bgeu	a5,a1,80005b6e <printint+0x26>

  if(sign)
    80005b92:	00088c63          	beqz	a7,80005baa <printint+0x62>
    buf[i++] = '-';
    80005b96:	fe070793          	addi	a5,a4,-32
    80005b9a:	00878733          	add	a4,a5,s0
    80005b9e:	02d00793          	li	a5,45
    80005ba2:	fef70823          	sb	a5,-16(a4)
    80005ba6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005baa:	02e05763          	blez	a4,80005bd8 <printint+0x90>
    80005bae:	fd040793          	addi	a5,s0,-48
    80005bb2:	00e784b3          	add	s1,a5,a4
    80005bb6:	fff78913          	addi	s2,a5,-1
    80005bba:	993a                	add	s2,s2,a4
    80005bbc:	377d                	addiw	a4,a4,-1
    80005bbe:	1702                	slli	a4,a4,0x20
    80005bc0:	9301                	srli	a4,a4,0x20
    80005bc2:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005bc6:	fff4c503          	lbu	a0,-1(s1)
    80005bca:	00000097          	auipc	ra,0x0
    80005bce:	d5e080e7          	jalr	-674(ra) # 80005928 <consputc>
  while(--i >= 0)
    80005bd2:	14fd                	addi	s1,s1,-1
    80005bd4:	ff2499e3          	bne	s1,s2,80005bc6 <printint+0x7e>
}
    80005bd8:	70a2                	ld	ra,40(sp)
    80005bda:	7402                	ld	s0,32(sp)
    80005bdc:	64e2                	ld	s1,24(sp)
    80005bde:	6942                	ld	s2,16(sp)
    80005be0:	6145                	addi	sp,sp,48
    80005be2:	8082                	ret
    x = -xx;
    80005be4:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005be8:	4885                	li	a7,1
    x = -xx;
    80005bea:	bf95                	j	80005b5e <printint+0x16>

0000000080005bec <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005bec:	1101                	addi	sp,sp,-32
    80005bee:	ec06                	sd	ra,24(sp)
    80005bf0:	e822                	sd	s0,16(sp)
    80005bf2:	e426                	sd	s1,8(sp)
    80005bf4:	1000                	addi	s0,sp,32
    80005bf6:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005bf8:	0001c797          	auipc	a5,0x1c
    80005bfc:	1407ac23          	sw	zero,344(a5) # 80021d50 <pr+0x18>
  printf("panic: ");
    80005c00:	00003517          	auipc	a0,0x3
    80005c04:	c0850513          	addi	a0,a0,-1016 # 80008808 <syscalls+0x3f8>
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	02e080e7          	jalr	46(ra) # 80005c36 <printf>
  printf(s);
    80005c10:	8526                	mv	a0,s1
    80005c12:	00000097          	auipc	ra,0x0
    80005c16:	024080e7          	jalr	36(ra) # 80005c36 <printf>
  printf("\n");
    80005c1a:	00002517          	auipc	a0,0x2
    80005c1e:	42e50513          	addi	a0,a0,1070 # 80008048 <etext+0x48>
    80005c22:	00000097          	auipc	ra,0x0
    80005c26:	014080e7          	jalr	20(ra) # 80005c36 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005c2a:	4785                	li	a5,1
    80005c2c:	00003717          	auipc	a4,0x3
    80005c30:	cef72023          	sw	a5,-800(a4) # 8000890c <panicked>
  for(;;)
    80005c34:	a001                	j	80005c34 <panic+0x48>

0000000080005c36 <printf>:
{
    80005c36:	7131                	addi	sp,sp,-192
    80005c38:	fc86                	sd	ra,120(sp)
    80005c3a:	f8a2                	sd	s0,112(sp)
    80005c3c:	f4a6                	sd	s1,104(sp)
    80005c3e:	f0ca                	sd	s2,96(sp)
    80005c40:	ecce                	sd	s3,88(sp)
    80005c42:	e8d2                	sd	s4,80(sp)
    80005c44:	e4d6                	sd	s5,72(sp)
    80005c46:	e0da                	sd	s6,64(sp)
    80005c48:	fc5e                	sd	s7,56(sp)
    80005c4a:	f862                	sd	s8,48(sp)
    80005c4c:	f466                	sd	s9,40(sp)
    80005c4e:	f06a                	sd	s10,32(sp)
    80005c50:	ec6e                	sd	s11,24(sp)
    80005c52:	0100                	addi	s0,sp,128
    80005c54:	8a2a                	mv	s4,a0
    80005c56:	e40c                	sd	a1,8(s0)
    80005c58:	e810                	sd	a2,16(s0)
    80005c5a:	ec14                	sd	a3,24(s0)
    80005c5c:	f018                	sd	a4,32(s0)
    80005c5e:	f41c                	sd	a5,40(s0)
    80005c60:	03043823          	sd	a6,48(s0)
    80005c64:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005c68:	0001cd97          	auipc	s11,0x1c
    80005c6c:	0e8dad83          	lw	s11,232(s11) # 80021d50 <pr+0x18>
  if(locking)
    80005c70:	020d9b63          	bnez	s11,80005ca6 <printf+0x70>
  if (fmt == 0)
    80005c74:	040a0263          	beqz	s4,80005cb8 <printf+0x82>
  va_start(ap, fmt);
    80005c78:	00840793          	addi	a5,s0,8
    80005c7c:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005c80:	000a4503          	lbu	a0,0(s4)
    80005c84:	14050f63          	beqz	a0,80005de2 <printf+0x1ac>
    80005c88:	4981                	li	s3,0
    if(c != '%'){
    80005c8a:	02500a93          	li	s5,37
    switch(c){
    80005c8e:	07000b93          	li	s7,112
  consputc('x');
    80005c92:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005c94:	00003b17          	auipc	s6,0x3
    80005c98:	b9cb0b13          	addi	s6,s6,-1124 # 80008830 <digits>
    switch(c){
    80005c9c:	07300c93          	li	s9,115
    80005ca0:	06400c13          	li	s8,100
    80005ca4:	a82d                	j	80005cde <printf+0xa8>
    acquire(&pr.lock);
    80005ca6:	0001c517          	auipc	a0,0x1c
    80005caa:	09250513          	addi	a0,a0,146 # 80021d38 <pr>
    80005cae:	00000097          	auipc	ra,0x0
    80005cb2:	476080e7          	jalr	1142(ra) # 80006124 <acquire>
    80005cb6:	bf7d                	j	80005c74 <printf+0x3e>
    panic("null fmt");
    80005cb8:	00003517          	auipc	a0,0x3
    80005cbc:	b6050513          	addi	a0,a0,-1184 # 80008818 <syscalls+0x408>
    80005cc0:	00000097          	auipc	ra,0x0
    80005cc4:	f2c080e7          	jalr	-212(ra) # 80005bec <panic>
      consputc(c);
    80005cc8:	00000097          	auipc	ra,0x0
    80005ccc:	c60080e7          	jalr	-928(ra) # 80005928 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005cd0:	2985                	addiw	s3,s3,1
    80005cd2:	013a07b3          	add	a5,s4,s3
    80005cd6:	0007c503          	lbu	a0,0(a5)
    80005cda:	10050463          	beqz	a0,80005de2 <printf+0x1ac>
    if(c != '%'){
    80005cde:	ff5515e3          	bne	a0,s5,80005cc8 <printf+0x92>
    c = fmt[++i] & 0xff;
    80005ce2:	2985                	addiw	s3,s3,1
    80005ce4:	013a07b3          	add	a5,s4,s3
    80005ce8:	0007c783          	lbu	a5,0(a5)
    80005cec:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005cf0:	cbed                	beqz	a5,80005de2 <printf+0x1ac>
    switch(c){
    80005cf2:	05778a63          	beq	a5,s7,80005d46 <printf+0x110>
    80005cf6:	02fbf663          	bgeu	s7,a5,80005d22 <printf+0xec>
    80005cfa:	09978863          	beq	a5,s9,80005d8a <printf+0x154>
    80005cfe:	07800713          	li	a4,120
    80005d02:	0ce79563          	bne	a5,a4,80005dcc <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80005d06:	f8843783          	ld	a5,-120(s0)
    80005d0a:	00878713          	addi	a4,a5,8
    80005d0e:	f8e43423          	sd	a4,-120(s0)
    80005d12:	4605                	li	a2,1
    80005d14:	85ea                	mv	a1,s10
    80005d16:	4388                	lw	a0,0(a5)
    80005d18:	00000097          	auipc	ra,0x0
    80005d1c:	e30080e7          	jalr	-464(ra) # 80005b48 <printint>
      break;
    80005d20:	bf45                	j	80005cd0 <printf+0x9a>
    switch(c){
    80005d22:	09578f63          	beq	a5,s5,80005dc0 <printf+0x18a>
    80005d26:	0b879363          	bne	a5,s8,80005dcc <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80005d2a:	f8843783          	ld	a5,-120(s0)
    80005d2e:	00878713          	addi	a4,a5,8
    80005d32:	f8e43423          	sd	a4,-120(s0)
    80005d36:	4605                	li	a2,1
    80005d38:	45a9                	li	a1,10
    80005d3a:	4388                	lw	a0,0(a5)
    80005d3c:	00000097          	auipc	ra,0x0
    80005d40:	e0c080e7          	jalr	-500(ra) # 80005b48 <printint>
      break;
    80005d44:	b771                	j	80005cd0 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005d46:	f8843783          	ld	a5,-120(s0)
    80005d4a:	00878713          	addi	a4,a5,8
    80005d4e:	f8e43423          	sd	a4,-120(s0)
    80005d52:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005d56:	03000513          	li	a0,48
    80005d5a:	00000097          	auipc	ra,0x0
    80005d5e:	bce080e7          	jalr	-1074(ra) # 80005928 <consputc>
  consputc('x');
    80005d62:	07800513          	li	a0,120
    80005d66:	00000097          	auipc	ra,0x0
    80005d6a:	bc2080e7          	jalr	-1086(ra) # 80005928 <consputc>
    80005d6e:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005d70:	03c95793          	srli	a5,s2,0x3c
    80005d74:	97da                	add	a5,a5,s6
    80005d76:	0007c503          	lbu	a0,0(a5)
    80005d7a:	00000097          	auipc	ra,0x0
    80005d7e:	bae080e7          	jalr	-1106(ra) # 80005928 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005d82:	0912                	slli	s2,s2,0x4
    80005d84:	34fd                	addiw	s1,s1,-1
    80005d86:	f4ed                	bnez	s1,80005d70 <printf+0x13a>
    80005d88:	b7a1                	j	80005cd0 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005d8a:	f8843783          	ld	a5,-120(s0)
    80005d8e:	00878713          	addi	a4,a5,8
    80005d92:	f8e43423          	sd	a4,-120(s0)
    80005d96:	6384                	ld	s1,0(a5)
    80005d98:	cc89                	beqz	s1,80005db2 <printf+0x17c>
      for(; *s; s++)
    80005d9a:	0004c503          	lbu	a0,0(s1)
    80005d9e:	d90d                	beqz	a0,80005cd0 <printf+0x9a>
        consputc(*s);
    80005da0:	00000097          	auipc	ra,0x0
    80005da4:	b88080e7          	jalr	-1144(ra) # 80005928 <consputc>
      for(; *s; s++)
    80005da8:	0485                	addi	s1,s1,1
    80005daa:	0004c503          	lbu	a0,0(s1)
    80005dae:	f96d                	bnez	a0,80005da0 <printf+0x16a>
    80005db0:	b705                	j	80005cd0 <printf+0x9a>
        s = "(null)";
    80005db2:	00003497          	auipc	s1,0x3
    80005db6:	a5e48493          	addi	s1,s1,-1442 # 80008810 <syscalls+0x400>
      for(; *s; s++)
    80005dba:	02800513          	li	a0,40
    80005dbe:	b7cd                	j	80005da0 <printf+0x16a>
      consputc('%');
    80005dc0:	8556                	mv	a0,s5
    80005dc2:	00000097          	auipc	ra,0x0
    80005dc6:	b66080e7          	jalr	-1178(ra) # 80005928 <consputc>
      break;
    80005dca:	b719                	j	80005cd0 <printf+0x9a>
      consputc('%');
    80005dcc:	8556                	mv	a0,s5
    80005dce:	00000097          	auipc	ra,0x0
    80005dd2:	b5a080e7          	jalr	-1190(ra) # 80005928 <consputc>
      consputc(c);
    80005dd6:	8526                	mv	a0,s1
    80005dd8:	00000097          	auipc	ra,0x0
    80005ddc:	b50080e7          	jalr	-1200(ra) # 80005928 <consputc>
      break;
    80005de0:	bdc5                	j	80005cd0 <printf+0x9a>
  if(locking)
    80005de2:	020d9163          	bnez	s11,80005e04 <printf+0x1ce>
}
    80005de6:	70e6                	ld	ra,120(sp)
    80005de8:	7446                	ld	s0,112(sp)
    80005dea:	74a6                	ld	s1,104(sp)
    80005dec:	7906                	ld	s2,96(sp)
    80005dee:	69e6                	ld	s3,88(sp)
    80005df0:	6a46                	ld	s4,80(sp)
    80005df2:	6aa6                	ld	s5,72(sp)
    80005df4:	6b06                	ld	s6,64(sp)
    80005df6:	7be2                	ld	s7,56(sp)
    80005df8:	7c42                	ld	s8,48(sp)
    80005dfa:	7ca2                	ld	s9,40(sp)
    80005dfc:	7d02                	ld	s10,32(sp)
    80005dfe:	6de2                	ld	s11,24(sp)
    80005e00:	6129                	addi	sp,sp,192
    80005e02:	8082                	ret
    release(&pr.lock);
    80005e04:	0001c517          	auipc	a0,0x1c
    80005e08:	f3450513          	addi	a0,a0,-204 # 80021d38 <pr>
    80005e0c:	00000097          	auipc	ra,0x0
    80005e10:	3cc080e7          	jalr	972(ra) # 800061d8 <release>
}
    80005e14:	bfc9                	j	80005de6 <printf+0x1b0>

0000000080005e16 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005e16:	1101                	addi	sp,sp,-32
    80005e18:	ec06                	sd	ra,24(sp)
    80005e1a:	e822                	sd	s0,16(sp)
    80005e1c:	e426                	sd	s1,8(sp)
    80005e1e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005e20:	0001c497          	auipc	s1,0x1c
    80005e24:	f1848493          	addi	s1,s1,-232 # 80021d38 <pr>
    80005e28:	00003597          	auipc	a1,0x3
    80005e2c:	a0058593          	addi	a1,a1,-1536 # 80008828 <syscalls+0x418>
    80005e30:	8526                	mv	a0,s1
    80005e32:	00000097          	auipc	ra,0x0
    80005e36:	262080e7          	jalr	610(ra) # 80006094 <initlock>
  pr.locking = 1;
    80005e3a:	4785                	li	a5,1
    80005e3c:	cc9c                	sw	a5,24(s1)
}
    80005e3e:	60e2                	ld	ra,24(sp)
    80005e40:	6442                	ld	s0,16(sp)
    80005e42:	64a2                	ld	s1,8(sp)
    80005e44:	6105                	addi	sp,sp,32
    80005e46:	8082                	ret

0000000080005e48 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005e48:	1141                	addi	sp,sp,-16
    80005e4a:	e406                	sd	ra,8(sp)
    80005e4c:	e022                	sd	s0,0(sp)
    80005e4e:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005e50:	100007b7          	lui	a5,0x10000
    80005e54:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005e58:	f8000713          	li	a4,-128
    80005e5c:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005e60:	470d                	li	a4,3
    80005e62:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005e66:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005e6a:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005e6e:	469d                	li	a3,7
    80005e70:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005e74:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005e78:	00003597          	auipc	a1,0x3
    80005e7c:	9d058593          	addi	a1,a1,-1584 # 80008848 <digits+0x18>
    80005e80:	0001c517          	auipc	a0,0x1c
    80005e84:	ed850513          	addi	a0,a0,-296 # 80021d58 <uart_tx_lock>
    80005e88:	00000097          	auipc	ra,0x0
    80005e8c:	20c080e7          	jalr	524(ra) # 80006094 <initlock>
}
    80005e90:	60a2                	ld	ra,8(sp)
    80005e92:	6402                	ld	s0,0(sp)
    80005e94:	0141                	addi	sp,sp,16
    80005e96:	8082                	ret

0000000080005e98 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005e98:	1101                	addi	sp,sp,-32
    80005e9a:	ec06                	sd	ra,24(sp)
    80005e9c:	e822                	sd	s0,16(sp)
    80005e9e:	e426                	sd	s1,8(sp)
    80005ea0:	1000                	addi	s0,sp,32
    80005ea2:	84aa                	mv	s1,a0
  push_off();
    80005ea4:	00000097          	auipc	ra,0x0
    80005ea8:	234080e7          	jalr	564(ra) # 800060d8 <push_off>

  if(panicked){
    80005eac:	00003797          	auipc	a5,0x3
    80005eb0:	a607a783          	lw	a5,-1440(a5) # 8000890c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005eb4:	10000737          	lui	a4,0x10000
  if(panicked){
    80005eb8:	c391                	beqz	a5,80005ebc <uartputc_sync+0x24>
    for(;;)
    80005eba:	a001                	j	80005eba <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005ebc:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005ec0:	0207f793          	andi	a5,a5,32
    80005ec4:	dfe5                	beqz	a5,80005ebc <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005ec6:	0ff4f513          	zext.b	a0,s1
    80005eca:	100007b7          	lui	a5,0x10000
    80005ece:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005ed2:	00000097          	auipc	ra,0x0
    80005ed6:	2a6080e7          	jalr	678(ra) # 80006178 <pop_off>
}
    80005eda:	60e2                	ld	ra,24(sp)
    80005edc:	6442                	ld	s0,16(sp)
    80005ede:	64a2                	ld	s1,8(sp)
    80005ee0:	6105                	addi	sp,sp,32
    80005ee2:	8082                	ret

0000000080005ee4 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005ee4:	00003797          	auipc	a5,0x3
    80005ee8:	a2c7b783          	ld	a5,-1492(a5) # 80008910 <uart_tx_r>
    80005eec:	00003717          	auipc	a4,0x3
    80005ef0:	a2c73703          	ld	a4,-1492(a4) # 80008918 <uart_tx_w>
    80005ef4:	06f70a63          	beq	a4,a5,80005f68 <uartstart+0x84>
{
    80005ef8:	7139                	addi	sp,sp,-64
    80005efa:	fc06                	sd	ra,56(sp)
    80005efc:	f822                	sd	s0,48(sp)
    80005efe:	f426                	sd	s1,40(sp)
    80005f00:	f04a                	sd	s2,32(sp)
    80005f02:	ec4e                	sd	s3,24(sp)
    80005f04:	e852                	sd	s4,16(sp)
    80005f06:	e456                	sd	s5,8(sp)
    80005f08:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005f0a:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005f0e:	0001ca17          	auipc	s4,0x1c
    80005f12:	e4aa0a13          	addi	s4,s4,-438 # 80021d58 <uart_tx_lock>
    uart_tx_r += 1;
    80005f16:	00003497          	auipc	s1,0x3
    80005f1a:	9fa48493          	addi	s1,s1,-1542 # 80008910 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80005f1e:	00003997          	auipc	s3,0x3
    80005f22:	9fa98993          	addi	s3,s3,-1542 # 80008918 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005f26:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80005f2a:	02077713          	andi	a4,a4,32
    80005f2e:	c705                	beqz	a4,80005f56 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005f30:	01f7f713          	andi	a4,a5,31
    80005f34:	9752                	add	a4,a4,s4
    80005f36:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80005f3a:	0785                	addi	a5,a5,1
    80005f3c:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80005f3e:	8526                	mv	a0,s1
    80005f40:	ffffb097          	auipc	ra,0xffffb
    80005f44:	67c080e7          	jalr	1660(ra) # 800015bc <wakeup>
    
    WriteReg(THR, c);
    80005f48:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80005f4c:	609c                	ld	a5,0(s1)
    80005f4e:	0009b703          	ld	a4,0(s3)
    80005f52:	fcf71ae3          	bne	a4,a5,80005f26 <uartstart+0x42>
  }
}
    80005f56:	70e2                	ld	ra,56(sp)
    80005f58:	7442                	ld	s0,48(sp)
    80005f5a:	74a2                	ld	s1,40(sp)
    80005f5c:	7902                	ld	s2,32(sp)
    80005f5e:	69e2                	ld	s3,24(sp)
    80005f60:	6a42                	ld	s4,16(sp)
    80005f62:	6aa2                	ld	s5,8(sp)
    80005f64:	6121                	addi	sp,sp,64
    80005f66:	8082                	ret
    80005f68:	8082                	ret

0000000080005f6a <uartputc>:
{
    80005f6a:	7179                	addi	sp,sp,-48
    80005f6c:	f406                	sd	ra,40(sp)
    80005f6e:	f022                	sd	s0,32(sp)
    80005f70:	ec26                	sd	s1,24(sp)
    80005f72:	e84a                	sd	s2,16(sp)
    80005f74:	e44e                	sd	s3,8(sp)
    80005f76:	e052                	sd	s4,0(sp)
    80005f78:	1800                	addi	s0,sp,48
    80005f7a:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80005f7c:	0001c517          	auipc	a0,0x1c
    80005f80:	ddc50513          	addi	a0,a0,-548 # 80021d58 <uart_tx_lock>
    80005f84:	00000097          	auipc	ra,0x0
    80005f88:	1a0080e7          	jalr	416(ra) # 80006124 <acquire>
  if(panicked){
    80005f8c:	00003797          	auipc	a5,0x3
    80005f90:	9807a783          	lw	a5,-1664(a5) # 8000890c <panicked>
    80005f94:	e7c9                	bnez	a5,8000601e <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005f96:	00003717          	auipc	a4,0x3
    80005f9a:	98273703          	ld	a4,-1662(a4) # 80008918 <uart_tx_w>
    80005f9e:	00003797          	auipc	a5,0x3
    80005fa2:	9727b783          	ld	a5,-1678(a5) # 80008910 <uart_tx_r>
    80005fa6:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80005faa:	0001c997          	auipc	s3,0x1c
    80005fae:	dae98993          	addi	s3,s3,-594 # 80021d58 <uart_tx_lock>
    80005fb2:	00003497          	auipc	s1,0x3
    80005fb6:	95e48493          	addi	s1,s1,-1698 # 80008910 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005fba:	00003917          	auipc	s2,0x3
    80005fbe:	95e90913          	addi	s2,s2,-1698 # 80008918 <uart_tx_w>
    80005fc2:	00e79f63          	bne	a5,a4,80005fe0 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80005fc6:	85ce                	mv	a1,s3
    80005fc8:	8526                	mv	a0,s1
    80005fca:	ffffb097          	auipc	ra,0xffffb
    80005fce:	58e080e7          	jalr	1422(ra) # 80001558 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005fd2:	00093703          	ld	a4,0(s2)
    80005fd6:	609c                	ld	a5,0(s1)
    80005fd8:	02078793          	addi	a5,a5,32
    80005fdc:	fee785e3          	beq	a5,a4,80005fc6 <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80005fe0:	0001c497          	auipc	s1,0x1c
    80005fe4:	d7848493          	addi	s1,s1,-648 # 80021d58 <uart_tx_lock>
    80005fe8:	01f77793          	andi	a5,a4,31
    80005fec:	97a6                	add	a5,a5,s1
    80005fee:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80005ff2:	0705                	addi	a4,a4,1
    80005ff4:	00003797          	auipc	a5,0x3
    80005ff8:	92e7b223          	sd	a4,-1756(a5) # 80008918 <uart_tx_w>
  uartstart();
    80005ffc:	00000097          	auipc	ra,0x0
    80006000:	ee8080e7          	jalr	-280(ra) # 80005ee4 <uartstart>
  release(&uart_tx_lock);
    80006004:	8526                	mv	a0,s1
    80006006:	00000097          	auipc	ra,0x0
    8000600a:	1d2080e7          	jalr	466(ra) # 800061d8 <release>
}
    8000600e:	70a2                	ld	ra,40(sp)
    80006010:	7402                	ld	s0,32(sp)
    80006012:	64e2                	ld	s1,24(sp)
    80006014:	6942                	ld	s2,16(sp)
    80006016:	69a2                	ld	s3,8(sp)
    80006018:	6a02                	ld	s4,0(sp)
    8000601a:	6145                	addi	sp,sp,48
    8000601c:	8082                	ret
    for(;;)
    8000601e:	a001                	j	8000601e <uartputc+0xb4>

0000000080006020 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006020:	1141                	addi	sp,sp,-16
    80006022:	e422                	sd	s0,8(sp)
    80006024:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006026:	100007b7          	lui	a5,0x10000
    8000602a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000602e:	8b85                	andi	a5,a5,1
    80006030:	cb81                	beqz	a5,80006040 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    80006032:	100007b7          	lui	a5,0x10000
    80006036:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000603a:	6422                	ld	s0,8(sp)
    8000603c:	0141                	addi	sp,sp,16
    8000603e:	8082                	ret
    return -1;
    80006040:	557d                	li	a0,-1
    80006042:	bfe5                	j	8000603a <uartgetc+0x1a>

0000000080006044 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80006044:	1101                	addi	sp,sp,-32
    80006046:	ec06                	sd	ra,24(sp)
    80006048:	e822                	sd	s0,16(sp)
    8000604a:	e426                	sd	s1,8(sp)
    8000604c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000604e:	54fd                	li	s1,-1
    80006050:	a029                	j	8000605a <uartintr+0x16>
      break;
    consoleintr(c);
    80006052:	00000097          	auipc	ra,0x0
    80006056:	918080e7          	jalr	-1768(ra) # 8000596a <consoleintr>
    int c = uartgetc();
    8000605a:	00000097          	auipc	ra,0x0
    8000605e:	fc6080e7          	jalr	-58(ra) # 80006020 <uartgetc>
    if(c == -1)
    80006062:	fe9518e3          	bne	a0,s1,80006052 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80006066:	0001c497          	auipc	s1,0x1c
    8000606a:	cf248493          	addi	s1,s1,-782 # 80021d58 <uart_tx_lock>
    8000606e:	8526                	mv	a0,s1
    80006070:	00000097          	auipc	ra,0x0
    80006074:	0b4080e7          	jalr	180(ra) # 80006124 <acquire>
  uartstart();
    80006078:	00000097          	auipc	ra,0x0
    8000607c:	e6c080e7          	jalr	-404(ra) # 80005ee4 <uartstart>
  release(&uart_tx_lock);
    80006080:	8526                	mv	a0,s1
    80006082:	00000097          	auipc	ra,0x0
    80006086:	156080e7          	jalr	342(ra) # 800061d8 <release>
}
    8000608a:	60e2                	ld	ra,24(sp)
    8000608c:	6442                	ld	s0,16(sp)
    8000608e:	64a2                	ld	s1,8(sp)
    80006090:	6105                	addi	sp,sp,32
    80006092:	8082                	ret

0000000080006094 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80006094:	1141                	addi	sp,sp,-16
    80006096:	e422                	sd	s0,8(sp)
    80006098:	0800                	addi	s0,sp,16
  lk->name = name;
    8000609a:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    8000609c:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800060a0:	00053823          	sd	zero,16(a0)
}
    800060a4:	6422                	ld	s0,8(sp)
    800060a6:	0141                	addi	sp,sp,16
    800060a8:	8082                	ret

00000000800060aa <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800060aa:	411c                	lw	a5,0(a0)
    800060ac:	e399                	bnez	a5,800060b2 <holding+0x8>
    800060ae:	4501                	li	a0,0
  return r;
}
    800060b0:	8082                	ret
{
    800060b2:	1101                	addi	sp,sp,-32
    800060b4:	ec06                	sd	ra,24(sp)
    800060b6:	e822                	sd	s0,16(sp)
    800060b8:	e426                	sd	s1,8(sp)
    800060ba:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800060bc:	6904                	ld	s1,16(a0)
    800060be:	ffffb097          	auipc	ra,0xffffb
    800060c2:	dd2080e7          	jalr	-558(ra) # 80000e90 <mycpu>
    800060c6:	40a48533          	sub	a0,s1,a0
    800060ca:	00153513          	seqz	a0,a0
}
    800060ce:	60e2                	ld	ra,24(sp)
    800060d0:	6442                	ld	s0,16(sp)
    800060d2:	64a2                	ld	s1,8(sp)
    800060d4:	6105                	addi	sp,sp,32
    800060d6:	8082                	ret

00000000800060d8 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800060d8:	1101                	addi	sp,sp,-32
    800060da:	ec06                	sd	ra,24(sp)
    800060dc:	e822                	sd	s0,16(sp)
    800060de:	e426                	sd	s1,8(sp)
    800060e0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800060e2:	100024f3          	csrr	s1,sstatus
    800060e6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800060ea:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800060ec:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800060f0:	ffffb097          	auipc	ra,0xffffb
    800060f4:	da0080e7          	jalr	-608(ra) # 80000e90 <mycpu>
    800060f8:	5d3c                	lw	a5,120(a0)
    800060fa:	cf89                	beqz	a5,80006114 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800060fc:	ffffb097          	auipc	ra,0xffffb
    80006100:	d94080e7          	jalr	-620(ra) # 80000e90 <mycpu>
    80006104:	5d3c                	lw	a5,120(a0)
    80006106:	2785                	addiw	a5,a5,1
    80006108:	dd3c                	sw	a5,120(a0)
}
    8000610a:	60e2                	ld	ra,24(sp)
    8000610c:	6442                	ld	s0,16(sp)
    8000610e:	64a2                	ld	s1,8(sp)
    80006110:	6105                	addi	sp,sp,32
    80006112:	8082                	ret
    mycpu()->intena = old;
    80006114:	ffffb097          	auipc	ra,0xffffb
    80006118:	d7c080e7          	jalr	-644(ra) # 80000e90 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000611c:	8085                	srli	s1,s1,0x1
    8000611e:	8885                	andi	s1,s1,1
    80006120:	dd64                	sw	s1,124(a0)
    80006122:	bfe9                	j	800060fc <push_off+0x24>

0000000080006124 <acquire>:
{
    80006124:	1101                	addi	sp,sp,-32
    80006126:	ec06                	sd	ra,24(sp)
    80006128:	e822                	sd	s0,16(sp)
    8000612a:	e426                	sd	s1,8(sp)
    8000612c:	1000                	addi	s0,sp,32
    8000612e:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006130:	00000097          	auipc	ra,0x0
    80006134:	fa8080e7          	jalr	-88(ra) # 800060d8 <push_off>
  if(holding(lk))
    80006138:	8526                	mv	a0,s1
    8000613a:	00000097          	auipc	ra,0x0
    8000613e:	f70080e7          	jalr	-144(ra) # 800060aa <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006142:	4705                	li	a4,1
  if(holding(lk))
    80006144:	e115                	bnez	a0,80006168 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006146:	87ba                	mv	a5,a4
    80006148:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000614c:	2781                	sext.w	a5,a5
    8000614e:	ffe5                	bnez	a5,80006146 <acquire+0x22>
  __sync_synchronize();
    80006150:	0ff0000f          	fence
  lk->cpu = mycpu();
    80006154:	ffffb097          	auipc	ra,0xffffb
    80006158:	d3c080e7          	jalr	-708(ra) # 80000e90 <mycpu>
    8000615c:	e888                	sd	a0,16(s1)
}
    8000615e:	60e2                	ld	ra,24(sp)
    80006160:	6442                	ld	s0,16(sp)
    80006162:	64a2                	ld	s1,8(sp)
    80006164:	6105                	addi	sp,sp,32
    80006166:	8082                	ret
    panic("acquire");
    80006168:	00002517          	auipc	a0,0x2
    8000616c:	6e850513          	addi	a0,a0,1768 # 80008850 <digits+0x20>
    80006170:	00000097          	auipc	ra,0x0
    80006174:	a7c080e7          	jalr	-1412(ra) # 80005bec <panic>

0000000080006178 <pop_off>:

void
pop_off(void)
{
    80006178:	1141                	addi	sp,sp,-16
    8000617a:	e406                	sd	ra,8(sp)
    8000617c:	e022                	sd	s0,0(sp)
    8000617e:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006180:	ffffb097          	auipc	ra,0xffffb
    80006184:	d10080e7          	jalr	-752(ra) # 80000e90 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006188:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000618c:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000618e:	e78d                	bnez	a5,800061b8 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006190:	5d3c                	lw	a5,120(a0)
    80006192:	02f05b63          	blez	a5,800061c8 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006196:	37fd                	addiw	a5,a5,-1
    80006198:	0007871b          	sext.w	a4,a5
    8000619c:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    8000619e:	eb09                	bnez	a4,800061b0 <pop_off+0x38>
    800061a0:	5d7c                	lw	a5,124(a0)
    800061a2:	c799                	beqz	a5,800061b0 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800061a4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800061a8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800061ac:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800061b0:	60a2                	ld	ra,8(sp)
    800061b2:	6402                	ld	s0,0(sp)
    800061b4:	0141                	addi	sp,sp,16
    800061b6:	8082                	ret
    panic("pop_off - interruptible");
    800061b8:	00002517          	auipc	a0,0x2
    800061bc:	6a050513          	addi	a0,a0,1696 # 80008858 <digits+0x28>
    800061c0:	00000097          	auipc	ra,0x0
    800061c4:	a2c080e7          	jalr	-1492(ra) # 80005bec <panic>
    panic("pop_off");
    800061c8:	00002517          	auipc	a0,0x2
    800061cc:	6a850513          	addi	a0,a0,1704 # 80008870 <digits+0x40>
    800061d0:	00000097          	auipc	ra,0x0
    800061d4:	a1c080e7          	jalr	-1508(ra) # 80005bec <panic>

00000000800061d8 <release>:
{
    800061d8:	1101                	addi	sp,sp,-32
    800061da:	ec06                	sd	ra,24(sp)
    800061dc:	e822                	sd	s0,16(sp)
    800061de:	e426                	sd	s1,8(sp)
    800061e0:	1000                	addi	s0,sp,32
    800061e2:	84aa                	mv	s1,a0
  if(!holding(lk))
    800061e4:	00000097          	auipc	ra,0x0
    800061e8:	ec6080e7          	jalr	-314(ra) # 800060aa <holding>
    800061ec:	c115                	beqz	a0,80006210 <release+0x38>
  lk->cpu = 0;
    800061ee:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800061f2:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800061f6:	0f50000f          	fence	iorw,ow
    800061fa:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800061fe:	00000097          	auipc	ra,0x0
    80006202:	f7a080e7          	jalr	-134(ra) # 80006178 <pop_off>
}
    80006206:	60e2                	ld	ra,24(sp)
    80006208:	6442                	ld	s0,16(sp)
    8000620a:	64a2                	ld	s1,8(sp)
    8000620c:	6105                	addi	sp,sp,32
    8000620e:	8082                	ret
    panic("release");
    80006210:	00002517          	auipc	a0,0x2
    80006214:	66850513          	addi	a0,a0,1640 # 80008878 <digits+0x48>
    80006218:	00000097          	auipc	ra,0x0
    8000621c:	9d4080e7          	jalr	-1580(ra) # 80005bec <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0)
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0)
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
