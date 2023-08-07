<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\KhachHangController;
use App\Http\Controllers\NhanVienController;
use App\Http\Controllers\LoaiXeController;
use App\Http\Controllers\XeController;
use App\Http\Controllers\TramDungController;
use App\Http\Controllers\LoTrinhController;
use App\Http\Controllers\TinhController;
use App\Http\Controllers\ChuyenXeController;
use App\Http\Controllers\VeController;
use App\Http\Controllers\TinTucController;
use App\Http\Controllers\LienHeController;
use App\Http\Controllers\TicketSuggestion;

/* Bắt đầu phần Route cho trang quản trị hệ thống */

Route::get('admin/login', function(){
    if(session()->has('admin')){
        return redirect('admin/');
    }
    else{
        return view('quantrivien.login');
    }
});

Route::post('admin/login', [AdminController::class,'checkLogin'])->name('adminlogin');

Route::middleware('admincheck')->group(function (){
    Route::get('admin/logout',[AdminController::class,'logout'])->name('adminlogout');

    Route::get('admin/', [AdminController::class,'thongke']);

    Route::get('admin/thongke', [AdminController::class,'thongke']);

//Phần khách hàng
Route::get('admin/khachhang', [KhachHangController::class,'khachhang']);

Route:: get('admin/addkhachhang/{index?}', [KhachHangController::class,'addkhachhang']);

 Route::post('admin/addcustomer',[KhachHangController::class,'addcustomer'])->name('addcustomer');

 Route::get('admin/delkhachhang/{id}',[KhachHangController::class,'delcustomer']);

 Route::get('admin/viewkhachhang/{id?}',[KhachHangController::class,'viewkhachhang']);

 //Phần nhân viên

 Route::get('admin/nhanvien',[NhanVienController::class,'nhanvien']);

 Route:: get('admin/addnhanvien/{index?}', [NhanVienController::class,'addnhanvien']);

 Route::post('admin/addemployee', [NhanVienController::class,'addemployee'])->name('addemployee');

 Route::get('admin/delnhanvien/{id}', [NhanVienController::class,'delemployee']);
 
 Route::post('admin/userinfo', [NhanVienController::class,'userinfo'])->name('userinfo');

  //Phần loại xe

  Route::get('admin/loaixe',[LoaiXeController::class,'loaixe']);

  Route::post('admin/addbusmodel', [LoaiXeController::class,'addbusmodel'])->name('addbusmodel');

  Route::get('admin/delloaixe/{id}', [LoaiXeController::class,'delbusmodel']);

 //Phần xe

 Route::get('admin/xe',[XeController::class,'xe']);

 Route:: get('admin/addxe/{index?}', [XeController::class,'addxe']);

 Route::post('admin/addbus', [XeController::class,'addbus'])->name('addbus');

 Route::get('admin/delxe/{id}', [XeController::class,'delbus']);

 //Phần trạm dừng

 Route::get('admin/tramdung', [TramDungController::class,'tramdung']);

 Route:: get('admin/addtramdung/{index?}', [TramDungController::class,'addtramdung']);

 Route::post('admin/addbusstop', [TramDungController::class,'addbusstop'])->name('addbusstop');

 Route::get('admin/deltramdung/{id}', [TramDungController::class,'delbusstop']);

 //Phần lộ trình

 Route::get('admin/lotrinh/{cm?}',[LoTrinhController::class,'lotrinh']);

 Route::post('admin/addbusroute', [LoTrinhController::class,'addbusroute'] )->name('addbusroute');

 Route::post('admin/delbusroute', [LoTrinhController::class,'delbusroute'])->name('delbusroute');
 
 Route::post('admin/getlocations', [LoTrinhController::class,'admin_getlocations'])->name("admin_getlocations");

 //Phần tỉnh

 Route::post('admin/addprovince', [TinhController::class,'addprovince'])->name('addprovince');

 Route::post('admin/delprovince', [TinhController::class,'delprovince'])->name('delprovince');


 //Phần chuyến xe

 Route::get('admin/chuyenxe', [ChuyenXeController::class,'chuyenxe']);

 Route::get('admin/addchuyenxe/{id?}', [ChuyenXeController::class,'addchuyenxe']);

 Route::post('admin/addchuyenxexl', [ChuyenXeController::class,'addchuyenxexl'] )->name('addchuyenxexl');

 Route::get('admin/delchuyenxe/{id?}', [ChuyenXeController::class,'delchuyenxe']);

 //Phần vé và reset chuyến xe

 Route::get('admin/ve', [VeController::class,'ve']);

 Route::get('admin/ticket/{index}/{id?}', [VeController::class,'ticket']);

 Route::post('admin/editticket',  [VeController::class,'editticket'])->name('editticket');

 Route::get('admin/delve/{id?}', [VeController::class,'delve']);

 //Phần tin tức

 Route::get('admin/tintuc', [TinTucController::class,'tintuc']);
 
 Route::post('admin/addtintuc', [TinTucController::class,'addtintuc'])->name('addtintuc');
 
 Route::post('admin/edittintuc', [TinTucController::class,'edittintuc'])->name('edittintuc');
 
 Route::get('admin/deltintuc/{id?}', [TinTucController::class,'deltintuc']);

 //Phần giới thiệu

 Route::post('admin/editgioithieu', [TinTucController::class,'editgioithieu'])->name('editgioithieu');

 //Phần hàm dùng chung

 Route::post('admin/checkexist', [AdminController::class,'admin_checkexist'])->name('admin_checkexist');
 
 Route::post('admin/retrievedata', [AdminController::class,'admin_retrievedata']);
 
 Route::post('admin/changepassword', [AdminController::class,'admin_changepassword'])->name('admin_changepassword');
	
});

/* Kết thúc phần Route cho trang quản trị hệ thống */



