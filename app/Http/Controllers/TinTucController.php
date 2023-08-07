<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class TinTucController extends Controller
{
    //Phần tin tức
	public function tintuc()
	{
		try {
			$tintuc = DB::table('news')->join('employee as em1','news.id_admin_created','=','em1.Mã')->join('employee as em2','news.id_admin_changed','=','em2.Mã')->select('news.news_id','news.title','news.image','news.introduce','news.content','news.check_slide','news.is_disabled','em1.Họ_Tên as admin_created','em2.Họ_Tên as admin_changed')->orderBy('news.news_id','desc')->get();
			return view('quantrivien.tintuc',compact('tintuc'));
		} catch (\Exception $e) {
			return $e;
		}
	}
	public function addtintuc(Request $request){
		$idadmin = session("admin.id");
        $tieude = $request->tieude;
        $mota = $request->mota;
        $noidung=$request->noidung;
        $checkslide = $request->isslide;
		$kichhoat = $request->kichhoat;
        $time = date("Y-m-d H:i:s");
		$hinhanh = $request->hinhanh;
		$namehinhanh = strtotime($time)."-".$hinhanh->getClientOriginalName();
		$hinhanh->move('upload',$namehinhanh);
        try {
			DB::table("news")->insert(["title" => $tieude, "image" => $namehinhanh, "introduce" => $mota, "content" => $noidung, "check_slide" => $checkslide, "is_disabled" => $kichhoat, "id_admin_created" => $idadmin, "id_admin_changed" => $idadmin, "created_at" => $time, "updated_at" => $time]);
			return redirect("/admin/tintuc")->with(['alert' => "Thêm thành công!"]);
		} catch (\Exception $e) {
			return $e;
		}
    }
	public function edittintuc(Request $request)
	{
		$idadmin = session("admin.id");
		$idnews = $request->newsid;
		$tieude = $request->tieude;        
        $mota = $request->mota;
        $noidung=$request->noidung;
		$checkslide = $request->isslide;
		$kichhoat = $request->kichhoat;
        $time = date("Y-m-d H:i:s");
		if($request->hinhanh != null)
		{
			$hinhanh = $request->hinhanh;
			$namehinhanh = strtotime($time)."-".$hinhanh->getClientOriginalName();
			$hinhanh->move('upload',$namehinhanh);
		}
        try {
			if($request->hinhanh != null)
			{
				DB::update("UPDATE `news` SET `title` = ?, `image` = ?, `introduce` = ?, `content` = ?, `check_slide` = ?, `is_disabled` = ?, `id_admin_changed` = ?, `updated_at` = ? WHERE `news_id` = ?",[$tieude,$namehinhanh,$mota,$noidung,$checkslide,$kichhoat,$idadmin,$time,$idnews]);
			}
			else
			{
				DB::update("UPDATE `news` SET `title` = ?, `introduce` = ?, `content` = ?, `check_slide` = ?, `is_disabled` = ?, `id_admin_changed` = ?, `updated_at` = ? WHERE `news_id` = ?",[$tieude,$mota,$noidung,$checkslide,$kichhoat,$idadmin,$time,$idnews]);
			}
			return redirect("/admin/tintuc")->with(['alert' => "Sửa thành công!"]);
		} catch(\Exception $e) {
			return $e;
		}
	}
	public function deltintuc($id = "")
	{
		if($id == "")
		{
			return redirect('/admin/tintuc')->with(["alert" => "Đường dẫn không tồn tại!"]);
		}
		else
		{
			try {
                DB::delete('DELETE FROM news WHERE news_id = ?',[$id]);
				return redirect('/admin/tintuc')->with(["alert" => "Xóa thành công!"]);
            } catch (\Exception $e) {
                return $e;
            }
		}
	}
	
	//Phần giới thiệu
	public function editgioithieu(Request $request)
	{
		$idadmin = session("admin.id");
		$noidung = $request->noidunggt;
		$time = date("Y-m-d H:i:s");
		$gt = DB::table("gioi_thieu")->select("gt_id")->get();
		if(empty($gt))
		{
			try {
				DB::table("gioi_thieu")->insert(["noidung" => $noidung, "id_admin_created" => $idadmin, "id_admin_changed" => $idadmin, "created_at" => $time, "updated_at" => $time]);
				return redirect()->back()->with(['alert' => 'Sửa thông tin giới thiệu thành công!']);
			} catch (\Exception $e) {
				return $e;
			}
		}
		else
		{
			$id = $gt[0]->gt_id;
			try {
				DB::update("UPDATE `gioi_thieu` SET `noidung` = ?, `id_admin_changed` = ?, `updated_at` = ? WHERE gt_id = ?",[$noidung,$idadmin,$time,$id]);
				return redirect()->back()->with(['alert' => 'Sửa thông tin giới thiệu thành công!']);
			} catch (\Exception $e) {
				return $e;
			}
		}
	}
}
