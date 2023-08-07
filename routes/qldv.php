<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TicketBookingManager;
use Illuminate\Http\Request;
/* Bắt đầu phần Route cho trang quản lý đặt vé */

Route::get('qldv/login', function(){
    if(session()->has('isadmin')){
        return redirect('qldv/');
    }
    else{
        return view('quanlydatve.login');
    }
});

Route::post('qldv/login', [TicketBookingManager::class,'qldv_checkLogin'])->name('qldv_login');

Route::middleware('qldvcheck')->group(function(){
	Route::get('qldv/logout', [TicketBookingManager::class,'qldv_logout'])->name('qldv_logout');
	Route::get('/qldv', function() {
		return redirect('qldv/datve');
	});

	Route::get('/qldv/giamsat/{id?}', [TicketBookingManager::class,'qldv_giamsat']);

	Route::get('/qldv/datve', [TicketBookingManager::class,'trangdatve']);

	Route::post('/qldv/searchroute', [TicketBookingManager::class,'searchroute'])->name('qldv-searchroute');

	Route::post('/qldv/routedetails', [TicketBookingManager::class,'routedetails'])->name('qldv-routedetails');

	Route::post('/qldv/chonve', [TicketBookingManager::class,'qldv_chonve'])->name('qldv-chonve');

	Route::post('/qldv/huychonve', [TicketBookingManager::class,'qldv_huychonve'])->name('qldv-huychonve');

	Route::post('/qldv/huychonchuyenxe', [TicketBookingManager::class,'qldv_huychonchuyenxe'])->name('qldv-huychonchuyenxe');

	Route::post('/qldv/searchcustomer', [TicketBookingManager::class,'qldv_searchcustomer'])->name('qldv-searchcustomer');

	Route::post('/qldv/infokhachhang', [TicketBookingManager::class,'qldv_infokhachhang'])->name('qldv-infokh');

	Route::post('/qldv/xldatve', [TicketBookingManager::class,'qldv_xldatve'])->name('qldv-datve');

	Route::post('/qldv/xldangky', [TicketBookingManager::class,'qldv_xldangky'])->name('qldv-dangky');
	
	Route::post('qldv/userinfo', [TicketBookingManager::class,'qldv_userinfo'])->name('qldv_userinfo');
	
	Route::get('qldv/sendgps', [TicketBookingManager::class,'qldv_sendgps'])->name('qldv_sendgps');
	
	Route::post('qldv/showhistory', [TicketBookingManager::class,'qldv_showhistory'])->name('qldv_showhistory');
	
	Route::post('qldv/showdetails', [TicketBookingManager::class,'qldv_showdetails'])->name('qldv_showdetails');
	
	Route::post('qldv/huydondatve', [TicketBookingManager::class,'qldv_huydondatve'])->name('qldv_huydondatve');
	
});

/* Kết thúc phần Route cho trang quản lý đặt vé */