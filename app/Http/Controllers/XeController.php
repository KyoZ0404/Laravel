<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Xe;
use App\Models\Loaixe;
class XeController extends Controller
{
    //Phần xe
    public function xe(){
        $bus = DB::table('xe')->join('bus_model','xe.Mã_loại_xe','=','bus_model.Mã')
            ->select('xe.Mã','xe.Biển_số','xe.Mã_loại_xe','bus_model.Loại_ghế','xe.Ngày_bảo_trì_gần_nhất','xe.Ngày_bảo_trì_tiếp_theo','xe.location')->get();
        $typebuses = Loaixe::all();
        $typebus = [];
        foreach ($typebuses as $row){
            $typebus["{$row['Mã']}"]=$row['Tên_Loại'];
        }
        return view('quantrivien.xe',compact('bus','typebus'));
    }
    public function addxe($index = ""){
        $bustypes = DB::select("SELECT Mã,Tên_Loại,Loại_ghế FROM bus_model");
        if($index == ""){
            return view("quantrivien.addxe",["bustypes"=>$bustypes]);
        }
        try {
            $ttxes = DB::table('xe')
                ->where('xe.Mã','=',$index)
                ->select('xe.Mã','xe.Biển_số','xe.Mã_loại_xe','xe.Ngày_bảo_trì_gần_nhất','xe.Ngày_bảo_trì_tiếp_theo')->get();
            foreach ($ttxes as $row){
                $ttxe = $row;
            }
            return view("quantrivien.addxe",["ttxe" => $ttxe,"bustypes"=>$bustypes]);
        } catch (\Exception $e) {
            die("Lỗi: ".$e);
        }
    }
    public  function addbus(Request $request){
        $bienso = $request->bienso;
        $idtypebus = $request->idtypebus;
        $gannhat = $request->baotrigannhat;
        $tieptheo = $request->baotritieptheo;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(isset($request->ID)){
            if(DB::update("UPDATE `xe` SET `Biển_số`= ?,`Mã_loại_xe`= ?,`Ngày_bảo_trì_gần_nhất`= ?,`Ngày_bảo_trì_tiếp_theo`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$bienso,$idtypebus,$gannhat,$tieptheo,$updated_at,$request->ID]))
                return redirect()->back()->with('alert','Sửa thành công!');
            else
                return redirect()->back()->with('alert','Sửa thất bại!');
        }
        else {
            if( DB::insert("INSERT INTO `xe`(`Biển_số`, `Mã_loại_xe`, `Ngày_bảo_trì_gần_nhất`, `Ngày_bảo_trì_tiếp_theo`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?)",
                [$bienso,$idtypebus,$gannhat,$tieptheo,$created_at,$updated_at]))
            {
                return redirect()->back()->with('alert','Thêm thành công!');
            }
            else
                return redirect()->back()->with('alert','Thêm thất bại!');
        }
    }
    public function delbus($id){
        try {
            DB::delete('DELETE FROM xe WHERE Mã = ?',[$id]);
        } catch (\Exception $e) {
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
}
