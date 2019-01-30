.pos 0x1000
code:
                # v0 = s.x[i]
                ld $v0, r0          # r0 = &v0
                ld $s, r1           # r1 = &s
                ld $i, r2           # r2 = &i
                ld (r2), r2         # r2 = i
                ld (r1, r2, 4), r3  # r3 = s.x[i]           MEMORY READ
                st r3, (r0)         # v0 = s.x[i]
                # 1 memory read

                # v1 = s.y[i]
                ld $v1, r0          # r0 = &v1
                ld $s, r1           # r1 = &s
                ld 0x8(r1), r2      # r2 = s.y              MEMORY READ
                ld $i, r3           # r3 = &i
                ld (r3), r3         # r3 = i
                ld (r2, r3, 4), r4  # r4 = s.y[i]           MEMORY READ
                st r4, (r0)         # v1 = s.y[i]
                # 2 memory reads

                # v2 = s.z->x[i]
                ld $v2, r0          # r0 = &v2
                ld $s, r1           # r1 = &s
                ld 0xc(r1), r2      # r2 = s.z              MEMORY READ
                ld $i, r3           # r3 = &i
                ld (r3), r3         # r3 = i
                ld (r2, r3, 4), r4  # r4 = s.z->x[i]        MEMORY READ
                st r4, (r0)         # v2 = s.z->x[i]
                # 2 memory reads

                # v3 = s.z->z->y[i]
                ld $v3, r0          # r0 = &v3
                ld $s, r1           # r1 = &s
                ld 0xc(r1), r2      # r2 = s.z              MEMORY READ
                ld 0xc(r2), r2      # r2 = s.z->z           MEMORY READ
                ld 0x8(r2), r2      # r2 = & (s.z->z->y[0]) MEMORY READ
                ld $i, r3           # r3 = &i
                ld (r3), r3         # r3 = i
                ld (r2, r3, 4), r4  # r4 = s.z->z->y[i]     MEMORY READ
                st r4, (r0)         # v3 = s.z->z->y[i]
                # 4 memory reads

                halt                     
.pos 0x2000
static:         
i:              .long 1
v0:             .long 0
v1:             .long 0
v2:             .long 0
v3:             .long 0
s:              .long 0                 # s.x[0]
                .long 0                 # s.x[1]
                .long s_y               # s.y
                .long s_z               # s.z

.pos 0x3000
heap:           
s_y:            .long 0                 # s.y[0]
                .long 0                 # s.y[1]
s_z:            .long 0                 # s.z->x[0]
                .long 0                 # s.z->x[1]
                .long 0                 # s.z->y
                .long s_z_z             # s.z->z
s_z_z:          .long 0                 # s.z->z->x[0]
                .long 0                 # s.z->z->x[1]
                .long s_z_z_y           # s.z->z->y
                .long 0                 # s.z->z->z
s_z_z_y:        .long 0                 # s.z->z->y[0]
                .long 0                 # s.z->z->y[1]