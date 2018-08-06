---Quản lý giáo vụ
--- CAU 15 Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT HV.MAHV, HV.HO, HV.TEN, MH.TENMH
FROM HOCVIEN HV, KETQUATHI KQ, MONHOC MH
WHERE HV.MAHV = KQ.MAHV
AND MH.MAMH = KQ.MAMH
AND HV.MALOP = 'k11'
AND KQ.Diem = 'Khong dat'
GROUP BY HV.MAHV, HV.HO, HV.TEN, MH.TENMH
HAVING COUNT(KQ.LANTHI) = 3
UNION
SELECT HV.MAHV, HV.HO, HV.TEN, MH.TENMH
FROM HOCVIEN HV, KETQUATHI KQ, MONHOC MH
WHERE HV.MAHV = KQ.MAHV
AND MH.MAMH = KQ.MAMH
AND HV.MALOP = 'k11'
AND KQ.Diem = 'Khong dat'
GROUP BY HV.MAHV, HV.HO, HV.TEN, KQ.MAMH
HAVING COUNT(KQ.LANTHI) = 3 
---CAU 16 Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT GV.MAGV, GV.HOTEN, GD.HOCKY, GD.NAMHOC
FROM GIAOVIEN GV, GIANGDAY GD
WHERE GV.MAGV = GD.MAGV
AND GD.MAMH = 'CTRR'
GROUP BY GV.MAGV, GV.HOTEN, GD.HOCKY, GD.NAMHOC
HAVING COUNT(GD.MALOP) >= 2
---CAU 17 Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT HV.MAHV, HV.HO, HV.TEN, KQ.DIEM, KQ.LANTHI
FROM HOCVIEN HV, KETQUATHI KQ
WHERE HV.MAHV = KQ.MAHV
AND KQ.MAMH = 'CSDL'
AND KQ.LANTHI >= ALL(SELECT KQ1.LANTHI 
					FROM KETQUATHI KQ1
					WHERE KQ1.MAMH = 'CSDL'
					AND KQ1.MAHV = KQ.MAHV)
---CAU 18 Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT HV.MAHV, HV.HO, HV.TEN, KQ.DIEM, KQ.LANTHI
FROM HOCVIEN HV, KETQUATHI KQ, MONHOC MH
WHERE HV.MAHV = KQ.MAHV
AND KQ.MAMH = MH.MAMH
AND MH.TENMH = 'Co So Du Lieu'
AND KQ.DIEM >= ALL(SELECT KQ1.DIEM
					FROM KETQUATHI KQ1
					WHERE KQ1.MAMH = KQ.MAMH
					AND KQ1.MAHV = KQ.MAHV)
					
--CAU 19 Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT K.MAKHOA, K.TENKHOA
FROM KHOA K
WHERE K.NGAYTL = (SELECT MIN(NGAYTL) FROM KHOA)

SELECT K.MAKHOA, K.TENKHOA
FROM KHOA K
WHERE K.NGAYTL <= ALL(SELECT NGAYTL FROM KHOA)

---CAU 20 Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(*) 
FROM GIAOVIEN GV
WHERE GV.HOCHAM IN('GS', 'PGS')

---CAU 21 Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT K.TENKHOA,COUNT(GV.MAGV)SL_GV
FROM GIAOVIEN GV, KHOA K
WHERE GV.HOCVI IN('CN','KS','Ths','PTS')
AND GV.MAKHOA = K.MAKHOA
GROUP BY  K.TENKHOA
--CAU 22 Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MH.TENMH, KQ.KETQUA, COUNT(KQ.MAHV) SL
FROM MONHOC MH, KETQUATHI KQ
WHERE MH.MAMH = KQ.MAMH
GROUP BY MH.TENMH, KQ.KETQUA
ORDER BY MH.TENMH, KQ.KETQUA

