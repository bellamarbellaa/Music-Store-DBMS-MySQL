INSERT INTO MsBranch
VALUES
    ('BR001','Cabang Harmoni','Jl. Harmoni Raya No. 10','021-8881111'),
    ('BR002','Cabang Sejahtera','Jl. Sejahtera Sehat Selalu No. 88','022-2008972'),
    ('BR003','Cabang Adil','Jl. Adil No. 33','021-8983234'),
    ('BR004','Cabang Makmur','Jl. Gang Makmur No. 12','021-6526321'),
    ('BR005','Cabang Damai','Jl. Damai Aman Sentosa No. 45','044-8989898');

INSERT INTO MsMusicInsType
VALUES
    ('MT001','Guitar'),
    ('MT002','Piano'),
    ('MT003','Violin'),
    ('MT004','Drum'),
    ('MT005','Keyboard');

INSERT INTO MsEmployee
VALUES
    ('EM001','Kiki Sabrina','Jl. Putar-Putar No.8','022-1239995','F','2000-03-21','7450000','BR003'),
    ('EM002','Marlene Martani','Jl. Gajebo No. 32','022-5675542','F','1988-06-14','4250000','BR002'),
    ('EM003','Rakhmat Suryahadi','Gang Gansing No. 19','021-3451232','M','1988-01-30','3670000','BR002'),
    ('EM004','Suhandi','Jl. Pintu Lima No. 5','022-4519377','M','1985-02-10','5600000','BR003'),
    ('EM005','Lisye Mareta Cahya','Jl. Gang Medan Merdeka No. 25','021-9798123','F','1986-12-12','5400000','BR004'),
    ('EM006','Sofian Chandra','Jl. Putar-Putar No. 12','021-8763445','M','1987-12-11','5500000','BR005'),
    ('EM007','William Salim','Jl. Pusing-Pusing No. 76','022-4859345','M','1987-08-14','5490000','BR004'),
    ('EM008','William Wijaya','Jl. Gichung No. 10','022-7859123','M','1989-11-04','5590000','BR003'),
    ('EM009','Dewi Anggraini','Jl. Melati No. 21','021-6677889','F','1990-03-15','4700000','BR004'),
    ('EM010','Andi Pratama','Jl. Kenanga No. 9','022-9988776','M','1986-07-20','5100000','BR002'),
    ('EM011','Cindy Lestari','Jl. Mawar Indah No. 44','021-4433221','F','1991-01-11','4600000','BR001'),
    ('EM012','Budi Hartono','Jl. Cempaka Raya No. 18','022-1122334','M','1984-09-27','6200000','BR001'),
    ('EM013','Rina Saputri','Jl. Flamboyan No. 7','021-5544332','F','1992-05-09','4800000','BR005');

INSERT INTO MsMusicIns
VALUES
    ('MI001','Yamaha CX-40','11500000','20','MT005'),
    ('MI002','Yamaha KX-5000','5950000','12','MT005'),
    ('MI003','Yamaha C-390','1250000','10','MT001'),
    ('MI004','Excellent P-77','25700000','17','MT003'),
    ('MI005','Board B-123','5650000','30','MT005'),
    ('MI006','Pearl Q-300','9570000','26','MT004'),
    ('MI007','Supernova X-23','4510000','56','MT002'),
    ('MI008','Yamaha Grand X-1','49750000','12','MT003'),
    ('MI009','Roland E-400','7250000','20','MT005'),
    ('MI010','Ibanez RG-250','8750000','15','MT001'),
    ('MI011','Kawai Concert Pro','31500000','8','MT003'),
    ('MI012','Mapex Tornado','11250000','14','MT004'),
    ('MI013','Casio CT-X700','3450000','25','MT005'),
    ('MI014','Fender Stratocaster','18500000','9','MT001'),
    ('MI015','Pearl Master Series','22500000','11','MT004');

INSERT INTO HeaderTransaction
VALUES
    ('TR001','2025-10-02 00:00:00','EM003','Veronica Rusli'),
    ('TR002','2025-10-15 09:50:00','EM008','Richard Parker'),
    ('TR003','2025-10-16 13:26:00','EM005','Steven Michael'),
    ('TR004','2025-11-22 10:55:00','EM004','Anabelle Setiawan Wati'),
    ('TR005','2025-11-25 15:30:00','EM003','Michelle Regina'),
    ('TR006','2025-12-13 08:23:00','EM001','Dian Leslie'),
    ('TR007','2025-12-13 18:19:00','EM001','Cathy N.'),
    ('TR008','2025-12-27 15:21:00','EM006','Stephanie Meyer'),
    ('TR009','2025-01-02 10:28:00','EM007','Michael J.'),
    ('TR010','2025-01-03 12:39:00','EM002','Arnold W.');

INSERT INTO DetailTransaction
VALUES
    ('TR001','MI001','2'),
    ('TR001','MI005','3'),

    ('TR002','MI003','1'),
    ('TR002','MI005','2'),
    ('TR002','MI008','5'),

    ('TR003','MI007','4'),
    ('TR003','MI004','3'),

    ('TR004','MI006','3'),
    ('TR004','MI002','1'),

    ('TR005','MI001','2'),
    ('TR005','MI003','3'),
    ('TR005','MI006','5'),

    ('TR006','MI002','3'),
    ('TR006','MI004','2'),

    ('TR007','MI008','1'),
    ('TR007','MI002','2'),
    ('TR007','MI005','4'),

    ('TR008','MI010','2'),
    ('TR008','MI012','1'),

    ('TR009','MI011','1'),
    ('TR009','MI007','2'),

    ('TR010','MI001','2'),
    ('TR010','MI003','2'),
    ('TR010','MI004','2');


-- Updating Table 
UPDATE MsMusicIns
SET MusicIns = 'Yamaha P-77',
    Price = 22500000
WHERE MusicInsID = 'MI004';

-- Inserting and Deleting Data from Table
DELETE FROM MsMusicIns
WHERE MusicInsID = 'MI004';

INSERT INTO MsMusicIns (MusicInsID, MusicIns, Price, Stock) 
VALUES
	('MI004', 'Yamaha P-77', 22500000, 10);
