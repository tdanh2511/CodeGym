create database tcomplex;
use tcomplex;

CREATE TABLE mat_bang (
    ma VARCHAR(50) PRIMARY KEY,
    trang_thai VARCHAR(20) NOT NULL,
    dien_tich DOUBLE NOT NULL,
    tang INT NOT NULL,
    loai VARCHAR(50) NOT NULL,
    gia BIGINT NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_dien_tich ON mat_bang(dien_tich);
CREATE INDEX idx_loai ON mat_bang(loai);
CREATE INDEX idx_tang ON mat_bang(tang);
CREATE INDEX idx_gia ON mat_bang(gia);