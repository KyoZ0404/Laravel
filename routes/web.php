<?php

use App\Http\Controllers\Controller;
use App\Http\Controllers\TicketSuggestion;

/* Bắt đầu phần Route cho trang khách hàng */
    /*Trang chủ*/
    Route::get('/', [Controller::class,'Index'])->name("home");
    /*Trang tìm vé*/
    Route::get('/datve', [Controller::class,'Datve']);
    /* Tìm chuyến xe ở trang chủ*/
    Route::post('/chuyenxe', [Controller::class,'Chuyenxe1'])->name('chuyenxe');
    /*Tìm chuyến xe ở trang đặt vé*/
    Route::post('/chuyenxe1', [Controller::class,'Chuyenxe2'])->name('chuyenxe1');
    /*Chọn vé*/
    Route::get('/chonve/{id}', [Controller::class,'Chonve'])->middleware('checkdangnhap')->name('chonve');
    /*Xử lý chọn vé*/
    Route::post('/xulydatve', [Controller::class,'xulydatve'])->name('xulydatve');
    Route::post('/xulydatve2', [Controller::class,'xulydatve2'])->name('xulydatve2');
    /*Chọn đặt vé*/
    Route::post('/chondatve', [Controller::class,'chondatve'])->name('chondatve');
    /*Thông tin vé*/
    Route::get('/thongtinve/{id}/{makh}', [Controller::class,'thongtinve'])->middleware('checkdangnhap')->name('thongtinve');
    /*Đăng ký*/
    Route::post('/dangky', [Controller::class,'dangky'])->name('dangky');
    /*Đăng nhập*/
    Route::post('/dangnhap', [Controller::class,'dangnhap'])->name('dangnhap');
    /*Đăng xuất*/
    Route::get('logout', function(){
        Request::session()->flush();
        $tinh = DB::select("SELECT Tên FROM tinh");
        return redirect(route("home"));
    })->name('logout');
    /*Thông tin khách*/
    Route::get('thongtin/{makh}', [Controller::class,'thongtin'])->middleware('checkdangnhap')->name('thongtin');
    /*Giới thiệu*/
    Route::get('/gioithieu', [Controller::class,'gioithieu'])->name('gioithieu');
    /*Cập nhật thông tin*/
    Route::post('/capnhattt', [Controller::class,'capnhattt'])->middleware('checkdangnhap')->name('capnhattt');
    /*Đổi mật khẩu*/
    Route::post('/doimatkhau', [Controller::class,'doimatkhau'])->middleware('checkdangnhap')->name('doimatkhau');
    /*Tin tức*/
    Route::get('/tintuc', [Controller::class,'tintuc'])->name('tintuc');
    /*Form tin tức*/
    Route::get('/formtintuc', function(){
        return view('tttn-web.formtintuc');
    } );
    /*Thêm giới thiệu*/
    Route::post('/addgioithieu', [Controller::class,'addgioithieu'])->name('addgioithieu');
    /*Thêm tin tức*/
    Route::post('/addtintuc', [Controller::class,'addtintuc'])->name('addtintuc');
    /*Show tin tức*/
    Route::get('/showtintuc/{id}', [Controller::class,'showtintuc'])->name('showtintuc');
    /*Xử lý liên hệ*/
    Route::post('/xulylienhe', [Controller::class,'xulylienhe'])->name('xulylienhe');
    /*Xử lý đề xuất*/
     Route::post('/xulydx', [Controller::class,'xulydx'])->name('xulydx');
     /*Hủy chọn vé đề xuất*/
     Route::post('/huygiudx', [Controller::class,'huygiudx'])->name('huygiudx');

    Route::get("ticket", [TicketSuggestion::class,'makeMatrix']);
    Route::post("ticket", [TicketSuggestion::class,'makeMatrix'])->name('ticketsuggestion');
/* Kết thúc phần Route cho trang khách hàng */

