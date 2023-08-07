<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Khachhang;
use App\Models\Nhanvien;

class AdminController extends Controller
{
    public function checkLogin(Request $request)
    {
        $username = $request->username;
        $password = $request->password;
        if($username == null||$password == null)
        {
            return redirect()->back()->with(['alert' => 'Tên tài khoản hoặc mật khẩu không được để trống','username' => $username]);
            // return response()->json(var_dump($errors);
        }
        $account = DB::table('employee')->where([['Username','=',$username],['Password','=',md5($password)],['Loại_NV','=','QTV']])->get();
        if(!empty($account[0]))
        {
            session(['admin.islogin' => 1]);
            session(['admin.id' => $account[0]->Mã]);
            session(['admin.name' => $account[0]->Họ_Tên]);
            return redirect('/admin');
        }
        else
		{
            return redirect()->back()->with(['alert' => 'Tài khoản hoặc mật khẩu không đúng','username' => $username]);
        }
    }

    public  function logout()
	{
        session()->forget('admin');
        return redirect()->back();
    }
	
	//Phần thống kê
	public function thongke()
	{
		$slkhachhang = count(DB::table("customer")->select("Mã")->get());
		$slchuyenxe = count(DB::table("chuyen_xe")->select("Mã")->get());
		$slchuyenxedadi = count(DB::table("chuyen_xe")->where('Trạng_thái','=',2)->select("Mã")->get());
		$slchuyenxedangcho = count(DB::table("chuyen_xe")->where('Trạng_thái','=',0)->select("Mã")->get());
		$thongke = DB::table("thong_ke")->where('Năm','=',date("Y"))->orderBy("Tháng","asc")->select("Chi_phí","Doanh_thu","Số_chuyến_xe")->get();
		$thongke1 = DB::table("thong_ke")->where('Năm','=',(date("Y") - 1))->orderBy("Tháng","asc")->select("Chi_phí","Doanh_thu","Số_chuyến_xe")->get();
		$chuyenxe = [];
		$dem = 0;
		$tmp1 = [];
		$tmp2 = [];
		$tongdt = 0;
		for($i=0;$i<count($thongke1);$i++)
		{			
			$tmp1[$i] = $thongke1[$i]->Số_chuyến_xe;
			$tmp2[$i] = $thongke1[$i]->Doanh_thu/1000000;
		}
		$chuyenxe[$dem]=['Năm' => (date("Y") - 1),'Chuyến_xe' => $tmp1,'Doanh_thu' => $tmp2];
		$tmp1 = [];
		$tmp2 = [];
		$dem += 1;
		for($i=0;$i<count($thongke);$i++)
		{			
			$tmp1[$i] = $thongke[$i]->Số_chuyến_xe;
			$tmp2[$i] = $thongke[$i]->Doanh_thu/1000000;
			$tongdt += $thongke[$i]->Doanh_thu;
		}
		$chuyenxe[$dem]=['Năm' => date("Y"),'Chuyến_xe' => $tmp1,'Doanh_thu' => $tmp2];
		return view("quantrivien.thongke",compact("slkhachhang","slchuyenxe","slchuyenxedadi","slchuyenxedangcho","chuyenxe","tongdt"));
	}



    //Phần hàm dùng chung
	public function admin_checkexist(Request $request) 
	{
		$typecheck = $request->typecheck;
		$datacheck = $request->datacheck;
		switch($typecheck)
		{
			case "useremail_create":
				if(count(DB::select("SELECT * FROM customer WHERE Email = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "userphone_create":
				if(count(DB::select("SELECT * FROM customer WHERE Sđt = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "useremail_change":
				if(count(DB::select("SELECT * FROM customer WHERE Email = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM customer WHERE Email = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM customer WHERE Email = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "userphone_change":
				if(count(DB::select("SELECT * FROM customer WHERE Sđt = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM customer WHERE Sđt = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM customer WHERE Sđt = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "employeeusername_create":
				if(count(DB::select("SELECT * FROM employee WHERE Username = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "employeeemail_create":
				if(count(DB::select("SELECT * FROM employee WHERE Email = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "employeephone_create":
				if(count(DB::select("SELECT * FROM employee WHERE Sđt = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "employeeusername_change":
				if(count(DB::select("SELECT * FROM employee WHERE Username = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM employee WHERE Username = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM employee WHERE Username = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "employeeemail_change":
				if(count(DB::select("SELECT * FROM employee WHERE Email = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM employee WHERE Email = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM employee WHERE Email = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "employeephone_change":
				if(count(DB::select("SELECT * FROM employee WHERE Sđt = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM employee WHERE Sđt = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM employee WHERE Sđt = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "employeepassword_change":
				if(count(DB::select("SELECT * FROM employee WHERE Password = ? AND Mã = ?",[md5($datacheck),$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else
				{
					return response()->json(['kq' => 1]);
				}
				break;
			case "bienso_create":
				if(count(DB::select("SELECT * FROM xe WHERE Biển_số = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "bienso_change":
				if(count(DB::select("SELECT * FROM xe WHERE Biển_số = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM xe WHERE Biển_số = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM xe WHERE Biển_số = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			case "tentramdung_create": //Kiểm tra tên trạm dừng khi tạo mới
				if(count(DB::select("SELECT * FROM tram_dung WHERE Tên = ?",[$datacheck])) != 0)
				{
					return response()->json(['kq' => 1]);
				}
				else
				{
					return response()->json(['kq' => 0]);
				}
				break;
			case "tentramdung_change": //Kiểm tra tên trạm dừng khi thay đổi
				if(count(DB::select("SELECT * FROM tram_dung WHERE Tên = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 1)
				{
					return response()->json(['kq' => 0]);
				}
				else if(count(DB::select("SELECT * FROM tram_dung WHERE Tên = ? AND Mã = ?",[$datacheck,$request->idcheck])) == 0)
				{
					if(count(DB::select("SELECT * FROM tram_dung WHERE Tên = ?",[$datacheck])) != 0)
					{
						return response()->json(['kq' => 1]);
					}
					else
					{
						return response()->json(['kq' => 0]);
					}
				}
				break;
			default:
		}
	} 
	public function admin_retrievedata(Request $request)
	{
		switch($request->typedata)
		{
			case 'khachhang':
				try {
					$customer = Khachhang::all();
					return response()->json(['kq' => 1,'data' => $customer]);
				} catch (\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			case 'nhanvien':
				try {
					$employee = Nhanvien::all();
					return response()->json(['kq' => 1,'data' => $employee]);
				} catch (\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			case 'xe':
				try {
					$bus = DB::table('xe')->join('bus_model','xe.Mã_loại_xe','=','bus_model.Mã')
					->select('xe.Mã','xe.Biển_số','xe.Mã_loại_xe','bus_model.Loại_ghế','xe.Ngày_bảo_trì_gần_nhất','xe.Ngày_bảo_trì_tiếp_theo','xe.location')->get();
					return response()->json(['kq' => 1,'data' => $bus]);
				} catch (\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			case 'tramdung':
				try {
					$busstop = DB::table('tram_dung')->join('employee','tram_dung.Mã_nhân_viên_tạo','=','employee.Mã')
					->join('employee as employee1','tram_dung.Mã_nhân_viên_chỉnh_sửa','=','employee1.Mã')
					->select('tram_dung.Mã','tram_dung.Tên','tram_dung.Tọa_độ','tram_dung.Mã_nhân_viên_tạo','tram_dung.Mã_nhân_viên_chỉnh_sửa','employee.Họ_Tên as Nhân_viên_tạo','employee1.Họ_Tên as Nhân_viên_chỉnh_sửa')->get();
					return response()->json(['kq' => 1,'data' => $busstop]);
				} catch (\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			case 'tintuc':
				try {
					$tintuc = DB::table('news')->join('employee as em1','news.id_admin_created','=','em1.Mã')->join('employee as em2','news.id_admin_changed','=','em2.Mã')->select('news.news_id','news.title','news.image','news.introduce','news.content','news.check_slide','news.is_disabled','em1.Họ_Tên as admin_created','em2.Họ_Tên as admin_changed')->orderBy('news.news_id','desc')->get();
					return response()->json(['kq' => 1,'data' => $tintuc]);
				} catch(\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			case 'gioithieu':
				try {
					$gioithieu = DB::table('gioi_thieu')->select('noidung')->get();
					return response()->json(['kq' => 1,'data' => $gioithieu]);
				} catch(\Exception $e) {
					return response()->json(['kq' => 0]);
				}
				break;
			default:
		}
	}
	public function admin_changepassword(Request $request) //Hàm thay đổi mật khẩu
	{
		$id = $request->id;
		$olddata = $request->olddata;
		$newdata = $request->newdata;
		$type = $request->typepassword;
		if($type == "employeepassword")
		{
			if(count(DB::select("SELECT * FROM employee WHERE Password = ? AND Mã = ?",[md5($olddata),$id])) == 1)
			{
				try {
					DB::update("UPDATE `employee` SET Password = ? WHERE Mã = ?",[md5($newdata),$id]);
					return response()->json(['kq' => 1]);
				} catch (\Exception $e) {
					return $e;
				}				
			}
			else
			{
				return response()->json(['kq' => 0]);
			}
		}
	}
}
